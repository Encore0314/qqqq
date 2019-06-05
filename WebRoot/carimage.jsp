<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.arch.event.*"%>
<%@ page import="com.arch.util.*"%>
<%@ page import="com.arch.basebean.OracleRowSet"%>
<%
EventResponse eventResponse = (EventResponse) request.getAttribute("result");

OracleRowSet[] ors=new OracleRowSet[1];
ors[0]=new OracleRowSet(50);
OracleRowSet[] ors1=new OracleRowSet[1];
ors1[0]=new OracleRowSet(50);
OracleRowSet[] ors2=new OracleRowSet[1];
ors2[0]=new OracleRowSet(50);
OracleRowSet[] ors3=new OracleRowSet[1];
ors3[0]=new OracleRowSet(50);
HashMap data=null,olddata=null;
if(eventResponse!=null){
     data=(HashMap)eventResponse.getBody();
     ors=(OracleRowSet[])data.get("operation1");
     ors1=(OracleRowSet[])data.get("operation2");
     ors2=(OracleRowSet[])data.get("operation3");
      ors3=(OracleRowSet[])data.get("operation4");

     olddata=(HashMap)((HashMap)eventResponse.getOriginBody()).get("operation1");
}
 FormUtil futil=new FormUtil();
 String fid=Azdg.encryptsubmit("fid=carimage.xml@doupdate",SysConst.FORMACTION);
	
%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<META HTTP-EQUIV="pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
<META HTTP-EQUIV="expires" CONTENT="0">
<script type="text/javascript" src="js/mootools-core-1.5.0-full-compat.js"></script>
<script type="text/javascript" src="js/mootools-more-1.5.0.js"></script>
<script>

var imgid;
var carinfo1=new Array();

var mosaic={x:10,y:10};
var imageData;
var pixelArray;
var yImg;

