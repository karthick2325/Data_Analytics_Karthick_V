import requests
url="https://www.google.com/?zx=1790682586120"
from bs4 import BeautifulSoup

responce=requests,get(url)
print(responce.status_code)

soup=   BeautifulSoup(
    responce.text,
    "html.parser"
)

print(soup.title,text)