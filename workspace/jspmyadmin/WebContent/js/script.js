
	function xhr(link,success,file,progress){
		var xhr;
		if (window.XMLHttpRequest){
			xhr = new XMLHttpRequest();
		}else{
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xhr.onreadystatechange=function(){
			if (xhr.readyState==4 && xhr.status==200) {
				res = xhr.responseText;
				success(res);
			}
		};
		xhr.open("POST",link,true);
		xhr.send(file);
	}


	
	function displayResult(q,db) {
		xhr("executeQuery?q="+q+"&db="+db,function(res){
			document.getElementById("resultFrame").innerHTML = res;
		});
	}
	
	function download_exportFile(db) {
		var nameInput = document.getElementById('fname');
		var extInput = document.getElementById('file-ext');
		if(nameInput.disabled != true){
			//nameInput.disabled = "true";
			//extInput.disabled = "true";
			document.location.href="downloadExportFile?db="+db+"&name="+nameInput.value+'&ext='+extInput.value;
		}
	}
	
	function uploadBackUp(db) {
		var files = document.getElementById("file-backup").files;
		if(files.length == 0){
			alert("Please select file");
			return;
		}
		var file = files[0];
		xhr("importDB?db="+db+"&name="+file.name, function(r) {
			//alert(r);
			//document.location.href = "";
			updateSideMenu(db);
			$("#restore-status").html(r);
			$("#restore-status").show();
			$("#upload-f").hide();
		}, file, function() {
			
		});
	}
	function updateSideMenu(dbName){
		xhr("side-menu.jsp?db="+dbName,function(res){
			document.getElementById("leftFrame").innerHTML = res;
		});
	}
	function dropDB(db) {
		var conf = confirm("Are you sure you want to drop "+db+"?");
		if(conf){
			xhr("dropDB?db="+db, function(res){
				document.location.href = "?#home";
			});
		}
	}