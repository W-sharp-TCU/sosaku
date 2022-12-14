# ######################## Requirement ######################## #
# Executed by GitHub Actions.                                   #
#                                                               #
# Google Cloud Service Account credential JSON value is saved   #
#   on environment variable named "CREDENTIAL_JSON".            #
#                                                               #
# Spread Sheet key of Google Sheets is saved on environment     #
#   variable named "SPREADSHEET_KEY".                           #
#                                                               #
# Dependent libraries: oauth2client, gspread, pytz              #
#                                                               #
# CurrentDirectory: <Flutter project root>/                     #
# Flutter Asset Directory: <Flutter project root>/assets/       #
# ############################################################# #

import os
import json

from google.oauth2.service_account import Credentials
import gspread
from datetime import datetime
import pytz

# ########################## Config #############################
SHEET_NAME = 'assets_list'
# Defines the correspondence between the directory path and the column number to write.
CATEGORIES = {
    #      "<Directory Path>":       '<Column Symbol>'
    "drawable/CharacterImage/Ayana/":       'A',
    "drawable/CharacterImage/Kawamoto/":    'B',
    "drawable/CharacterImage/Nonono/":      'C',
    "drawable/CharacterImage/Sakaki/":      'D',
    "drawable/Conversation/":               'E',
    "sound/AS":                             'F',
    "sound/BGM":                            'G',
    "sound/CV/":                            'H',
    # If "<<OTHER>>" is specified, files that did not match any of the above patterns
    # are written to the specified column.
    # "<<OTHER>>" must be specified at the end of the dictionary.
    "<<OTHER>>":                            'I'
}
EXCLUDE_FILES = [   # Files excluded from search
    "PlaceHolder"
]
ONLY_FILES_WITH_EXTENSIONS = True   # Enumerate only files with extensions
# ###############################################################


def main():
    start_row = 5
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
    workbook.values_clear(f"'{SHEET_NAME}'!A{start_row}:Z1000")

    # Write "Now writing..."
    worksheet.update_cell(1, 1, "Now writing... Please wait.")

    # Write information source branch
    worksheet.update_cell(1, 2, f"情報取得元Gitブランチ : {os.environ.get('GITHUB_REF_NAME')}")

    # Enumerate path of asset files.
    cols = collect_file_path(CATEGORIES)

    # Write file paths to Google Sheets.
    for key in CATEGORIES:
        worksheet.update_acell(f"{CATEGORIES[key]}{start_row}", key)  # write header
    for key in cols:
        write_sheet(worksheet, CATEGORIES[key], cols[key], start_row=start_row+1)   # write values

    # Write the end of editing time.
    cur_date = datetime.now(pytz.timezone('Asia/Tokyo'))
    worksheet.update_cell(1, 1, f"最終更新 : {cur_date.strftime('%Y/%m/%d %H:%M:%S')}")


def collect_file_path(category_list):
    """Search path of asset files and append it to each list.

    Args:
        category_list (dict[str, str]) : List defining the correspondence
        between the patterns in categorization and the columns to be written.
    """
    cols = {}
    for root, dirs, files in os.walk(top='assets/'):
        # Add only files to list.
        for file in files:
            if ONLY_FILES_WITH_EXTENSIONS is True and '.' not in file:
                continue
            if file in EXCLUDE_FILES:    # if it is one of the exclude files
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

    Args:
        worksheet (gspread.Worksheet): Target worksheet
        col (str): Target column symbol (e.g. 'B')
        value (list[str]): Value to be written on {col}{start_row}:{col}{len(value)} at {worksheet}.
        start_row (int): The number of row that this func starts writing at.
    """
    end_row = start_row - 1 + len(value)
    cells = worksheet.range(f'{col}{start_row}:{col}{end_row}')
    index = 0
    for cell in cells:
        cell.value = value[index]
        index = index + 1
    worksheet.update_cells(cells)


if __name__ == '__main__':
    main()
