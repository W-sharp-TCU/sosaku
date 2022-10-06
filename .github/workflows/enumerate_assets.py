import os


def main():
    for root, dirs, files in os.walk(top='../../assets/'):
        for file in files:
            file_path = os.path.join(root, file)
            file_path = file_path.replace('../../', '')
            print(f'filePath = {file_path}')


if __name__ == '__main__':
    main()
