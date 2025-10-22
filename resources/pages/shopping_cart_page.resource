*** Settings ***
Library            Browser
Variables          locators${/}shopping_cart_page.yaml

*** Keywords ***
Go to checkout
    Browser.Click    ${loc go to checkout button}