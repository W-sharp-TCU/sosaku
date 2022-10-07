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

# Config
EDIT_POSITION = {
    "last_modified": "B1",
    "start_cul": 3
}


character_images = []
background_images = []
atmosphere_sounds = []
background_sounds = []
character_voices = []
ui_sounds = []
others = []


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
    worksheet = workbook.worksheet('assets')

    # [ Edit sheet cells ]
    # Clear cells
    worksheet.batch_clear([f'A{EDIT_POSITION["start_cul"]}:Z1000', 'my_range'])

    # # Write the edit start time.
    # worksheet.update_acell(EDIT_POSITION['last_modified'],
    #                        str(datetime.now(pytz.timezone('Asia/Tokyo'))))
    #
    # # Enumerate path of asset files.
    # collect_file_path()
    #
    # # Write file paths to Google Sheets.
    # write_sheet(worksheet, 'A', character_images)
    # write_sheet(worksheet, 'B', background_images)


def collect_file_path():
    """Search path of asset files and append it to each list.

    Prerequisite: Define following lists.
        character_images:list[str] = []
        background_images:list[str] = []
        atmosphere_sounds:list[str] = []
        background_sounds:list[str] = []
        character_voices:list[str] = []
        ui_sounds:list[str] = []
        others:list[str] = []
    """
    for root, dirs, files in os.walk(top='assets/'):
        # Add only files to list.
        for file in files:
            file_path = os.path.join(root, file)
            file_path = file_path.replace('../', '')
            file_path = file_path.replace('\\', '/')    # for Windows
            # Categorize assets files.
            if 'drawable/CharacterImage/' in file_path:
                character_images.append(file_path)
            elif 'drawable/Conversation/' in file_path:
                background_images.append(file_path)
            elif 'sound/CV/' in file_path:
                character_voices.append(file_path)


def write_sheet(worksheet, row, value):
    """Write value list to worksheet row.

    Args:
        worksheet (gspread.Worksheet): Target worksheet
        row (str): Target row (e.g. 'B')
        value (list[str]): Value to be written
    """
    start_cul = EDIT_POSITION['start_cul']
    end_cul = start_cul - 1 + len(value)
    cells = worksheet.range(f'{row}{start_cul}:{row}{end_cul}')
    index = 0
    for cell in cells:
        cell.value = value[index]
        index = index + 1
    worksheet.update_cells(cells)


if __name__ == '__main__':
    main()
