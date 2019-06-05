<%@ page contentType="text/html; charset=utf-8" language="java" errorPage="" %>
<%@page import="java.util.*"%>
<%@ page import="com.arch.event.*"%>
<%@ page import="com.arch.util.*"%>
<%@ page import="com.arch.basebean.OracleRowSet" %>
<%
EventResponse eventResponse = (EventResponse) request.getAttribute("result");
FormUtil form = new FormUtil();
OracleRowSet[] ors=new OracleRowSet[1];
ors[0]=new OracleRowSet(50);
OracleRowSet[] ors1=new OracleRowSet[1];
ors1[0]=new OracleRowSet(50);
OracleRowSet[] ors2=new OracleRowSet[1];
ors2[0]=new OracleRowSet(50);
OracleRowSet[] ors3=new OracleRowSet[1];
ors3[0]=new OracleRowSet(50);
OracleRowSet[] ors4=new OracleRowSet[1];
ors4[0]=new OracleRowSet(50);
OracleRowSet[] ors5=new OracleRowSet[1];
ors5[0]=new OracleRowSet(50);
HashMap data=null,olddata=null;
if(eventResponse!=null){
     data=(HashMap)eventResponse.getBody();
     ors=(OracleRowSet[])data.get("operation1");
     ors1=(OracleRowSet[])data.get("operation2");
     ors2=(OracleRowSet[])data.get("operation3");
     ors3=(OracleRowSet[])data.get("operation4");
     ors4=(OracleRowSet[])data.get("operation5");
     ors5=(OracleRowSet[])data.get("operation6");
     olddata=(HashMap)((HashMap)eventResponse.getOriginBody()).get("operation1");
     int up=0,down=0;

}
String fid=Azdg.encrypt("fid=activity.xml@docopyactivity",SysConst.FORMACTION);
String addressfid=Azdg.encrypt("fid=activity.xml@addresslist",SysConst.FORMACTION);


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>编辑活动</title>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="title" content=""/>
<meta name="description" content=""/>
<link type="text/css" rel="stylesheet" href="/css/showBo.css" />
<script type="text/javascript" src="/js/showBo.js"></script>
<link rel="stylesheet" type="text/css" href="css/mycss.css">
<link rel="stylesheet" type="text/css" href="/css/select2.css">
<script type="text/javascript" src="/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="/js/DatePicker/WdatePicker.js"></script>
<link href="/js/DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/js/select2.js"></script>
<script type="text/javascript" src="/js/select2_locale_zh-CN.js"></script>
<script type="text/javascript" src="js/artDialog/jquery.artDialog.js"></script>
<script type="text/javascript" src="js/artDialog/plugins/artDialog.iframeTools.source.js"></script>
<link href="/js/artDialog/skins/default.css" rel="stylesheet" type="text/css">
<script>
   function selectAddress(){
   art.dialog.open('/mainservlet?handle=<%=addressfid%>', {
      width:800,
      height:500,
      title: '首页图片添加',
      close:function(){
	   $('#activity_address').val(art.dialog.data('address_name'));
	   $('#address_lon').val(art.dialog.data('address_lon'));
	   $('#address_lat').val(art.dialog.data('address_lat'));
	   	   
	   
      }
    });
  }