function doshow()
{
	showbigimg($('img'+imgid));
	pain();
	$('showi').setStyle("display","block");
	$('showb').setStyle("display","none");
	
	
}
function pain() {
    var paint={
        init:function()
        {
            this.load();
            
        },
        load:function()
        {   
            this.x=[];//记录鼠标移动是的X坐标
            this.y=[];//记录鼠标移动是的Y坐标
            this.clickDrag=[];
            this.lock=false;//鼠标移动前，判断鼠标是否按下
            this.isEraser=false;
            //this.Timer=null;//橡皮擦启动计时器
            //this.radius=5;
            this.storageColor="#000000";
            this.eraserRadius=15;//擦除半径值
            this.color=["#000000","#FF0000","#80FF00","#00FFFF","#808080","#FF8000","#408080","#8000FF","#CCCC00"];//画笔颜色值
            this.fontWeight=[2,5,8];
            this.$=function(id){return typeof id=="string"?document.getElementById(id):id;};
            this.canvas=this.$("canvas");
            if (this.canvas.getContext) {
            } else {
                alert("您的浏览器不支持 canvas 标签");
                return;
            }
            this.cxt=this.canvas.getContext('2d');
            this.cxt.lineJoin = "round";//context.lineJoin - 指定两条线段的连接方式
            this.cxt.lineWidth = 5;//线条的宽度
            this.iptClear=this.$("clear");
            this.revocation=this.$("revocation");
            this.imgurl=this.$("imgurl");//图片路径按钮
            this.w=this.canvas.width;//取画布的宽
            this.h=this.canvas.height;//取画布的高 
            this.touch =("createTouch" in document);//判定是否为手持设备
            this.StartEvent = this.touch ? "touchstart" : "mousedown";//支持触摸式使用相应的事件替代
	        this.MoveEvent = this.touch ? "touchmove" : "mousemove";
	        this.EndEvent = this.touch ? "touchend" : "mouseup";
	        this.bind();
	  
        },
        bind:function()
        {
            var t=this;
            /*清除画布*/
            this.iptClear.onclick=function()
            {
                t.clear();
            };
          /*鼠标按下事件，记录鼠标位置，并绘制，解锁lock，打开mousemove事件*/
            this.canvas['on'+t.StartEvent]=function(e)
            {   
                var touch=t.touch ? e.touches[0] : e; 
                var _x=touch.clientX - touch.target.offsetLeft;//鼠标在画布上的x坐标，以画布左上角为起点
                var _y=touch.clientY - touch.target.offsetTop;//鼠标在画布上的y坐标，以画布左上角为起点             
                if(t.isEraser)
                {
                /*
                    t.cxt.globalCompositeOperation = "destination-out";
                    t.cxt.beginPath();
                    t.cxt.arc(_x, _y,t.eraserRadius, 0, Math.PI * 2);
                    t.cxt.strokeStyle = "rgba(250,250,250,0)";
                    t.cxt.fill();
                    t.cxt.globalCompositeOperation = "source-over";
                    */
                    t.resetEraser(_x,_y,touch);
                }else
                {


                  for(var m=_x;m<_x+1;m++){
		for(var n=_y;n<_y+1;n++){
		    var num=Math.random();
			var randomPixel={x:Math.floor(num*mosaic.x+m),y:Math.floor(num*mosaic.y+n)};
			
			t.cxt.fillStyle="rgba("+pixelArray[(randomPixel.y*yImg.width+randomPixel.x)*4+0]+","+pixelArray[(randomPixel.y*yImg.width+randomPixel.x)*4+1]+","+pixelArray[(randomPixel.y*yImg.width+randomPixel.x)*4+2]+","+pixelArray[(randomPixel.x*yImg.width+randomPixel.y)*4+3]+")";
			t.cxt.fillRect(m,n,mosaic.x,mosaic.y);
			
		}  }
                }
                t.lock=true;
            };
            /*鼠标移动事件*/
            this.canvas['on'+t.MoveEvent]=function(e)
            {
                var touch=t.touch ? e.touches[0] : e;
                if(t.lock)//t.lock为true则执行
                {
                    var _x=touch.clientX - touch.target.offsetLeft;//鼠标在画布上的x坐标，以画布左上角为起点
                    var _y=touch.clientY - touch.target.offsetTop;//鼠标在画布上的y坐标，以画布左上角为起点
                    if(t.isEraser)
                    {
                        //if(t.Timer)clearInterval(t.Timer);
                        //t.Timer=setInterval(function(){
                            t.resetEraser(_x,_y,touch);
                        //},10);
                    }
                    else
                    {
                        for(var m=_x;m<_x+1;m++){
		for(var n=_y;n<_y+1;n++){
		    var num=Math.random();
			var randomPixel={x:Math.floor(num*mosaic.x+m),y:Math.floor(num*mosaic.y+n)};
			
			t.cxt.fillStyle="rgba("+pixelArray[(randomPixel.y*yImg.width+randomPixel.x)*4+0]+","+pixelArray[(randomPixel.y*yImg.width+randomPixel.x)*4+1]+","+pixelArray[(randomPixel.y*yImg.width+randomPixel.x)*4+2]+","+pixelArray[(randomPixel.x*yImg.width+randomPixel.y)*4+3]+")";
			t.cxt.fillRect(m,n,mosaic.x,mosaic.y);
			
		}  
                    }}
                }
            };
            this.canvas['on'+t.EndEvent]=function(e)
            {
                /*重置数据*/
                t.lock=false;
                t.x=[];
                t.y=[];
                t.clickDrag=[];
                clearInterval(t.Timer);
                t.Timer=null;
                
            };
            this.revocation.onclick=function()
            {
                t.redraw();
            };
            this.changeColor();
            this.imgurl.onclick=function()
            {
                t.getUrl(event);
            };
            /*橡皮擦*/
            this.$("eraser").onclick=function(e)
	        {
	            t.isEraser=true;
                t.$("error").style.color="red";
                t.$("error").innerHTML="您已使用橡皮擦！";
	        };
        },
        movePoint:function(x,y,dragging)
        {   
            /*将鼠标坐标添加到各自对应的数组里*/
            this.x.push(x);
            this.y.push(y);
            this.clickDrag.push(y);
        },
        drawPoint:function(x,y,radius)
        {
             for(var i=0; i < this.x.length; i++)//循环数组
            {   
                this.cxt.beginPath();//context.beginPath() , 准备绘制一条路径
                
                if(this.clickDrag[i] && i){//当是拖动而且i!=0时，从上一个点开始画线。
                    this.cxt.moveTo(this.x[i-1], this.y[i-1]);//context.moveTo(x, y) , 新开一个路径，并指定路径的起点
                }else{
                    this.cxt.moveTo(this.x[i]-1, this.y[i]);
                }
                this.cxt.lineTo(this.x[i], this.y[i]);//context.lineTo(x, y) , 将当前点与指定的点用一条笔直的路径连接起来
                this.cxt.closePath();//context.closePath() , 如果当前路径是打开的则关闭它
                this.cxt.stroke();//context.stroke() , 绘制当前路径
            }
        },
        clear:function()
        {
            this.cxt.clearRect(0, 0, this.w, this.h);//清除画布，左上角为起点
        },
       redraw:function()
        {
            /*撤销*/
            window.location.reload();
            //this.cxt.restore();  
            
        },  
        preventDefault:function(e){
            /*阻止默认*/
            var touch=this.touch ? e.touches[0] : e;
		    if(this.touch)touch.preventDefault();
		    else window.event.returnValue = false;
	    },
	    changeColor:function()
	    {
	        /*为按钮添加事件*/
	        var t=this,iptNum=this.$("color").getElementsByTagName("input"),fontIptNum=this.$("font").getElementsByTagName("input");
	        for(var i=0,l=iptNum.length;i<l;i++)
	        {
	            iptNum[i].index=i;
	            iptNum[i].onclick=function()
	            {
	                     if(iptNum[this.index].getAttribute("class")=='i1')
	                {
	                    t.cxt.lineWidth=12;
	                }
	                  if(iptNum[this.index].getAttribute("class")=='i2')
	                {
	                    t.cxt.lineWidth=2;
	                }
	                    if(iptNum[this.index].getAttribute("class")=='i3')
	                {
	                    t.cxt.lineWidth=5;
	                }
	                t.cxt.save();
	                t.cxt.fillStyle=t.color[this.index];  //填充的颜色
	                //t.cxt.strokeStyle = t.color[this.index];
	                t.storageColor=t.color[this.index];
	                t.$("error").style.color="#000";
	                t.$("error").innerHTML="如果有错误，请使用橡皮擦：";
	                t.cxt.strokeStyle = t.storageColor;
	                t.isEraser=false;
	            }
	        }
	        for(var i=0,l=fontIptNum.length;i<l;i++)
	        {
	            t.cxt.save();
	            fontIptNum[i].index=i;
	            fontIptNum[i].onclick=function()
	            {
	                t.changeBackground(this.index);
	                t.cxt.lineWidth = t.fontWeight[this.index];
	                t.$("error").style.color="#000";
	                t.$("error").innerHTML="如果有错误，请使用橡皮擦：";
	                t.isEraser=false;
	                t.cxt.strokeStyle = t.storageColor;
	            }
	        }
	    },
	    changeBackground:function(num)
	    {
	        /*添加画笔粗细的提示背景颜色切换，灰色为当前*/
	        var fontIptNum=this.$("font").getElementsByTagName("input");
	        for(var j=0,m=fontIptNum.length;j<m;j++)
            {
                fontIptNum[j].className="";
                if(j==num) fontIptNum[j].className="grea";
            }
	    },
	    getUrl:function(evt)
	    {
	       var data =this.canvas.toDataURL();
	        var b64 = data.substring(22); 
	       // (new Element('iframe',{'id':'iframe1'})).inject($('body1'));
	       var offset = {};
	       			offset.top = $(evt.target).getPosition().y;
			offset.left = $(evt.target).getPosition().x;
			$('waiting').set( {
				'styles' : {
					'position' : 'absolute',
					'top' : offset.top,
					'left' : offset.left,
					'width' : $(evt.target).getStyle('width').toInt()
				}
			});
			$('waiting').setStyle('display', 'block');
	        $('iframe1').empty();
	        				$('iframe1').removeEvents('load');
				$('iframe1')
						.addEvent(
								'load',
								function() {
									$('waiting').setStyle('display', 'none');
									var r = this.contentWindow.document.body.innerHTML;
									if (r.indexOf("成功")>=0) {
										
										
										   
	         alert("操作成功");
	         
	         $('img'+imgid).src='/imageshow.jsp?path='+getfilepath(carinfo1[imgid][0][1])+'&r='+Math.random();
										
			}else
				{
				  alert(r);
				}
					
								});
	       	 (new Element('form',{'name':'postform1','method':'post','id':'postform1','action':'/saveimg.jsp','target':'iframe1'})).inject($('iframe1'));
	       	 (new Element('textarea',{'name':'data1','type':'hidden'}).set('text',b64)).inject($('postform1'));
	       	 (new Element('input',{'name':'imgpath','value':getfilepath(carinfo1[imgid][0][1]),'type':'hidden'})).inject($('postform1'));
	         $('postform1').submit();
	   
	        
	       
	    
	         $('showb').setStyle("display","block");
	         $('showi').setStyle("display","none");
	             		
	       // var data2=+':'+b64;
	          // var v_url='/saveimg.jsp?imgpath='+carinfo1[imgid][0][1]+'&data1='+b64;
    		


           
           
           
           
        },
        resetEraser:function(_x,_y,touch)
	    {   
	        
	        /*使用橡皮擦-提醒*/
	        var t=this;
            //this.cxt.lineWidth = 30;
            /*source-over 默认,相交部分由后绘制图形的填充(颜色,渐变,纹理)覆盖,全部浏览器通过*/
            t.cxt.globalCompositeOperation = "destination-out";
            t.cxt.beginPath();
            t.cxt.arc(_x, _y, t.eraserRadius, 0, Math.PI * 2);
            t.cxt.strokeStyle = "rgba(250,250,250,0)";
            t.cxt.fill();
            t.cxt.globalCompositeOperation = "source-over"
	    }
    };
    paint.init();
}
function showbigimg(obj)
{
	$('showb').setStyle("display","block");
	$('showi').setStyle("display","none");
   var oC =document.getElementById('canvas');
   var oGC = oC.getContext('2d');
   
   yImg = new Image();
   yImg.height=500;
  yImg.width=740;
   imgid=(obj.getProperty('id')).substring(3);
   yImg.src = obj.src;
    yImg.onload = function(){
     oGC.drawImage(yImg,0,0,yImg.width,yImg.height);
   };
   
   
  
   imageData=oGC.getImageData(0,0,yImg.width,yImg.height);
   pixelArray=imageData.data;
  
 
  
}

