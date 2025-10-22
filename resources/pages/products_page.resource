*** Settings ***
Library            Browser
Library            String
Library            Collections
Variables          locators/products_page.yaml

*** Keywords ***

Add item to cart
    [Arguments]    ${item name}
    ${lowercase itemname}=    String.Convert To Lower Case    ${item name}
    ${dash separated itemname}=    String.Replace String    ${lowercase itemname}    ${SPACE}    -
    #the following step is not mandatory, but I like to include it to make it more explicit what happens here
    ${add item locator}=    BuiltIn.Replace Variables   ${loc add item to cart by name}
    Browser.Click    ${add item locator}

Get current sorting
    ${current sorting order}=    Browser.Get Text    css=span.active_option
    IF    "${current sorting order}" == "Name (A to Z)"
        RETURN    az
    ELSE IF    "${current sorting order}" == "Name (Z to A)"
        RETURN    za
    ELSE IF    "${current sorting order}" == "Price (low to high)"
        RETURN    lohi
    ELSE IF    "${current sorting order}" == "Price (high to low)"
        RETURN    hilo
    END

Select sorting option
    [Arguments]    ${sorting type}
    IF    '${sorting type}' == 'az'
        VAR    ${sorting value}    ${loc sorting option value}[A to Z]
    ELSE IF    '${sorting type}' == 'za'
        VAR    ${sorting value}    ${loc sorting option value}[Z to A]
    ELSE IF    '${sorting type}' == 'lohi'
        VAR    ${sorting value}    ${loc sorting option value}[price asc]
    ELSE IF    '${sorting type}' == 'hilo'
        VAR    ${sorting value}    ${loc sorting option value}[price desc]
    END
    Browser.Select Options By    ${loc sorting dropdown}    value    ${sorting value}

Validate sorting
    [Arguments]    ${sorting type}
    @{items}=    BuiltIn.Create List
    IF    '${sorting type}' in ['az', 'za']
        @{item elements}=    Browser.Get Elements    ${loc item name label}
        FOR    ${element}    IN    @{item elements}
            ${item name}=    Browser.Get Text    ${element}
            ${item name}=    String.Convert To Lower Case    ${item name}
            Collections.Append To List    @{items}    ${item name}
        END
    ELSE IF    '${sorting type}' in ['lohi', 'hilo']
        @{item elements}=    Browser.Get Elements    ${loc item price label}
        FOR    ${element}    IN    @{item elements}
            ${item price}=    Browser.Get Text    ${element}
            ${price}=    String.Replace String    ${item price}    $    ${EMPTY}
            ${price}=    BuiltIn.Convert To Number   ${price}
            Collections.Append To List    ${items}    ${price}
        END
    END
    ${actual order items}=    Collections.Copy List    ${items}
    Collections.Sort List    ${items}
    IF    ${sorting type} in ['za', 'hilo']
        Collections.Reverse List    ${items}
    END
    BuiltIn.Should Be Equal    ${items}    ${actual order items}
    