</script>
<style>
body{ overflow-x: hidden; }
/*星星样式*/
 
        .title{ 
            font-size:14px; 
            background:#dfdfdf; 
            padding:10px; 
            margin-bottom:10px;
        }
        .block{ 
            width:100%; 
            margin:0 0 20px 0; 
            padding-top:10px; 
            padding-left:50px; 
            line-height:21px;
        }
        .block .star_score{ 
            float:left;
        }
        .star_list{
            height:21px;
            margin:50px; 
            line-height:21px;
        }
        .block p,.block .attitude{ 
            padding-left:20px; 
            line-height:21px; 
            display:inline-block;
        }
        .block p span{ 
            color:#C00; 
            font-size:16px; 
            font-family:Georgia, "Times New Roman", Times, serif;
        }

        .star_score { 
            background:url(images/stark2.png); 
            width:160px; 
            height:21px;  
            position:relative; 
        }

        .star_score a{ 
            height:21px; 
            display:block; 
            text-indent:-999em; 
            position:absolute;
            left:0;
        }

        .star_score a:hover{ 
            background:url(images/stars2.png);
            left:0;
        }

        .star_score a.clibg{ 
            background:url(images/stars2.png);
            left:0;
        }

        #starttwo .star_score { 
            background:url(images/starky.png);
        }

        #starttwo .star_score a:hover{ 
            background:url(images/starsy.png);
            left:0;
        }

        #starttwo .star_score a.clibg{ 
            background:url(images/starsy.png);
            left:0;
        }

        /*星星样式*/

        .show_number{ 
            padding-left:50px; 
            padding-top:20px;
        }

        .show_number li{ 
            width:240px; 
            border:1px solid #ccc; 
            padding:10px; 
            margin-right:5px; 
            margin-bottom:20px;
        }

        .atar_Show{
            background:url(images/stark2.png); 
            width:160px; height:21px;  
            position:relative; 
            float:left; 
        }

        .atar_Show p{ 
            background:url(images/stars2.png);
            left:0; 
            height:21px; 
            width:134px;
        }

        .show_number li span{ 
            display:inline-block; 
            line-height:21px;
        }
    .fenshu{ width: 35px; text-align: center; display: inline-block; color: red; 
        font-size: 16px; }
</style>
<script src="/js/starScore.js"></script>
<script src="/js/uploadjq.js" type="text/javascript"></script>
<script type="text/javascript" charset="utf-8" src="/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/ueditor/ueditor.all.min.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="/ueditor/lang/zh-cn/zh-cn.js"></script>
      <script type="text/javascript">
       $(function () {
            $("#activityStartTime").on("click", function () {
                WdatePicker({
                    el: 'startDateHidden',
                    dateFmt: 'yyyy-MM-dd',
                    doubleCalendar: true,
                    minDate: '',
                    maxDate: '#F{$dp.$D(\'endDateHidden\')}',
                    position: {left: -224, top: 8},
                    isShowClear: false,
                    isShowOK: true,
                    isShowToday: false,
                    onpicked: pickedStartFunc
                })
            })
            $("#activityEndTime").on("click", function () {
                WdatePicker({
                    el: 'endDateHidden',
                    dateFmt: 'yyyy-MM-dd',
                    doubleCalendar: true,
                    minDate: '#F{$dp.$D(\'startDateHidden\')}',
                    position: {left: -224, top: 8},
                    isShowClear: false,
                    isShowOK: true,
                    isShowToday: false,
                    onpicked: pickedendFunc
                })
            })
            
             scoreFun($("#startone"));
             var num=$('#activity_starts').val();
             if(num!='')
            	 {
            	   $('#startone .star_score a').eq((num/0.5)-1).trigger('click');
            	 }
           
           setupload($('#upfile'));
           
           var areaObj = $('#area').select2({
				
				allowClear: true
				
				}); 
         
					var optionVal = '<%=ors4[0].getValue("tag_id")%>'; 
					if(optionVal=='')
						{
						  optionVal='1';
						  $('#area2').css('display','none');
						}else
						{
								    $.ajax({
						            url:"/mainservlet?handle=<%=Azdg.encrypt("fid=activity.xml@getvenue",SysConst.FORMACTION) %>",
						            type:'post',
						            
						            async: false,
						            data:{'venue_type':optionVal},
						            success:function(data){
						               $('#area2').html($(data));
						              var areaObj2= $('#area2').select2({
										
										     allowClear: true
										
										});
						              areaObj2 .val('<%=ors4[0].getValue("venue_id")%>').trigger("change");  
					                  areaObj2 .change(); 
						            }
						             });
						}
					areaObj .val(optionVal).trigger("change");  
					areaObj .change(); 
                    
            
           $('#area').on("select2-selecting", function(e) { 
        	   var tagid=e.val;
        	   if(tagid=='')
        		   {
        		     $('#venue_id').val('');
        		     $('#area2').html($('<option>所有场馆</option>'));
        		     $('#area2').css('display','block');
        		     $('#area2').select2({
				
				     allowClear: true
				
				});  
        		   }
        	   else if(tagid=='1')
        	   {
        		   $('#venue_id').val('');
        		   $('#area2').select2('destroy');
        		   $('#area2').css('display','none');
        	   }
        	   else 
        	   {
        		   $('#venue_id').val('');
        		   $('#area2').css('display','block');
        		    $.ajax({
            url:"/mainservlet?handle=<%=Azdg.encrypt("fid=activity.xml@getvenue",SysConst.FORMACTION) %>",
            type:'post',
            
            async: false,
            data:{'venue_type':tagid},
            success:function(data){
               $('#area2').html($(data));
                 $('#area2').select2({
				
				     allowClear: true
				
				});
            }
             });
        		   
        		  
        	   }
        	   
        	   
           }) 
           
             $('#area2').on("select2-selecting", function(e) { 
        	   var venue_id=e.val;
        	     $('#venue_id').val(venue_id);
       
        	   
        	   
           })  
           
           
           $('#weizhi li').each(function(i){
				    $(this).click(function(){
				    	$('#weizhi li').attr('class','');
				    	$(this).attr('class','cur');
				    	$('#activity_location').val($(this).attr('code_id'));
				       
				     })
				});
           
           $('#activitytype li').each(function(i){
				    $(this).click(function(){
				    	$('#activitytype li').attr('class','');
				    	$(this).attr('class','cur');
				    	$('#activity_type').val($(this).attr('code_id'));
				       
				     })
				});
           
           var ue = UE.getEditor('editor');
            
        });
        function pickedStartFunc() {
            $dp.$('activityStartTime').value = $dp.cal.getDateStr('yyyy-MM-dd');
        }
        function pickedendFunc() {
            $dp.$('activityEndTime').value = $dp.cal.getDateStr('yyyy-MM-dd');
        }