window.addEvent('domready', function(){
	
	
	 <%for(int i=0;i<ors2.length;i++){ %>
          carinfo1[<%=i%>]=new Array();
          carinfo1[<%=i%>][0]= new Array();		  
          carinfo1[<%=i%>][0][0]='imgpath';
	      carinfo1[<%=i%>][0][1]='<%=ors2[i].getValue("imgpath")%>';
	<%} %>
 
					if (!$('waiting'))
					(new Element('img', {
						'styles' : {
							width : 50,
							height : 50,
							display : 'none'
						},
						'id' : 'waiting',
						'src' : '/images/wait1.gif'
					})).inject(document.body);
	
	
	  var example1 = $('example1');
 
 example1.getElements('img').each(function(el){
      el.addEvent('click', function(evt){
    	  var tts=$$('.tt');
    	  for(var i=0;i<tts.length;i++)
    		  {
    		    if(tts[i]==this)
    		    	{
    		    	  this.setStyle('background','#F66001');
    		    	}
    		    else
    		    	{
    		    	 tts[i].setStyle('background','');
    		    	}
    		  }
    	  
    	  
    	  
      });
         el.addEvent('mouseup', function(evt){
    	  var tts=$$('.tt');
    	  for(var i=0;i<tts.length;i++)
    		  {
    		    if(tts[i]==this)
    		    	{
    		    	  this.setStyle('background','#F66001');
    		    	  showbigimg(this);
    		    	}
    		    else
    		    	{
    		    	 tts[i].setStyle('background','');
    		    	}
    		  }
    	  
    	  
    	  
      });
  });

  new Sortables(example1, { 
opacity: 0.6 // 默认为1 
});
  setTimeout("doload()",100);
});


