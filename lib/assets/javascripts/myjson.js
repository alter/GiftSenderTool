function getHTTPObject() 
{ 
    if (typeof XMLHttpRequest != 'undefined') 
    { 
        return new XMLHttpRequest(); 
    } 
    try 
    { 
        return new ActiveXObject("Msxml2.XMLHTTP"); 
    } 
    catch (e) 
    { 
        try 
        { 
            return new ActiveXObject("Microsoft.XMLHTTP"); 
        } 
        catch (e) {} 
    } 
    return false; 
}

function sendjson()
{
ajax = getHTTPObject();
var formData = form2object('myForm');
var jsonData = JSON.stringify(formData);
ajax.open("POST", "/admin/json", true);
ajax.setRequestHeader("Content-type", "application/json");
ajax.setRequestHeader("Content-length", jsonData.length);
ajax.setRequestHeader("Connection", "close");
ajax.send(jsonData);
}