function dosubmit()
{
    	$('#activity_state').val('6');
        var flag=true;
         var inputs=$("[reod]");
         for (var i = 0 ; i <inputs.length; i++) {
           if($(inputs[i]).val()=='')
           {
		    
			Showbo.Msg.alert($(inputs[i]).attr('reod')+'不能为空!');
			$(inputs[i]).focus();
             flag=false;  
             
			break;
			
           }
		   
         };
		 if(flag)
		 {
		  
		  $('form').submit();
		 }


}

function dosubmit2()
{
    	
         $('#activity_state').val('1');
		  
		  $('form').submit();
		


}
  var line=1;
  function addline()
  {
	    line++;
	  
	
	  var html='<div class="acttcon" id="line'+line+'">'+
	  '<input class="form-inp" style="width: 90px" type="text" name="" onchange="updatesjd()" placeholder="00" id="line'+line+'sh" onkeyup="if(isNaN(value))execCommand("undo")" onafterpaste="if(isNaN(value))execCommand("undo")" maxlength="2"  value=""/>：'+
	  '<input class="form-inp" style="width: 90px" width="90" type="text" onchange="updatesjd()" name="" placeholder="00" id="line'+line+'si" onkeyup="if(isNaN(value))execCommand("undo")" onafterpaste="if(isNaN(value))execCommand("undo")" maxlength="2" value=""/>&nbsp;&nbsp;至&nbsp;&nbsp;'+
	  '<input class="form-inp" style="width: 90px" width="90" type="text" onchange="updatesjd()" name="" placeholder="00" id="line'+line+'eh" onkeyup="if(isNaN(value))execCommand("undo")" onafterpaste="if(isNaN(value))execCommand("undo")" maxlength="2" value=""/>：'+
	  '<input class="form-inp" style="width: 90px" width="90" type="text" onchange="updatesjd()" name="" placeholder="00" id="line'+line+'ei"  onkeyup="if(isNaN(value))execCommand("undo")" onafterpaste="if(isNaN(value))execCommand("undo")" maxlength="2" value=""/>'+
	  '<span><a href="javascript:;" onclick="delline('+line+')"><img src="images/minus.png" width="26"></a></span><div class="clear"></div>';
	  
	  $('#line1').after($(html));
	  
  }
  function delline(n)
  {
	  $('#line'+n).remove();
	  updatesjd();
	 
	
  }
  function updatesjd()
  {
	  var str='';
	  var sjd=$('.acttcon');
	  for(var i=0;i<sjd.length;i++)
		  {
		    var id=$(sjd[i]).attr('id').substring(4);
		    var sh=$('#line'+id+'sh').val();
		    var si=$('#line'+id+'si').val();
		    var eh=$('#line'+id+'eh').val();
		    var ei=$('#line'+id+'ei').val();
		    if(sh!=''&&si!=''&&eh!=''&&ei!='')
		    	{
		    	  str+=sh+':'+si+'-'+eh+':'+ei;
		    	  str+='|';
		    	}
		   
		    
		  }
	  $('#activity_time').val(str);
  }
  
 