function doload()
{
	var ss=$('img0');
	 ss.setStyle('background','#F66001');
	 
	showbigimg(ss);
	
}

function getfilepath(csfj)
{
		if (csfj!="") {
			var fjurl = "";
			var fj="";
			if (csfj.indexOf("*") > 0) {
				var aryfj = new Array();
				var arr=new Array();
				aryfj = csfj.split("\*");
				
				fjurl = aryfj[0].split("\\");
				fj=fjurl[0]+'\\\\'+fjurl[1]+'\\\\'+fjurl[2];
			
			} else {
				fj = csfj.replace("\\", "\\\\");
			}
			return fj;
		}
		return "";
	
}
function dosave()
{
	
	var tts=$$('.tt');
	for(var i=0;i<tts.length;i++)
		{
		 (new Element('input',{'name':'imageorder','value':i+1,'type':'hidden'})).inject($('st'));
		 (new Element('input',{'name':'imgpath','value':tts[i].getProperty('imgpath'),'type':'hidden'})).inject($('st'));
		// tts[i].set('imgorder',i+1);
		}
	  new Request( {'url' :'/mainservlet?'+$('postform').toQueryString(),
						'async' : true,
						'onSuccess' : function(txt) {
		                  //alert(txt);
							if (txt.indexOf('失败') > 0) {
							alert('操作失败！');
						} else {
							alert('操作成功！');
							  //window.opener.location.reload();
                              window.close();
						}
						  
						},
						'onException':function(){
							alert(1);
						}
					}).send({});
	
	

}

</script>
<style>
#example1 img  {
  cursor: pointer;
  padding: 3px;
}

