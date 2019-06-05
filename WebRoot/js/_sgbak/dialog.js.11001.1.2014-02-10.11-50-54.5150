var MB_OK = 0;
var MB_CANCEL = 1;
var MB_OKCANCEL = 2;
var MB_YES = 3;
var MB_NO = 4;
var MB_YESNO = 5;
var MB_YESNOCANCEL = 6;
// 控制按钮文本
var MB_OK_TEXT = "确定";
var MB_CANCEL_TEXT = "取消";
var MB_YES_TEXT = " 是 ";
var MB_NO_TEXT = " 否 ";
//提示图标
var MB_ICON = "/images/information.gif";
//委托方法
var MB_OK_METHOD = null;
var MB_CANCEL_METHOD = null;
var MB_YES_METHOD = null;
var MB_NO_METHOD = null;
var MB_BACKCALL = null;
var MB_STR = '<div id="msgBoxMask" class="msgbox_mask" style="position:absolute;z-index:100000;filter: alpha(opacity=0);display:none;"></div>' +
			'<div class="msgbox" style="position:absolute;display:none; z-index:100001;" id="msgBox">' +
			'<div class="msgbox_title" id="msgBoxTitle"></div>' +
			'<div class="msgbox_icon" id="msgBoxIcon"></div>' +
			'<div class="msgbox_content" id="msgBoxContent"></div>' +
			'<div class="msgbox_control" id="msgBoxControl"></div></div>';
var Timer = null;
document.write(MB_STR);
var icon = new Image();
icon.src = MB_ICON;
/* 提示对话框
 * 参数 1 : 提示内容
 * 参数 2 : 提示标题
 * 参数 3 : 图标路径
 * 参数 4 : 按钮类型
*/
function MessageBox(){
   var _content = arguments[0] || "这是一个对话框！";
   var _title   = arguments[1] || "提示";
   var _icon    = arguments[2] || MB_ICON;
   var _button  = arguments[3] || MB_OK;
   MB_BACKCALL  = arguments[4];
   
   var _iconStr = '<img src="{0}">';
   var _btnStr  = '<input name="{0}" id="{0}" type="button" class="msgbox_button" value="{1}" onclick="MBMethod(this)" />';
   
   
   switch(_button)
   {      
	  case MB_CANCEL      : _btnStr = _btnStr.toFormatString("msgBoxBtnCancel", MB_CANCEL_TEXT); break;
	 
	  case MB_YES         : _btnStr = _btnStr.toFormatString("msgBoxBtnYes", MB_YES_TEXT); break;
	  
	  case MB_NO          : _btnStr = _btnStr.toFormatString("msgBoxBtnNo", MB_NO_TEXT); break;
	  
	  case MB_OKCANCEL    : 
	       _btnStr = _btnStr.toFormatString("msgBoxBtnOk", MB_OK_TEXT) + "&nbsp;&nbsp;" +
 		             _btnStr.toFormatString("msgBoxBtnCancel", MB_CANCEL_TEXT); 
		   break;
		   
	  case MB_YESNO       :
	        _btnStr = _btnStr.toFormatString("msgBoxBtnYes", MB_YES_TEXT) + "&nbsp;&nbsp;" +
		              _btnStr.toFormatString("msgBoxBtnNo", MB_NO_TEXT); 
		    break;
		 
	  case MB_YESNOCANCEL :
	        _btnStr = _btnStr.toFormatString("msgBoxBtnYes", MB_YES_TEXT) + "&nbsp;&nbsp;" +
		              _btnStr.toFormatString("msgBoxBtnNo", MB_NO_TEXT) + "&nbsp;&nbsp;" +
					  _btnStr.toFormatString("msgBoxBtnCancel", MB_CANCEL_TEXT); 
		    break;
	     
	  default :  _btnStr = _btnStr.toFormatString("msgBoxBtnOk", MB_OK_TEXT);  break;  
	  
   }
   //解决　FF 下会复位
   ScrollTop = GetBrowserDocument().scrollTop; 
   ScrollLeft = GetBrowserDocument().scrollLeft; 
   GetBrowserDocument().style.overflow = "hidden";
   GetBrowserDocument().scrollTop = ScrollTop;   
   GetBrowserDocument().scrollLeft = ScrollLeft; 
      
   $("msgBoxTitle").innerHTML = _title;
   $("msgBoxIcon").innerHTML = _iconStr.toFormatString(_icon);
   $("msgBoxContent").innerHTML = _content; 
   $("msgBoxControl").innerHTML =  _btnStr;
   
   OpacityValue = 0;
   $("msgBox").style.display = "";	   
   try{$("msgBoxMask").filters("alpha").opacity = 0;}catch(e){};
   $("msgBoxMask").style.opacity = 0;
   $("msgBoxMask").style.display = "";
   $("msgBoxMask").style.height = GetBrowserDocument().scrollHeight + "px";
   $("msgBoxMask").style.width = GetBrowserDocument().scrollWidth + "px";
   
   Timer = setInterval("DoAlpha()",1);
   //设置位置   
   //$("msgBox").style.width = "100%";   
   //$("msgBox").style.width = ($("msgBoxIcon").offsetWidth + $("msgBoxContent").offsetWidth + 2) + "px";
   
   //$("msgBox").style.marginTop = (-$("msgBox").offsetHeight/2 + GetBrowserDocument().scrollTop) + "px";
   //$("msgBox").style.marginLeft = (-$("msgBox").offsetWidth/2 + GetBrowserDocument().scrollLeft) + "px";   
   
   if(_button == MB_OK || _button == MB_OKCANCEL){
     $("msgBoxBtnOk").focus();
   }else if(_button == MB_YES || _button == MB_YESNO || _button == MB_YESNOCANCEL){
	   $("msgBoxBtnYes").focus();
   }  
}
var OpacityValue = 0;
var ScrollTop = 0;
var ScrollLeft = 0;
function GetBrowserDocument()
{
   var _dcw = document.documentElement.clientHeight;
   var _dow = document.documentElement.offsetHeight;
   var _bcw = document.body.clientHeight;
   var _bow = document.body.offsetHeight;
   
   if(_dcw == 0) return document.body;
   if(_dcw == _dow) return document.documentElement;
   
   if(_bcw == _bow && _dcw != 0) 
     return document.documentElement;
   else
     return document.body;
}
function SetOpacity(obj,opacity){
		if(opacity >=1 ) opacity = opacity / 100;	
			
		try{obj.style.opacity = opacity; }catch(e){}
		
		try{ 
			if(obj.filters){
				obj.filters("alpha").opacity = opacity * 100;
			}
			
		}catch(e){}
}
	