</script>
</head>
<body>
    <div class="page">
    	<div class=" basic-grey">
        	<div >
            
       <form id="postForm" name="postForm" method="post" action="/mainservlet">
  <input type="hidden" name="handle" id="handle" value="<%=fid %>"/>
    <input type="hidden" name="type" id="type" value="<%=ors3[0].getValue("type") %>"/>
  <input type="hidden" name="activity_starts"  id="activity_starts" reod="活动星级" value="<%=ors3[0].getValue("activity_starts") %>"/>
  <input type="hidden" name="venue_id" id="venue_id" value="<%=ors4[0].getValue("venue_id")%>"/>
   <input type="hidden" name="activity_location" id="activity_location" value="<%=ors3[0].getValue("activity_location") %>"/>
   <input type="hidden" reod="活动时间" id="activity_time" name="activity_time" value=""/>
   <input type="hidden" reod="封面" id="imgpath" name="activity_icon_url" value="<%=ors3[0].getValue("activity_icon_url") %>"/>
   <input type="hidden" id="activity_type" name="activity_type" reod="活动类型" value="<%=ors3[0].getValue("activity_type") %>"/>
   <input type="hidden" id="activity_state" name="activity_state" value="<%=ors3[0].getValue("activity_state") %>"/>
  <table width="100%" class="formtab">
         <tr>
            <td width="85" align="right" nowrap="nowrap"><span class="red"><img src="img/star.png" width="9" height="9" alt="*"></span>活动名称：</td>
            <td colspan="3">
              <input class="form-inp" type="text" name="activity_name" id="activity_name" reod="活动名称" value="<%=ors3[0].getValue("activity_name") %>"　 />
            </td>
           
          </tr>
          <tr>
            <td  align="right" nowrap="nowrap"> <span class="red"><img src="img/star.png" width="9" height="9" alt="*"></span>活动星级：</td>
            <td colspan="3">
              <div style="height: 55px;">
             <div id="startone"  class="block clearfix" >
          <div class="star_score"></div>
          <span style="float:left;"><span class="fenshu">0</span> 分</span>
          <div class="attitude"></div>
          </div>
        </div>
            </td>
           
          </tr>
          
          <tr>
					<td align="right" nowrap="nowrap"  valign="top">
						<span class="red"><img src="img/star.png" width="9" height="9" alt="*"></span>上传封面：</td>
            <td colspan="3">
               <div class="resup_div">
					
      
          <div class="upimg_div">
              <div class="imgup">
          
          <img id="upfileshow" style="width:263px; height: 163px;"  src="/imageshow.jsp?path=<%=ors3[0].getValue("activity_icon_url") %>""/>
          
        </div>
        </div>
          <input id="upfile" type="button" 
      datetype="{'type':'file','maxsize':'2000',isnotnull:false,'fext':'jpg,gif,bmp,JPG,GIF,BMP','showtype':'picture','showcontainer':'simage3','savepath':'d:\\\\carimage','shownum':'1'}"
      value="" title="图片" />
      </div>
                       </td>
                   </tr>
                   
				
				
                   
          <tr>
            <td  align="right" nowrap="nowrap"  ><span class="red"><img src="img/star.png" width="9" height="9" alt="*"></span>使用场馆：</td>
            <td colspan="3">
              <select class="select2" style="width:220px; margin-right: 15px;" id="area" name=""  msg="" >
             <option value="">场馆类型</option>
                 <%
                      for (int i = 0; i < ors.length; i++) {
                 %>
                <option  value="<%=ors[i].getValue("tag_id")%>"><%=ors[i].getValue("tag_name")%></option>
                  <%
                     }
                 %>
                  <option value="1">区级自建活动</option>
             </select>
           
              <select class="select2" style="width:220px" id="area2" name=""  msg="" >
               <option value="">所有场馆</option>
             </select>
            </td>
          </tr>
          <tr>
            <td  align="right" nowrap="nowrap"  ><span class="red"><img src="img/star.png" width="9" height="9" alt="*"></span>位置：</td>
            <td colspan="3">
              <ul class="sectul" id="weizhi">
                <%
                      for (int i = 0; i < ors1.length; i++) {
                 %>
                <li code_id="<%=ors1[i].getValue("code_id")%>" <%if(ors3[0].getValue("activity_location").equals(ors1[i].getValue("code_id")) ){ %>class='cur'<%} %>>
                  <a href="###"><%=ors1[i].getValue("code_name")%></a>
                </li>                 
                 <%
                     }
                 %>
               
                
              </ul>
            </td>
          </tr>

          <tr>
            <td align="right">主办方：</td>
            <td width="260"> <input class="form-inp" type="text" name="activity_host" id=""  value="<%=ors3[0].getValue("activity_host") %>"/></td>
            <td width="80" align="right">承办单位：</td>
            <td> <input class="form-inp" type="text" name="activity_organizer" id=""  value="<%=ors3[0].getValue("activity_organizer") %>"/></td>
          </tr>
             <tr>
            <td align="right">协办单位：</td>
            <td> <input class="form-inp" type="text" name="activity_coorganizer" id=""  value="<%=ors3[0].getValue("activity_coorganizer") %>"/></td>
            <td align="right">演出单位：</td>
            <td> <input class="form-inp" type="text" name="activity_performed" id=""  value="<%=ors3[0].getValue("activity_performed") %>"/></td>
          </tr>
          <tr>
            <td align="right">主讲人：</td>
            <td><input class="form-inp" type="text" name="activity_speaker" id=""  value="<%=ors3[0].getValue("activity_speaker") %>"/></td>
            <td></td>
            <td></td>
          </tr>
            <tr>
            <td align="right">友情提示：</td>
            <td colspan="3"><input class="form-inp" type="text" name="activity_prompt" id=""  value="<%=ors3[0].getValue("activity_prompt") %>"/></td>
          </tr>

          <tr>
            <td width="80" align="right" nowrap="nowrap"  ><span class="red"><img src="img/star.png" width="9" height="9" alt="*"></span>活动类型：</td>
            <td colspan="3">
              <ul class="sectul" id="activitytype">
                  <%
                      for (int i = 0; i < ors2.length; i++) {
                 %>
                <li code_id="<%=ors2[i].getValue("tag_id")%>" <%if(ors3[0].getValue("activity_type").equals(ors2[i].getValue("tag_id")) ){ %>class='cur'<%} %>>
                  <a href="###"><%=ors2[i].getValue("tag_name")%></a>
                </li>                 
                 <%
                     }
                 %>
               
               
              </ul>
            </td>
          </tr>

          <tr>
            <td align="right" valign="top"><span class="red"><img src="img/star.png" width="9" height="9" alt="*"></span>活动日期：</td>
            <td colspan="3">
               <div class="data_div">
            <span class="data_span"><img src="images/datacon.png"></span>
            <input type="hidden" id="startDateHidden" name="activity_start_time" reod="活动开始日期" value="<%=ors3[0].getValue("activity_start_time") %>">
            <input type="text" style="width: 140px;" id="activityStartTime" class="form-inp " name="activityStartTime" value="<%=ors3[0].getValue("activity_start_time") %>" readonly="">
            <span class="data_span">至</span>
            <input type="hidden" id="endDateHidden" name="activity_end_time" reod="活动结束日期" value="<%=ors3[0].getValue("activity_end_time") %>">
            <input  class="form-inp" style="width: 140px;" type="text" id="activityEndTime" name="activityEndTime" value="<%=ors3[0].getValue("activity_end_time") %>" readonly="">
      </div>
            </td>
          </tr>
          <tr>
            <td align="right">具体描述： </td>
            
            <td colspan="3">
               <input  class="form-inp "  style="width: 400px;" name="activity_time_des" value="<%=ors3[0].getValue("activity_time_des") %>" placeholder="例如：每周三上午8:00-11:30" />
            </td>
          </tr>

          <tr>
            <td align="right"><span class="red"><img src="img/star.png" width="9" height="9" alt="*"></span>活动时间：</td>
            <td colspan="3">
              <div class="act_time" >
          
                <div class="acttcon" id="line1">
                 <input onkeyup="if(isNaN(value))execCommand('undo')" onchange="updatesjd()" onafterpaste="if(isNaN(value))execCommand('undo')" maxlength="2" class="form-inp" style="width: 90px" type="text" name="" id="line1sh"  placeholder="00" value=""/>：
                  <input onkeyup="if(isNaN(value))execCommand('undo')" onchange="updatesjd()" onafterpaste="if(isNaN(value))execCommand('undo')" maxlength="2" class="form-inp" style="width: 90px" width="90" type="text" name="" id="line1si" placeholder="00" value=""/>
                  &nbsp;&nbsp;至&nbsp;&nbsp;
                  <input onkeyup="if(isNaN(value))execCommand('undo')" onchange="updatesjd()" onafterpaste="if(isNaN(value))execCommand('undo')" maxlength="2" class="form-inp" style="width: 90px" width="90" type="text" name="" id="line1eh" placeholder="00" value=""/>：
                  <input onkeyup="if(isNaN(value))execCommand('undo')" onchange="updatesjd()" onafterpaste="if(isNaN(value))execCommand('undo')" maxlength="2" class="form-inp" style="width: 90px" width="90" type="text" name="" id="line1ei" placeholder="00" value=""/>
                  <span>
                    <a href="javascript:;" onclick="addline()">
                      <img src="images/add.png" width="26">
                    </a>
                  </span>
                </div>
              
                
            </div>
            </td>
          </tr>

          <tr>
            <td align="right"><span class="red"><img src="img/star.png" width="9" height="9" alt="*"></span>活动地址：</td>
            <td colspan="3">
               <input class="form-inp" style="max-width:460px" width="90" type="text" name="activity_address" id="activity_address" reod="活动地址" placeholder="请输入详细地址" value="<%=ors3[0].getValue("activity_address") %>" readonly/>
               <input type="hidden" id="address_lat" name="address_lat" value="<%=ors3[0].getValue("address_lat") %>"/>
                <input type="hidden" id="address_lon" name="address_lon" value="<%=ors3[0].getValue("address_lon") %>"/>
               <a href="###" class="button" id="selectAddress" onclick="selectAddress()">选择地址</a>
            </td>

          </tr>
         <tr>
            <td align="right"><span class="red"><img src="img/star.png" width="9" height="9" alt="*"></span>活动电话：</td>
            <td><input class="form-inp" type="text" name="activity_tel" id="" reod="活动电话" value="<%=ors3[0].getValue("activity_tel") %>"/></td>
            <td></td>
            <td></td>
          </tr>



         <tr>
           <td width="80" align="right" nowrap="nowrap"  ><span class="red"><img src="img/star.png" width="9" height="9" alt="*"></span>是否收费：</td>
            <td colspan="3">
            	<input name="activity_is_free" id="" type="radio" value="1" checked />&nbsp;是&nbsp;&nbsp;&nbsp;
                <input name="activity_is_free" id="" type="radio" value="2"  />&nbsp;否
            </td>
            </tr>
            <tr style="display: none">
           <td width="80" align="right" nowrap="nowrap"  ><span class="red"><img src="img/star.png" width="9" height="9" alt="*"></span>在线购票：</td>
            <td colspan="3">
              <input name="" id="" type="radio" value="" checked datetype="{'type':'char','maxlength':'50',isnotnull:false}" />&nbsp;不可预订&nbsp;&nbsp;&nbsp;
                <input name="" id="" type="radio" value="" datetype="{'type':'char','maxlength':'50',isnotnull:false}" />&nbsp;自由入座&nbsp;&nbsp;&nbsp;
              <input type="radio" name="" id="" title=""　value="" datetype="{'type':'char','maxlength':'50',isnotnull:false}" />&nbsp;在线选座
            </td>
            </tr>

          <tr>
            <td align="right"  valign="top">购票须知：</td>
            <td colspan="3">
              <div class="textata_div" style="width: 480px">
               
                <textarea name="activity_notice" rows="4" class="textareaBox" maxlength="300" style="width: 500px;resize: none"><%=ors3[0].getValue("activity_notice") %></textarea>
              </div>
            </td>
          </tr>
            <tr>
            <td align="right" valign="top">活动描述：</td>
            <td colspan="3">
              
                <script id="editor" name="activity_memo" type="text/plain" style="width:720px;height:500px;" ><%=ors3[0].getValue("activity_memo") %></script>
             
            </td>
          </tr>
          <tr>
          	<td  colspan="4" align="center" >
          	
          	    <a class="button" name="button" id="button" onclick="dosubmit2()">保存草稿</a>
          	    
            	<a class="button-blue" name="button" id="button" onclick="dosubmit()">发布信息</a></td>
     	</tr>
           </table>
           </form>
            </div>
        </div>
    </div>
        
        
      
