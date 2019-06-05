function addcheck(obj){
  var ts=$(obj).getParent().getParent().getLast().getFirst().value;


  

  if(obj.checked){
	  ts+=obj.value+';';
  }else{
	  var reg=eval('/'+obj.value+';/');
	  ts = ts.replace( reg, '' );
	 // ts.replace(obj.value+';','');
  }
$(obj).getParent().getParent().getLast().getFirst().value=ts;
}
function getRadio(obj){
var rvalue = '';
var len = obj.length;

if(len>1){
  for(var i=0;i<len;i++){
    if(obj[i].checked){
    rvalue=obj[i].value;
    break;
    }
    }
}else{
 rvalue=obj[0].value;
 }
return rvalue;
}
function showwindow(url){
window.open(url,'_blank','height=500, width=600, top=200, left=200, toolbar=no, menubar=no, scrollbars=yes, resizable=no,location=no, status=no');
return false;

}
function showwindow2(url){
 window.open(url,'_blank','height=800, width=1000, top=100, left=100, toolbar=no, menubar=no, scrollbars=yes, resizable=yes,location=no, status=no');
 return false;
}
function checkCHK(obj){
  var len = obj.length;
  var ttil = obj.title;
  var flag=false;
if(len>1){
  for(var i=0;i<len;i++){
     if(obj[i].checked){
      flag=true;}
    }
    if(flag==false){
      alert(title+"项必须选择一项");
      return false;
    }
}
}

	function setdateYM(obj){
	 if(obj.name.substring(obj.name.length-1,obj.name.length)=='y'){
	   if(obj.value.length>0&&obj.nextSibling.nextSibling.value.length>0){
	   obj.nextSibling.nextSibling.nextSibling.nextSibling.value=obj.value+"-"+obj.nextSibling.nextSibling.value;
	   }else{
	   obj.nextSibling.nextSibling.nextSibling.nextSibling.value="";
	   }
	 }
	 if(obj.name.substring(obj.name.length-1,obj.name.length)=='m'){
	  if(obj.previousSibling.previousSibling.value.length>0&&obj.value.length>0){
	   obj.nextSibling.nextSibling.value=obj.previousSibling.previousSibling.value+"-"+obj.value;
	   }else{
	   obj.nextSibling.nextSibling.value="";
	   }
	 }	 
	}
	
 
 function loadSelectOption(servletUrl, whereStatement, controlId, selectedName) {
	try {
		sendRequest(servletUrl,whereStatement,
			function __temp() {
				try {
					if (XMLHttpReq.readyState == 4 && XMLHttpReq.status == 200) {
					    text=XMLHttpReq.responseText;
					var xmlDoc;
					try{
					xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
					xmlDoc.async = false;
	
                     xmlDoc.loadXML(text);
			        	var _data = xmlDoc.getElementsByTagName("row");
			           
		       			document.getElementById(controlId).options.length = 0;
		       			document.getElementById(controlId).options.add(new Option("-=请选择=-", ""));
			       		for (var i = 0; i < _data.length; i++) {
			       			var _tempId = _data[i].childNodes[0].childNodes[1].text;
			       			var _tempName = _data[i].childNodes[1].childNodes[1].text;
			       			var _tempOption = new Option(_tempName, _tempId)
			       			if (_tempName == selectedName)
			       				_tempOption.selected = selectedName;
			       			document.getElementById(controlId).options.add(_tempOption);
			       		}                     
          }catch(e){
    parser=new DOMParser();
  
    xmlDoc=parser.parseFromString(text,"text/xml");
          
          var _data = xmlDoc.getElementsByTagName("row");
          
          		       			document.getElementById(controlId).options.length = 0;
		       			document.getElementById(controlId).options.add(new Option("-=请选择=-", ""));
			       		for (var i = 0; i < _data.length; i++) {
			       			var _tempId = _data[i].childNodes[0].childNodes[1].textContent;
			       			var _tempName = _data[i].childNodes[1].childNodes[1].textContent;
			       			var _tempOption = new Option(_tempName, _tempId)
			       			if (_tempName == selectedName)
			       				_tempOption.selected = selectedName;
			       			document.getElementById(controlId).options.add(_tempOption);
			       		}
      }    
          

			   		}
			   	} catch (e){}
			}
		);
	} catch (e) {}	
}
 
 
var xPos;
var yPos;

function showToolTip(msg,evt){
    if (evt) {
        var url = evt.target;
    }
    else {
        evt = window.event;
        var url = evt.srcElement;
    }
    xPos = evt.clientX;
    yPos = evt.clientY;

   var toolTip = document.getElementById("toolTip");
   toolTip.innerHTML = "<p>"+msg+"</p>";
   toolTip.style.top = parseInt(yPos)+2 + "px";
   toolTip.style.left = parseInt(xPos)+2 + "px";
   toolTip.style.visibility = "visible";
   
}

function hideToolTip(){
   var toolTip = document.getElementById("toolTip");
   toolTip.style.visibility = "hidden";
}

function  round(num,n)  
{var  dd=1;  
var  tempnum;  
for(i=0;i<n;i++)  
{  
dd*=10;  
}  
tempnum=num*dd;  
tempnum=Math.round(tempnum);  
//alert(tempnum/dd);  
return tempnum;
}  