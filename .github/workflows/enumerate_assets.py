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
SHEET_NAME = 'assets'
START_ROW = 3
# Category list of enumerate
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
    "<<OTHER>>":                            'I'
}
EXCLUDE_FILES = [
    "PlaceHolder"
]
ONLY_FILES_WITH_EXTENSIONS = False
# ###############################################################


def main():
    # [ Authorize ]
    scope = ['https://www.googleapis.com/auth/spreadsheets',
             'https://www.googleapis.com/auth/drive']

    # Get Credential JSON.
    info = json.loads(os.environ.get("CREDENTIAL_JSON"))
    credentials = Credentials.from_service_account_info(
        info=info, scopes=scope)

    # Login to Google API using OAuth2 credentials.
    gc = gspread.authorize(credentials)

    # Open Google Sheet.
    workbook = gc.open_by_key(os.environ.get("SPREADSHEET_KEY"))

    # [ Configure control target ]
    # Get sheets list.
    # worksheets = workbook.worksheets()
    # print(worksheets)

    # Open work sheet
    worksheet = workbook.worksheet(SHEET_NAME)

    # [ Edit sheet cells ]
    # Clear cells
    workbook.values_clear(f"'{SHEET_NAME}'!A{START_ROW}:Z1000")

    # Write the edit start time.
    worksheet.update_cell(1, 1, '最終更新 : ')
    worksheet.update_cell(1, 2, str(datetime.now(pytz.timezone('Asia/Tokyo'))))

    # Enumerate path of asset files.
    cols = collect_file_path(CATEGORIES)

    # Write file paths to Google Sheets.
    for key in cols:
        worksheet.update_acell(f"{CATEGORIES[key]}{START_ROW}", key)  # write header
        write_sheet(worksheet, CATEGORIES[key], cols[key], start_row=START_ROW+1)   # write values


def collect_file_path(category_list):
    """Search path of asset files and append it to each list.

    Args:
        category_list (dict[str, str]) : List defining the correspondence
        between the keys of the sort and the columns to be written.
    """
    cols = {}
    for root, dirs, files in os.walk(top='assets/'):
        # Add only files to list.
        for file in files:
            print(f"{file=}")
            if ONLY_FILES_WITH_EXTENSIONS is True and '.' not in file:
                print("No Extension")
                continue
            if file in EXCLUDE_FILES:    # if it is one of the exclude files
                print("Exclude File")
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


def write_sheet(worksheet, col, value, start_row=START_ROW):
    """Write value list to worksheet row.

    Args:
        worksheet (gspread.Worksheet): Target worksheet
        col (str): Target row (e.g. 'B')
        value (list[str]): Value to be written on worksheet
        start_row (int):
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
