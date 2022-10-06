import os


def main():
    for root, dir, files in os.walk(top='../../assets/'):
        for file in files:
            filePath = os.path.join(root, file)
            filePath = filePath.replace('../../', '')
            print(f'filePath = {filePath}')


if __name__ == '__main__':
    main()
