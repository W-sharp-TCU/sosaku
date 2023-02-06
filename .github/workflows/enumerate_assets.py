# ######################## Requirement ######################## #
# Executed by GitHub Actions.                                   #
#                                                               #
# Google Cloud Service Account credential JSON value is saved   #
#   on environment variable named "CREDENTIAL_JSON".            #
#                                                               #
# Spread Sheet key of Google Sheets is saved on environment     #
#   variable named "SPREADSHEET_KEY".                           #
#                                                               #
# Dependent libraries: see 'python_requirements.txt'            #
#                                                               #
# CurrentDirectory: {Flutter project root}/                     #
# Flutter Asset Directory: {Flutter project root}/assets/       #
# ############################################################# #


import json
import os
import sys
from datetime import datetime

import gspread
import pytz
from google.oauth2.service_account import Credentials
import yaml

# ########################## Config #############################
SHEET_NAME = 'assets_list'
# Defines the correspondence between the directory path and the column number to write.
CATEGORIES = {
    #      "<Directory Path>":       '<Column Symbol>'
    "drawable/CharacterImage/Ayana/": 'A',
    "drawable/CharacterImage/Kawamoto/": 'B',
    "drawable/CharacterImage/Nonono/": 'C',
    "drawable/CharacterImage/Sakaki/": 'D',
    "drawable/Conversation/": 'E',
    "sound/AS": 'F',
    "sound/BGM": 'G',
    "sound/CV/": 'H',
    # If "<<OTHER>>" is specified, files that did not match any of the above patterns
    # are written to the specified column.
    # "<<OTHER>>" must be specified at the end of the dictionary.
    "<<OTHER>>": 'I'
}
EXCLUDE_FILES = [  # Files excluded from search (regular expression is available)
    "PlaceHolder"
]
ONLY_FILES_WITH_EXTENSIONS = True  # Enumerate only files with extensions
PARAMETERS_FILE_PATH = 'assets/scenario_data_parameters.yaml'
# ###############################################################


HEADER_ROW = 5
UPDATE_INFO_CELL = ['A1', 'A2', 'A3']


def main():
    args = sys.argv
    if len(args) >= 2:
        for index, arg in enumerate(args):
            print(index, arg)
    else:
        print("No argument.")
    # [ Authorize ]
    scope = ['https://www.googleapis.com/auth/spreadsheets',
             'https://www.googleapis.com/auth/drive']

    # Get Credential JSON.
    info = json.loads(os.environ.get("CREDENTIAL_JSON"))
    credentials = Credentials.from_service_account_info(
        info=info, scopes=scope)

    # Login to Google API using OAuth2 credentials.
    gc = gspread.authorize(credentials)

    # [ Open target sheet ]
    # Open Google Sheet.
    workbook = gc.open_by_key(os.environ.get("SPREADSHEET_KEY"))

    # Open work sheet
    worksheet = workbook.worksheet(SHEET_NAME)

    # [ Edit sheet cells ]
    # Clear cells
    workbook.values_clear(f"'{SHEET_NAME}'!A{HEADER_ROW}:Z1000")

    # Write "Now writing..."
    worksheet.update_cell(1, 1, "Now writing... Please wait.")

    # Write information source branch
    worksheet.update_cell(
        1, 2, f"情報取得元Gitブランチ : {os.environ.get('GITHUB_REF_NAME')}")

    # Enumerate path of asset files.
    cols = collect_file_path(CATEGORIES)

    # Write file paths to Google Sheets.
    for key in CATEGORIES:
        worksheet.update_acell(
            f"{CATEGORIES[key]}{HEADER_ROW}", key)  # write header
    for key in cols:
        # write values
        write_sheet(worksheet, CATEGORIES[key],
                    cols[key], start_row=HEADER_ROW + 1)

    # Write the end of editing time.
    cur_date = datetime.now(pytz.timezone('Asia/Tokyo'))
    worksheet.update_cell(
        1, 1, f"最終更新 : {cur_date.strftime('%Y/%m/%d %H:%M:%S')}")


def collect_file_path(category_list):
    """Search path of asset files and append it to each list.

    :param category_list: List defining the correspondence between the patterns in categorization
    and the columns to be written.
    :type category_list: dict[str, str]
    """
    cols = {}
    for root, dirs, files in os.walk(top='assets/'):
        # Add only files to list.
        for file in files:
            if ONLY_FILES_WITH_EXTENSIONS is True and '.' not in file:
                continue
            if file in EXCLUDE_FILES:  # if it is one of the exclude files
                continue
            file_path = os.path.join(root, file)
            file_path = file_path.replace('../', '')
            file_path = file_path.replace('\\', '/')  # for Windows
            # Categorize assets files.
            for key in category_list:
                if key == "<<OTHER>>":
                    if key not in cols:
                        cols[key] = []
                    cols[key].append(file_path)  # append to <<OTHER>> list.
                    break
                elif key in file_path:
                    if key not in cols:
                        cols[key] = []
                    cols[key].append(file_path)  # append to each key's list.
                    break
    return cols


def write_sheet(worksheet, col, value, start_row):
    """Write value list to worksheet row.

    :param worksheet: Target worksheet object
    :type worksheet: gspread.Worksheet

    :param col: Target column symbol (e.g. 'B')
    :type col: str

    :param value: Value to be written on {col}{start_row}:{col}{len(value)} at {worksheet}.
    :type value: list[str]

    :param start_row: The number of row that this func starts writing at.
    :type start_row: int
    """
    end_row = start_row - 1 + len(value)
    cells = worksheet.range(f'{col}{start_row}:{col}{end_row}')
    index = 0
    for cell in cells:
        cell.value = value[index]
        index = index + 1
    worksheet.update_cells(cells)


def load_parameters():
    """Load scenario data parameters.

    :return: parameters dictionary
    :rtype: dict | None
    """
    try:
        with open(file=PARAMETERS_FILE_PATH, mode='r', encoding='utf-8') as file:
            return yaml.safe_load(file)
    except Exception as e:
        print('Exception occurred while loading YAML...', file=sys.stderr)
        print(e, file=sys.stderr)
        return None


if __name__ == '__main__':
    main()
