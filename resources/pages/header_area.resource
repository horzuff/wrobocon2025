*** Settings ***
Library            Browser
Library            String
Library            Collections
Variables          locators\header_area.yaml

*** Keywords ***

Go to shopping cart
    Browser.Click    ${loc shopping cart button}

Expand options
    Browser.Click    ${loc menu button}

Logout
    Expand options
    Browser.Click    ${loc logout button}

Open About
    Expand options
    Browser.Click    ${loc about button}

Go to All Items
    Expand options
    Browser.Click    ${loc all items button}

Reset App State
    Expand options
    Browser.Click    ${loc reset app button}