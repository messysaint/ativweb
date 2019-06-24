/*******************************************************************/
/* 
/* Validate Add New Vehicle Form
/*
/*******************************************************************/

function selectParamName( elementId ) {
	
	var elt = document.getElementById(elementId);

    if (elt.selectedIndex == -1)
        return null;

    alert( elt.options[elt.selectedIndex].text );
    
    return elt.options[elt.selectedIndex].text;

	
	
}




