</body>
</html>
<script>
var eventtime='<%=ors5[0].getValue("eventtime")%>';
  if(eventtime!='')
	  {
	    var time=eventtime.split("|");
	    for(var i=0;i<time.length-1;i++)
	    	{
	    	   if(i==0)
	    		  {
	    		    var sh=((time[i].split("-"))[0]).split(":")[0];
	    		    var si=((time[i].split("-"))[0]).split(":")[1];
	    		    var eh=((time[i].split("-"))[1]).split(":")[0];
	    		    var ei=((time[i].split("-"))[1]).split(":")[1];
	    		    $('#line1sh').val(sh);
	    		    $('#line1si').val(si);
	    		    $('#line1eh').val(eh);
	    		    $('#line1ei').val(ei);
	    		  }
	    	   else
	    		  {
	    			    line++;
	                var sh=((time[i].split("-"))[0]).split(":")[0];
	    		    var si=((time[i].split("-"))[0]).split(":")[1];
	    		    var eh=((time[i].split("-"))[1]).split(":")[0];
	    		    var ei=((time[i].split("-"))[1]).split(":")[1];
	    		    $('#line'+line+'sh').val(sh);
	    		    $('#line'+line+'si').val(si);
	    		    $('#line'+line+'eh').val(eh);
	    		    $('#line'+line+'ei').val(ei);
	
						  var html='<div class="acttcon" id="line'+line+'">'+
						  '<input class="form-inp" style="width: 90px" type="text" name="" onchange="updatesjd()" placeholder="00" id="line'+line+'sh" onkeyup="if(isNaN(value))execCommand("undo")" onafterpaste="if(isNaN(value))execCommand("undo")" maxlength="2"  value="'+sh+'"/>：'+
						  '<input class="form-inp" style="width: 90px" width="90" type="text" onchange="updatesjd()" name="" placeholder="00" id="line'+line+'si" onkeyup="if(isNaN(value))execCommand("undo")" onafterpaste="if(isNaN(value))execCommand("undo")" maxlength="2" value="'+si+'"/>&nbsp;&nbsp;至&nbsp;&nbsp;'+
						  '<input class="form-inp" style="width: 90px" width="90" type="text" onchange="updatesjd()" name="" placeholder="00" id="line'+line+'eh" onkeyup="if(isNaN(value))execCommand("undo")" onafterpaste="if(isNaN(value))execCommand("undo")" maxlength="2" value="'+eh+'"/>：'+
						  '<input class="form-inp" style="width: 90px" width="90" type="text" onchange="updatesjd()" name="" placeholder="00" id="line'+line+'ei"  onkeyup="if(isNaN(value))execCommand("undo")" onafterpaste="if(isNaN(value))execCommand("undo")" maxlength="2" value="'+ei+'"/>'+
						  '<span><a href="javascript:;" onclick="delline('+line+')"><img src="images/minus.png" width="26"></a></span><div class="clear"></div>';
						  
						  $('#line1').after($(html));
	    		  }
	    	}
	    
	     updatesjd();
	    
	  }

</script>

