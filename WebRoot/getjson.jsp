<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.arch.event.*"%>
<%@ page import="com.arch.util.*"%>
<%@ page import="com.arch.basebean.OracleRowSet"%>
<%@ page import="sun.jdbc.rowset.*"%>
<%

EventResponse eventResponse = (EventResponse) request
.getAttribute("result");
FormUtil futil = new FormUtil();

OracleRowSet[] ors = new OracleRowSet[1];
ors[0] = new OracleRowSet(50);
OracleRowSet[] ors1 = new OracleRowSet[1];
ors1[0] = new OracleRowSet(50);
OracleRowSet[] ors2 = new OracleRowSet[1];
ors2[0] = new OracleRowSet(50);
OracleRowSet[] ors3 = new OracleRowSet[1];
ors3[0] = new OracleRowSet(50);
OracleRowSet[] ors4 = new OracleRowSet[1];
ors4[0] = new OracleRowSet(50);
OracleRowSet[] ors5 = new OracleRowSet[1];
ors5[0] = new OracleRowSet(50);
OracleRowSet[] ors6 = new OracleRowSet[1];
ors6[0] = new OracleRowSet(50);
OracleRowSet[] ors7 = new OracleRowSet[1];
ors7[0] = new OracleRowSet(50);
OracleRowSet[] ors8 = new OracleRowSet[1];
ors8[0] = new OracleRowSet(50);
OracleRowSet[] ors9 = new OracleRowSet[1];
ors9[0] = new OracleRowSet(50);
OracleRowSet[] ors10 = new OracleRowSet[1];
ors10[0] = new OracleRowSet(50);
OracleRowSet[] ors11 = new OracleRowSet[1];
ors11[0] = new OracleRowSet(50);
HashMap data = null, olddata = null;
if (eventResponse != null) {
data = (HashMap) eventResponse.getBody();
ors = (OracleRowSet[]) data.get("operation1");
ors1 = (OracleRowSet[]) data.get("operation2");
ors2 = (OracleRowSet[]) data.get("operation3");
ors3 = (OracleRowSet[]) data.get("operation4");
olddata = (HashMap) ((HashMap) eventResponse.getOriginBody())
	.get("operation1");
}

String dat="";
for(int i=0;i<ors1.length;i++){

	String str="";
	str="'"+ors1[i].getValue("orgid").replace("分公司","")+"'";
	dat=dat+str;
	dat=dat+",";

}

String riqi="";
for(int i=0;i<ors2.length;i++){
	String str="";
	str="'"+ors2[i].getValue("intime")+"'";
	riqi=riqi+str;
	riqi=riqi+",";
}

String title="";
if(ors3[0].getValue("status").equals("12"))
{
 title="分支上报分析";	
}else
if(ors3[0].getValue("status").equals("42"))
{
 title="分支落地分析";	
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>ECharts</title>
    <!--Step:1 Import a module loader, such as esl.js or require.js-->
    <!--Step:1 引入一个模块加载器，如esl.js或者require.js-->
    <script src="js/esl.js"></script>
       <script type="text/javascript">
    // Step:3 conifg ECharts's path, link to echarts.js from current page.
    // Step:3 为模块加载器配置echarts的路径，从当前页面链接到echarts.js，定义所需图表路径
    require.config({
        paths:{ 
            echarts:'./js/echarts-map',
            'echarts/chart/bar' : './js/echarts-map',
            'echarts/chart/line': './js/echarts-map',
            'echarts/chart/map' : './js/echarts-map'
        }
    });
    
    // Step:4 require echarts and use it in the callback.
    // Step:4 动态加载echarts然后在回调函数中开始使用，注意保持按需加载结构定义图表路径
    require(
        [
            'echarts',
            'echarts/chart/bar',
            'echarts/chart/line',
            'echarts/chart/map'
        ],
        function (ec) {
            //--- 折柱 ---
            var myChart = ec.init(document.getElementById('main'));
            myChart.setOption({
            	  title : {
                         text: '<%=title%>'
       
                          },
                tooltip : {
                    trigger: 'axis'
                },
              legend: {
                    data:[<%=dat%>]
                },
                toolbox: {
                    show : true,
                    feature : {
                        //mark : {show: true},
                        dataView : {show: true, readOnly: false},
                        magicType : {show: true, type: ['line', 'bar']},
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                calculable : true,
                xAxis : [
                    {
                        type : 'category',
                        data : [<%=riqi%>]
                    }
                ],
                yAxis : [
                    {
                       type : 'value',
                       axisLabel : {
                         formatter: '{value} 辆'
                         }
                    }
                ],
                series : [
                	<%for(int i=0;i<ors1.length;i++){%>
                    {
                    	
                        name:'<%=ors1[i].getValue("orgid").replace("分公司","")%>',
                        type:'line',
         
                        data:[<%=ors1[i].getValue("countcar")%>]
                    },
                    <%}%>
                   
                ]
            });
            

    
        }
    );
    </script>
</head>

<body>
    <!--Step:2 Prepare a dom for ECharts which (must) has size (width & hight)-->
    <!--Step:2 为ECharts准备一个具备大小（宽高）的Dom-->
    <div id="main" style="height:500px;border:1px solid #ccc;padding:10px;"></div>
</body>

</html>