function DoAlpha(){
	if (OpacityValue > 20){clearInterval(Timer);return 0;}
	OpacityValue += 5;	
	SetOpacity($("msgBoxMask"),OpacityValue);
}
function MBMethod(obj)
{   
   switch(obj.id)
   {
      case "msgBoxBtnOk" : if(MB_BACKCALL) {MB_BACKCALL(MB_OK);} else {if(MB_OK_METHOD) MB_OK_METHOD();} break;
	  case "msgBoxBtnCancel" : if(MB_BACKCALL) {MB_BACKCALL(MB_CANCEL);} else {if(MB_CANCEL_METHOD) MB_CANCEL_METHOD();} break;
	  case "msgBoxBtnYes" : if(MB_BACKCALL) {MB_BACKCALL(MB_YES);} else {if(MB_YES_METHOD) MB_YES_METHOD();} break;
	  case "msgBoxBtnNo" : if(MB_BACKCALL) {MB_BACKCALL(MB_NO);} else {if(MB_NO_METHOD) MB_NO_METHOD();} break;
   }   
   
   MB_OK_METHOD = null;
   MB_CANCEL_METHOD = null;
   MB_YES_METHOD = null;
   MB_NO_METHOD = null;
   MB_BACKCALL = null;
   
   MB_OK_TEXT = "确定";
   MB_CANCEL_TEXT = "取消";
   MB_YES_TEXT = " 是 ";
   MB_NO_TEXT = " 否 ";
   
   $("msgBox").style.display = "none";  
   $("msgBoxMask").style.display = "none";     
   GetBrowserDocument().style.overflow = ""; 
   GetBrowserDocument().scrollTop = ScrollTop;
   GetBrowserDocument().scrollLeft = ScrollLeft; 
}
String.prototype.toFormatString = function(){  
   var _str = this;
   for(var i = 0; i < arguments.length; i++){    
      _str = eval("_str.replace(/\\{"+ i +"\\}/ig,'" + arguments[i] + "')");
   }
   return _str;
}
