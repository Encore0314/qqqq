
var setupload = function(obj) {
var iframe_doupload,uploadform,waiting,uploadfile,maxsize,fext,dbname,showtype,showcontainer,savepath,shownum,btnid;
				if (!$('#iframe_doupload').length>0)
					 iframe_doupload = $('<iframe id="iframe_doupload"  name="iframe_doupload" style="width:0;height : 0;border : 0;visibility :hidden;position : absolute"></iframe>');
                       $(document.body).append(iframe_doupload);
				if (!$('#uploadform').length>0)
					 uploadform = $('<form id="uploadform" method="post" target="iframe_doupload"' +
					' action="/upload.jsp" enctype="multipart/form-data" ></form>');
 					$(document.body).append(uploadform);

				if (!$('#waiting').length>0)
					 waiting = $('<img style="width:50px;height:50px; margin:15px auto;display:none" id="waiting" src="/images/wait1.gif"/>');
					$(document.body).append(waiting);
					
				if (!$('uploadfile').length>0)
					 uploadfile = $('<input id="uploadfile" name="uploadfile" type="file" style="width : 0;opacity : 0.01" maxsize="200" size="0"/>');
					$('#uploadform').append(uploadfile);
					
		//$('#uploadform').append('<input type="submit" value="提交" />');
				$('#uploadfile').unbind('change');
				$('#uploadfile').bind("change", function() {
					// CheckExt(this);
					//alert(1);
					//return;
						$('#waiting').css('display', 'block');
						$('#uploadform').submit();
					});
				$('#iframe_doupload').unbind('load');
				$('#iframe_doupload')
						.bind(
								'load',
								function() {
									$('#waiting').css('display', 'none');
									var r = this.contentWindow.document.body.innerHTML;
									if (r) {
										if (r.indexOf('{') >= 0) {
											var t = JSON.parse(r) || {};
											$('#imgpath').val(t.fileinfo[0].fname);
											$('#upfileshow').attr('src','/imageshow.jsp?path1='+t.fileinfo[0].fname.split('.')[0]+'&path2='+t.fileinfo[0].fname.split('.')[1]); 
											
                                   }
										}
									}
								);
				


		$(obj).bind('mouseenter', function(evt) {
			var  tuploadfile= $('#uploadfile');
			var offset = {};
			
			offset.top = $(evt.target).offset().top;
			offset.left = $(evt.target).offset().left;
			$('#waiting').css({  
				     'position' : 'absolute',
					'top' : offset.top,
					'left' : offset.left,
					
				});
			
			tuploadfile.css({
					'position' : 'absolute',
					'top' : offset.top,
					'left' : offset.left,
					'height':$(evt.target).css('height'),
					'width' : $(evt.target).css('width')
				});

         });

	
				
				
				
				}