</style>
<link rel="stylesheet" type="text/css" href="css/base.css">
<link rel="stylesheet" type="text/css" href="css/ht_css.css">
<link rel="stylesheet" type="text/css" href="css/canvas.css">
<link rel="stylesheet" type="text/css" href="css/layout.css">
<title>图片管理</title>
</head>
<body  id="body1" style="overflow:hidden;">


<div class="fa">
<!--位置&状态说明-->
                      <div class="cot_top">
                            <p>
                                <span class="cot_t"><img src="img/home_con.png" width="29" height="26" alt="所在位置" /></span>
                                <span class="cot_t font_black">&nbsp;当前位置:&nbsp;</span>
                                <span class="cot_t"><img src="img/arrow_con.png" width="29" height="26" alt="&gt;&gt;" /></span>
                                <span class="cot_t font_black">&nbsp;业务管理&nbsp</span>
                                <span class="cot_t"><img src="img/arrow_con.png" width="29" height="26" alt="&gt;&gt;" /></span>
                                <span class="cot_t font_blue">标的设定——修改照片</span>
                           		 <span class="cot_t" style="float:right; line-height:35px; margin-right:20px; ">
                                	<a class="link_return" href="##" onClick="window.close();">返回列表页>></a>
                                </span>
                              
                               
                            </p>
              </div>
          <!--end-->
</br>
<div>
	<p><span class="red">操作说明：</span></p>
    <p><span>使用鼠标拖动右侧小图进行排序；点击修改按钮，在画布区域拖动鼠标在需要遮掩的地【注意：每次修改一张图片点击保存按钮，所有图片修改完毕点击提交按钮】。</span></p>
</div>
</br>

<div class="showimg2">
	<div class="showimg_right">
          <canvas id="canvas" width="740px" height="500px">您的浏览器不支持 canvas 标签<b>【建议使用ie9以上或者谷歌浏览器！】</b>
          </canvas>
          <div class="top" id="top"  style="display: none">
                <div id="color" class="can_hb" style="display: none">
                    画笔颜色：
                   <input class="i1" type="button" value="" />&nbsp;<span>遮挡号牌</span>
                     &nbsp;&nbsp;<input class="i2" type="button" value="" />&nbsp;<span>特别提示</span>
                     &nbsp;&nbsp;<input class="i3" type="button" value="" />&nbsp;<span>特别提示</span>
                </div>
             
                <div class="font can_hb" id="font" style="display: none">
                    画笔的宽度：
                    <input type="button" value="细" />
                    <input type="button" value="中" class="grea"/>
                    <input type="button" value="粗" />
                </div>
                <div style="display: none">
                    <span id="error">如果有错误，请使用橡皮擦：</span>
                    <input id="eraser" style="width:60px;font-size:14px;"type="button" value="橡皮擦" />
                </div>
        		<div can_hb>
                <input id="clear" type="button" value="清除画布" style="width:80px;display:none;"/>
                <input id="revocation" type="button" value="撤销" style="width:80px;display:none;"/>
              
                </div>
    	</div>
        <div style=" margin:30px auto;">
             <div id="showi" style="display: none; float:left; margin-left:260px;">
             <input class=" upfile" id="imgurl" style="width:70px;height:30px;" type="button" value="保存" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             </div>
             <div id="showb" style="float:left; margin-left:260px;">
           <button  style="width:70px;height:30px;" onClick="doshow()" >修改</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           </div>
           <div style="float:left;">
           <button style="width:70px;height:30px;" onClick="dosave()">提交</button>
           </div>
        </div>
      	</div>
    <div class="showimg_left">
    	 <div id="example1" class="simg">
    	       	   <%for(int i=0;i<ors2.length;i++){ %>
   
        <img  id="img<%=i %>" class="tt" imgpath="<%=ors2[i].getValue("imgpath") %>" src="/imageshow.jsp?path=<%=futil.getFilePath(ors2[i].getValue("imgpath"))==""?"":futil.getFilePath(ors2[i].getValue("imgpath"))%>" onClick="showbigimg(this)"/>
    
          <%  }%>
         </div> 

          
    	 </div>	
    	 
    	 
    	 <div>
    	  <form name="postform" action="/mainservlet" id="postform" method="post" >
      <input id="handle" type="hidden" name="handle" value="<%=fid %>" />
       <input id="handle" type="hidden" name="carid" value="<%=ors2[0].getValue("carid")%>" />
    	<div id="st">
    	
    	
    	
    	</div>
    	 </form>
    	 
    	 
    	 
    	 
    	 </div>
    	 
    	 
    	
</div>
<div class="clear"></div>
<iframe style="display: none" id="iframe1" name="iframe1"></iframe>


</body>
</html>
