function IDCardReader(selector, callback, photoSavePath) {
	this.selector = selector;
	this.callback = callback;

	$(this.selector)[0].SetPhotoType(1);
	$(this.selector)[0].SetPhotoName(2);

	this.setPhotoSavePath = function(path) {
		var nRet;
		if (path == undefined||path == "") {
			nRet = $(this.selector)[0].SetPhotoPath(1, "");
		} else {
			nRet = $(this.selector)[0].SetPhotoPath(2, path);
		}
		this.status = (nRet == 0);
	};

	this.setPhotoSavePath(photoSavePath);

	this.connect = function() {
		var str = $(this.selector)[0].FindReader();
		if (str > 0) {
			if (str > 1000) {
				str = "读卡器连接在USB " + str + "\r\n";
			} else {
				str = "读卡器连接在COM " + str + "\r\n";
			}
			this.status = true;
		} else {
			str = "没有找到读卡器\r\n";
			this.status = false;
		}
		this.msg = str;
	};

	this.getSamId = function() {
		return $(this.selector)[0].GetSAMID();
	};

	this.read = function() {
		SynCardOcx1.SetReadType(0);
		var nRet = $(this.selector)[0].ReadCardMsg();

		if (nRet == 0) {
			this.status = true;
			this.name = $(this.selector)[0].NameA;
			this.sex = $(this.selector)[0].Sex;
			this.nation = $(this.selector)[0].Nation;
			this.born = $(this.selector)[0].Born;
			this.address = $(this.selector)[0].Address;
			this.idNumber = $(this.selector)[0].CardNo;
			this.validityBegin = $(this.selector)[0].UserLifeB;
			this.validityEnd = $(this.selector)[0].UserLifeE;
			this.police = $(this.selector)[0].Police;
			this.photoName = $(this.selector)[0].PhotoName;

			this.callback();
		}
	};

	this.autoRead = function(o_internal) {
		var internal = o_internal==undefined?1000:o_internal;
		$(this.selector)[0].SetloopTime(internal);
		$(this.selector)[0].SetReadType(1);
		//$(this.selector).unbind("CardIn")
		
	};
	
	$(this.selector).bind("CardIn", function(state) {
		alert(state);
		if (state == 1) {
			this.status = true;
			this.name = $(this.selector)[0].NameA;
			this.nation = $(this.selector)[0].Nation;
			this.born = $(this.selector)[0].Born;
			this.address = $(this.selector)[0].Address;
			this.idNumber = $(this.selector)[0].CardNo;
			this.validityBegin = $(this.selector)[0].UserLifeB;
			this.validityEnd = $(this.selector)[0].UserLifeE;
			this.police = $(this.selector)[0].Police;
			this.photoName = $(this.selector)[0].PhotoName;

			this.callback();
		}
	});
}