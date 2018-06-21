import sys
import requests


def main():
    print(requests.get('https://google.co.uk').text)

    print("Welcome to a self executable archive!")
    print("You are running on python {0}".format(sys.version))


if __name__ == '__main__':
    main()
