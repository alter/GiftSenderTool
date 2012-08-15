function test()
{
    var formData = form2object('myForm');

document.getElementById('testArea').innerHTML = JSON.stringify(formData, null, '\t');
}
