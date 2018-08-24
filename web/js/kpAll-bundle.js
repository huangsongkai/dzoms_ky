webpackJsonp([0],{

/***/ 1016:
/***/ (function(module, exports) {

module.exports = function shallowEqualArrays(arrA, arrB) {
  if (arrA === arrB) {
    return true;
  }

  var len = arrA.length;

  if (arrB.length !== len) {
    return false;
  }

  for (var i = 0; i < len; i++) {
    if (arrA[i] !== arrB[i]) {
      return false;
    }
  }

  return true;
};


/***/ }),

/***/ 1021:
/***/ (function(module, exports, __webpack_require__) {

// style-loader: Adds some css to the DOM by adding a <style> tag

// load the styles
var content = __webpack_require__(177);
if(typeof content === 'string') content = [[module.i, content, '']];
// add the styles to the DOM
var update = __webpack_require__(25)(content, {});
if(content.locals) module.exports = content.locals;
// Hot Module Replacement
if(true) {
	// When the styles change, update the <style> tags
	if(!content.locals) {
		module.hot.accept(177, function() {
			var newContent = __webpack_require__(177);
			if(typeof newContent === 'string') newContent = [[module.i, newContent, '']];
			update(newContent);
		});
	}
	// When the module is disposed, remove the <style> tags
	module.hot.dispose(function() { update(); });
}

/***/ }),

/***/ 1038:
/***/ (function(module, exports, __webpack_require__) {

// style-loader: Adds some css to the DOM by adding a <style> tag

// load the styles
var content = __webpack_require__(196);
if(typeof content === 'string') content = [[module.i, content, '']];
// add the styles to the DOM
var update = __webpack_require__(25)(content, {});
if(content.locals) module.exports = content.locals;
// Hot Module Replacement
if(true) {
	// When the styles change, update the <style> tags
	if(!content.locals) {
		module.hot.accept(196, function() {
			var newContent = __webpack_require__(196);
			if(typeof newContent === 'string') newContent = [[module.i, newContent, '']];
			update(newContent);
		});
	}
	// When the module is disposed, remove the <style> tags
	module.hot.dispose(function() { update(); });
}

/***/ }),

/***/ 119:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(module, $) {

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _button = __webpack_require__(18);

var _button2 = _interopRequireDefault(_button);

var _table = __webpack_require__(31);

var _table2 = _interopRequireDefault(_table);

var _modal = __webpack_require__(43);

var _modal2 = _interopRequireDefault(_modal);

var _inputNumber = __webpack_require__(54);

var _inputNumber2 = _interopRequireDefault(_inputNumber);

var _datePicker = __webpack_require__(35);

var _datePicker2 = _interopRequireDefault(_datePicker);

var _input = __webpack_require__(28);

var _input2 = _interopRequireDefault(_input);

var _form = __webpack_require__(29);

var _form2 = _interopRequireDefault(_form);

var _index = __webpack_require__(21);

var _index2 = _interopRequireDefault(_index);

var _index3 = __webpack_require__(19);

var _index4 = _interopRequireDefault(_index3);

var _react2 = __webpack_require__(0);

var _react3 = _interopRequireDefault(_react2);

var _index5 = __webpack_require__(20);

var _index6 = _interopRequireDefault(_index5);

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

__webpack_require__(22);

__webpack_require__(32);

__webpack_require__(44);

__webpack_require__(55);

__webpack_require__(36);

__webpack_require__(23);

__webpack_require__(30);

var _reactDom = __webpack_require__(11);

var _reactDom2 = _interopRequireDefault(_reactDom);

var _moment = __webpack_require__(1);

var _moment2 = _interopRequireDefault(_moment);

var _Sorter = __webpack_require__(33);

var _Sorter2 = _interopRequireDefault(_Sorter);

var _Filters = __webpack_require__(40);

var _Filters2 = _interopRequireDefault(_Filters);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var _components = {
  Performance: {
    displayName: 'Performance'
  }
};

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2 = (0, _index6.default)({
  filename: '/Users/huang/work/dzoms_react/components/kp/personalPerformance.js',
  components: _components,
  locals: [module],
  imports: [_react3.default]
});

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2 = (0, _index4.default)({
  filename: '/Users/huang/work/dzoms_react/components/kp/personalPerformance.js',
  components: _components,
  locals: [],
  imports: [_react3.default, _index2.default]
});

function _wrapComponent(id) {
  return function (Component) {
    return _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2(_UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2(Component, id), id);
  };
}

var FormItem = _form2.default.Item;
var TextArea = _input2.default.TextArea;
var MonthPicker = _datePicker2.default.MonthPicker,
    RangePicker = _datePicker2.default.RangePicker;

var dateFormat = 'YYYY/MM/DD';
var monthFormat = 'YYYY/MM';

var Performance = _wrapComponent('Performance')(function (_React$Component) {
  _inherits(Performance, _React$Component);

  function Performance(props) {
    _classCallCheck(this, Performance);

    var _this = _possibleConstructorReturn(this, (Performance.__proto__ || Object.getPrototypeOf(Performance)).call(this, props));

    _this.state = {
      selectedRowKeys: [], // Check here to configure the default column
      loading: false,
      recData: [], //从后台接收到的数据
      newKey: 1,
      evaluateName: "",
      message: "",
      totalZiping: ""
    };
    _this.keyPairs = {};
    _this.key = 0;
    return _this;
  }

  _createClass(Performance, [{
    key: 'componentDidMount',
    value: function componentDidMount() {
      $.ajax({
        url: this.props.selfEvaluateUrl,
        type: "get",
        dataType: 'json',
        contentType: 'application/json',
        success: function (data) {
          var data = data.data;
          // console.log(data)
          var evaluateName = "";
          if (data) {
            for (var i = 0; i < data.length; i++) {
              data[i]["key"] = data[i].id;
              evaluateName = data[0].evaluateName;
            }
            for (var i in data) {
              if (!this.keyPairs[data[i].id]) {
                this.keyPairs[data[i].id] = { inputs: "", score: 0, remarks: "" };
                this.keyPairs[data[i].id].inputs = data[i].personal.complete;
                if (data[i].personal.score != null) {
                  // console.log(data[i].personal.score)
                  this.keyPairs[data[i].id].inputs = data[i].personal.complete;
                  this.keyPairs[data[i].id].score = data[i].personal.score;
                  this.keyPairs[data[i].id].remarks = data[i].remarks;
                }
                //this.keyPairs[data[i].id].score=data[i].childProValue;
              }
            }
            var sum = 100;
            for (var i in this.keyPairs) {
              sum += parseFloat(this.keyPairs[i].score);
            }
            sum = sum.toFixed(2);
            this.setState({
              recData: data,
              evaluateName: evaluateName,
              totalZiping: sum
            });
          } else {
            recData: [];
          }
        }.bind(this),
        error: function error() {
          alert("请求失败");
        }
      });
    }
  }, {
    key: 'start',
    value: function start() {
      var _this2 = this;

      this.setState({ loading: true });
      setTimeout(function () {
        _this2.setState({
          selectedRowKeys: [],
          loading: false
        });
      }, 1000);
    }
  }, {
    key: 'onSelectChange',
    value: function onSelectChange(selectedRowKeys) {
      this.setState({ selectedRowKeys: selectedRowKeys });
      return selectedRowKeys;
    }
  }, {
    key: 'onScoreChange',
    value: function onScoreChange(index, value) {
      if (!value) {
        value = 0;
      }
      value = parseFloat(value).toFixed(2);
      // console.log(value)
      index = this.state.recData[index].id;
      if (!this.keyPairs[index]) this.keyPairs[index] = { inputs: "", score: "" };
      this.keyPairs[index].score = value;
      var sum = 100;
      for (var i in this.keyPairs) {
        sum += parseFloat(this.keyPairs[i].score);
      }
      sum = sum.toFixed(2);
      this.setState({
        totalZiping: sum
      });
    }
  }, {
    key: 'onChange',
    value: function onChange(index, seq, value) {
      index = this.state.recData[index].id;
      if (!this.keyPairs[index]) {
        this.keyPairs[index] = { inputs: "", score: "" };
      }
      if (typeof value == 'string' && value.constructor == String) this.keyPairs[index].inputs[seq] = value;else this.keyPairs[index].inputs[seq] = value.target.value;
    }
  }, {
    key: 'ondateChange',
    value: function ondateChange(index, seq, date, dateString) {
      index = this.state.recData[index].id;
      //console.log(dateString);
      if (!this.keyPairs[index]) this.keyPairs[index] = { inputs: "", score: "" };
      this.keyPairs[index].inputs[seq] = dateString;
      //console.log(this.keyPairs);
    }
  }, {
    key: 'onCompleteChange',
    value: function onCompleteChange(index, value) {
      index = this.state.recData[index].id;
      // if(!this.keyPairs[index]){
      //     this.keyPairs[index] = {inputs:"", score:""}
      // }
      if (typeof value == 'string' && value.constructor == String) this.keyPairs[index].inputs = value;else this.keyPairs[index].inputs = value.target.value;
      // console.log(this.keyPairs)
    }
  }, {
    key: 'onRemarkChange',
    value: function onRemarkChange(index, value) {
      index = this.state.recData[index].id;
      if (typeof value == 'string' && value.constructor == String) this.keyPairs[index].remarks = value;else this.keyPairs[index].remarks = value.target.value;
      // console.log(this.keyPairs)
    }
  }, {
    key: 'spToInput',
    value: function spToInput(data, index) {
      var subject = data + "";
      var regex = /.*?(##|#number#|#date#|\n)/g;
      var matched = null;
      var str;
      var sp;
      var lastStrLoc;
      var jsxs = [];
      var i = 0;
      while (matched = regex.exec(subject)) {
        str = matched[0];
        sp = matched[1];
        lastStrLoc = matched.index + str.length;
        //console.log(str.substring(0, str.indexOf(sp)));
        jsxs.push(_react3.default.createElement(
          'span',
          null,
          str.substring(0, str.indexOf(sp))
        ));
        //console.log(sp);
        switch (sp) {
          case "##":
            jsxs.push(_react3.default.createElement(TextArea, { autosize: { minRows: 1 }, defaultValue: "", onChange: this.onChange.bind(this, index, i) }));
            i++;
            break;
          case "#number#":
            jsxs.push(_react3.default.createElement(_inputNumber2.default, { defaultValue: 0, onChange: this.onChange.bind(this, index, i) }));
            i++;
            break;
          case "#date#":
            jsxs.push(_react3.default.createElement(_datePicker2.default, { format: dateFormat, showToday: true, onChange: this.ondateChange.bind(this, index, i) }));
            i++;
            break;
          case "\n":
            jsxs.push(_react3.default.createElement('br', null));
            break;
        }
      }
      jsxs.push(_react3.default.createElement(
        'span',
        null,
        subject.substring(lastStrLoc)
      ));
      return jsxs;
    }
  }, {
    key: 'submit',
    value: function submit() {
      //console.log(this.props.jumpUrl)
      var result = {};
      result["selfEvaluate"] = this.keyPairs;
      result["evaluateName"] = this.state.evaluateName;
      var total = 100;
      for (var i in result.selfEvaluate) {
        total += parseFloat(result.selfEvaluate[i].score);
      }
      total = total.toFixed(2);
      result["total"] = total;
      // console.log(result);
      var self = this;
      //发给后台的数据
      $.ajax({
        type: "post",
        url: self.props.selfEvaluateUrl,
        data: JSON.stringify(result),
        dataType: 'json',
        contentType: 'application/json',
        success: function success(data) {
          if (data.status > 0) {
            window.location.href = self.props.jumpUrl;
          } else {
            _modal2.default.error({
              title: '错误信息',
              content: '保存失败！'
            });
          }
        },
        error: function error(data) {
          alert("失败");
        }
      });
    }
  }, {
    key: 'genRejectrReason',
    value: function genRejectrReason() {
      var personal;
      var bumen;
      var kpgroup;
      for (var i in this.state.recData) {
        var self = this;
        if (self.state.recData[i].reason) {
          if (self.state.recData[i].reason.personal) {
            personal = "个人退回理由：" + self.state.recData[i].reason.personal;
          }
          if (self.state.recData[i].reason.bumen) {
            bumen = "部门退回理由：" + self.state.recData[i].reason.bumen;
          }
          if (self.state.recData[i].reason.kpgroup) {
            kpgroup = "考评组退回理由：" + self.state.recData[i].reason.kpgroup;
          }
        }
      }
      var reasons = [];
      reasons.push(personal, bumen, kpgroup);
      var reasonList = reasons.map(function (row) {
        return _react3.default.createElement(
          'p',
          null,
          row
        );
      });
      return reasonList;
    }
  }, {
    key: 'render',
    value: function render() {
      var _this3 = this;

      var recData = this.state.recData;
      var filterData = new _Filters2.default().filter(this.state.recData);
      // var remarks=[]
      // for(var i in recData){
      //    if(recData[i].remarks){
      //       remarks.push(recData[i].remarks); 
      //    }
      // }
      var columns = [{
        title: '项目',
        dataIndex: 'proName',
        width: 100,
        filters: filterData.proName,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.proName, b.proName);
        },
        onFilter: function onFilter(value, record) {
          return record.proName.indexOf(value) === 0;
        }
      }, {
        title: '子项目',
        dataIndex: 'childProName',
        width: 110,
        filters: filterData.childProName,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.childProName, b.childProName);
        },
        onFilter: function onFilter(value, record) {
          return record.childProName.indexOf(value) === 0;
        },
        render: function render(text, record, index) {
          return _this3.spToInput(text, index);
        }
      }, {
        title: '工作职责',
        dataIndex: 'jobResponsibility',
        width: 180,
        render: function render(text, record, index) {
          return _this3.spToInput(text, index);
        }
      }, {
        title: '工作标准',
        dataIndex: 'jobStandard',
        width: 180,
        render: function render(text, record, index) {
          return _this3.spToInput(text, index);
        }
      }, {
        title: '完成情况',
        dataIndex: 'complete',
        children: [{
          title: "个人",
          dataIndex: "personal",
          width: 240,
          render: function render(text, record, index) {
            return _react3.default.createElement(TextArea, { defaultValue: recData[index].personal.complete, autosize: { minRows: 4, maxRows: 10 }, onChange: _this3.onCompleteChange.bind(_this3, index) });
          }
        }, {
          title: "部门",
          dataIndex: "department",
          width: 240,
          render: function render(text, record, index) {
            return _react3.default.createElement(TextArea, { disabled: true, autosize: { minRows: 4, maxRows: 10 } });
          }
        }, {
          title: "考评组",
          dataIndex: "kpGroup",
          width: 240,
          render: function render(text, record, index) {
            return _react3.default.createElement(TextArea, { disabled: true, autosize: { minRows: 4, maxRows: 10 } });
          }
        }]
      }, {
        title: '备注',
        dataIndex: 'remarks',
        width: 180,
        render: function render(text, record, index) {
          return _react3.default.createElement(TextArea, { defaultValue: recData[index].remarks, autosize: { minRows: 4, maxRows: 10 }, onChange: _this3.onRemarkChange.bind(_this3, index) });
        }
      }, {
        title: '评分标准',
        dataIndex: 'scoreStandard',
        width: 200,
        render: function render(text, record, index) {
          return _this3.spToInput(text, index);
        }
      }, {
        title: '评分',
        dataIndex: 'pingfen',
        children: [{
          title: "自评",
          dataIndex: "score",
          width: 30,
          render: function render(text, record, index) {
            return _react3.default.createElement(_inputNumber2.default, { defaultValue: recData[index].personal.score == null ? 0 : recData[index].personal.score, onChange: _this3.onScoreChange.bind(_this3, index) });
          }
        }, {
          title: "部门",
          dataIndex: "bumen",
          width: 30,
          render: function render(text, record, index) {
            return _react3.default.createElement(_inputNumber2.default, { disabled: true });
          }
        }, {
          title: "考评组",
          dataIndex: "pfgroup",
          width: 30,
          render: function render(text, record, index) {
            return _react3.default.createElement(_inputNumber2.default, { disabled: true });
          }
        }]
      }];
      var _state = this.state,
          loading = _state.loading,
          selectedRowKeys = _state.selectedRowKeys;

      var rowSelection = {
        selectedRowKeys: selectedRowKeys,
        onChange: this.onSelectChange.bind(this)
      };
      var hasSelected = selectedRowKeys.length > 0;
      var i = 0;
      return _react3.default.createElement(
        'div',
        { style: { marginBottom: 100 } },
        _react3.default.createElement(
          'div',
          { id: 'header' },
          _react3.default.createElement(
            'h2',
            null,
            this.state.evaluateName
          )
        ),
        _react3.default.createElement(
          'div',
          { style: { marginBottom: 5, height: 20 } },
          _react3.default.createElement(
            'span',
            { style: { marginLeft: 8, float: 'left' } },
            hasSelected ? '\u5DF2\u9009\u62E9 ' + selectedRowKeys.length + ' \u6761' : ''
          ),
          _react3.default.createElement(
            'div',
            { style: { paddingLeft: '10px', color: 'red', float: 'left' } },
            this.genRejectrReason()
          )
        ),
        _react3.default.createElement('div', { style: { clear: 'both' } }),
        _react3.default.createElement(_table2.default, { scroll: { x: 1200 }, bordered: true, rowSelection: rowSelection, pagination: false, columns: columns, dataSource: this.state.recData }),
        _react3.default.createElement(
          'div',
          { style: { margin: '10px 0' } },
          _react3.default.createElement(
            'span',
            { style: { float: 'right', fontSize: 16, color: 'red' } },
            '\u81EA\u8BC4\u603B\u5206\uFF1A',
            this.state.totalZiping ? this.state.totalZiping : 100
          )
        ),
        _react3.default.createElement('div', { style: { clear: 'both' } }),
        _react3.default.createElement(
          'div',
          { style: { margin: '10px 0' } },
          _react3.default.createElement(
            _button2.default,
            { type: 'primary', style: { margin: '0 0 0 15px', float: 'right', padding: '6px 30px' }, onClick: this.submit.bind(this) },
            '\u63D0\u4EA4'
          )
        )
      );
    }
  }]);

  return Performance;
}(_react3.default.Component));

if (document.getElementById("personalPerformance")) _reactDom2.default.render(_react3.default.createElement(Performance, pageUrls), document.getElementById("personalPerformance"));
exports.default = Performance;
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(14)(module), __webpack_require__(16)))

/***/ }),

/***/ 154:
/***/ (function(module, exports) {

function arrayTreeFilter(data, filterFn, options) {
  options = options || {};
  options.childrenKeyName = options.childrenKeyName || 'children';
  var children = data || [];
  var result = [];
  var level = 0;
  var foundItem;
  do {
    var foundItem = children.filter(function(item) {
      return filterFn(item, level);
    })[0];
    if (!foundItem) {
      break;
    }
    result.push(foundItem);
    children = foundItem[options.childrenKeyName] || [];
    level += 1;
  } while(children.length > 0);
  return result;
}

module.exports = arrayTreeFilter;


/***/ }),

/***/ 177:
/***/ (function(module, exports, __webpack_require__) {

exports = module.exports = __webpack_require__(24)();
// imports


// module
exports.push([module.i, "/* stylelint-disable at-rule-empty-line-before,at-rule-name-space-after,at-rule-no-unknown */\n/* stylelint-disable declaration-bang-space-before */\n/* stylelint-disable declaration-bang-space-before */\n.ant-cascader {\n  font-size: 12px;\n}\n.ant-cascader-input.ant-input {\n  background-color: transparent !important;\n  cursor: pointer;\n  width: 100%;\n  display: block;\n}\n.ant-cascader-picker {\n  position: relative;\n  display: inline-block;\n  cursor: pointer;\n  font-size: 12px;\n  background-color: #fff;\n  border-radius: 4px;\n  outline: 0;\n}\n.ant-cascader-picker-with-value .ant-cascader-picker-label {\n  color: transparent;\n}\n.ant-cascader-picker-disabled {\n  cursor: not-allowed;\n  background: #f7f7f7;\n  color: rgba(0, 0, 0, 0.25);\n}\n.ant-cascader-picker-disabled .ant-cascader-input {\n  cursor: not-allowed;\n}\n.ant-cascader-picker:focus .ant-cascader-input {\n  border-color: #49a9ee;\n  outline: 0;\n  box-shadow: 0 0 0 2px rgba(16, 142, 233, 0.2);\n}\n.ant-cascader-picker-label {\n  position: absolute;\n  left: 0;\n  height: 20px;\n  line-height: 20px;\n  top: 50%;\n  margin-top: -10px;\n  white-space: nowrap;\n  text-overflow: ellipsis;\n  overflow: hidden;\n  width: 100%;\n  padding: 0 12px 0 8px;\n}\n.ant-cascader-picker-clear {\n  opacity: 0;\n  position: absolute;\n  right: 8px;\n  z-index: 2;\n  background: #fff;\n  top: 50%;\n  font-size: 12px;\n  color: rgba(0, 0, 0, 0.25);\n  width: 12px;\n  height: 12px;\n  margin-top: -6px;\n  line-height: 12px;\n  cursor: pointer;\n  transition: color 0.3s ease, opacity 0.15s ease;\n}\n.ant-cascader-picker-clear:hover {\n  color: rgba(0, 0, 0, 0.43);\n}\n.ant-cascader-picker:hover .ant-cascader-picker-clear {\n  opacity: 1;\n}\n.ant-cascader-picker-arrow {\n  position: absolute;\n  z-index: 1;\n  top: 50%;\n  right: 8px;\n  width: 12px;\n  height: 12px;\n  margin-top: -6px;\n  line-height: 12px;\n  color: rgba(0, 0, 0, 0.43);\n  display: inline-block;\n  font-size: 12px;\n  font-size: 9px \\9;\n  -ms-transform: scale(0.75) rotate(0deg);\n      transform: scale(0.75) rotate(0deg);\n  /* IE6-IE8 */\n  -ms-filter: \"progid:DXImageTransform.Microsoft.Matrix(sizingMethod='auto expand', M11=1, M12=0, M21=0, M22=1)\";\n  zoom: 1;\n}\n:root .ant-cascader-picker-arrow {\n  -webkit-filter: none;\n          filter: none;\n}\n:root .ant-cascader-picker-arrow {\n  font-size: 12px;\n}\n.ant-cascader-picker-arrow:before {\n  transition: transform 0.2s ease;\n}\n.ant-cascader-picker-arrow.ant-cascader-picker-arrow-expand {\n  -ms-filter: \"progid:DXImageTransform.Microsoft.BasicImage(rotation=2)\";\n}\n.ant-cascader-picker-arrow.ant-cascader-picker-arrow-expand:before {\n  -ms-transform: rotate(180deg);\n      transform: rotate(180deg);\n}\n.ant-cascader-menus {\n  font-size: 12px;\n  background: #fff;\n  position: absolute;\n  z-index: 1050;\n  border-radius: 4px;\n  box-shadow: 0 1px 6px rgba(0, 0, 0, 0.2);\n  white-space: nowrap;\n}\n.ant-cascader-menus-empty,\n.ant-cascader-menus-hidden {\n  display: none;\n}\n.ant-cascader-menus.slide-up-enter.slide-up-enter-active.ant-cascader-menus-placement-bottomLeft,\n.ant-cascader-menus.slide-up-appear.slide-up-appear-active.ant-cascader-menus-placement-bottomLeft {\n  animation-name: antSlideUpIn;\n}\n.ant-cascader-menus.slide-up-enter.slide-up-enter-active.ant-cascader-menus-placement-topLeft,\n.ant-cascader-menus.slide-up-appear.slide-up-appear-active.ant-cascader-menus-placement-topLeft {\n  animation-name: antSlideDownIn;\n}\n.ant-cascader-menus.slide-up-leave.slide-up-leave-active.ant-cascader-menus-placement-bottomLeft {\n  animation-name: antSlideUpOut;\n}\n.ant-cascader-menus.slide-up-leave.slide-up-leave-active.ant-cascader-menus-placement-topLeft {\n  animation-name: antSlideDownOut;\n}\n.ant-cascader-menu {\n  display: inline-block;\n  vertical-align: top;\n  min-width: 111px;\n  height: 180px;\n  list-style: none;\n  margin: 0;\n  padding: 0;\n  border-right: 1px solid #e9e9e9;\n  overflow: auto;\n}\n.ant-cascader-menu:first-child {\n  border-radius: 4px 0 0 4px;\n}\n.ant-cascader-menu:last-child {\n  border-right-color: transparent;\n  margin-right: -1px;\n  border-radius: 0 4px 4px 0;\n}\n.ant-cascader-menu:only-child {\n  border-radius: 4px;\n}\n.ant-cascader-menu-item {\n  padding: 7px 8px;\n  cursor: pointer;\n  white-space: nowrap;\n  transition: all 0.3s;\n}\n.ant-cascader-menu-item:hover {\n  background: #ecf6fd;\n}\n.ant-cascader-menu-item-disabled {\n  cursor: not-allowed;\n  color: rgba(0, 0, 0, 0.25);\n}\n.ant-cascader-menu-item-disabled:hover {\n  background: transparent;\n}\n.ant-cascader-menu-item-active:not(.ant-cascader-menu-item-disabled),\n.ant-cascader-menu-item-active:not(.ant-cascader-menu-item-disabled):hover {\n  background: #f7f7f7;\n  font-weight: 600;\n}\n.ant-cascader-menu-item-expand {\n  position: relative;\n  padding-right: 24px;\n}\n.ant-cascader-menu-item-expand:after {\n  font-family: 'anticon';\n  text-rendering: optimizeLegibility;\n  -webkit-font-smoothing: antialiased;\n  -moz-osx-font-smoothing: grayscale;\n  content: \"\\E61F\";\n  display: inline-block;\n  font-size: 12px;\n  font-size: 8px \\9;\n  -ms-transform: scale(0.66666667) rotate(0deg);\n      transform: scale(0.66666667) rotate(0deg);\n  /* IE6-IE8 */\n  -ms-filter: \"progid:DXImageTransform.Microsoft.Matrix(sizingMethod='auto expand', M11=1, M12=0, M21=0, M22=1)\";\n  zoom: 1;\n  color: rgba(0, 0, 0, 0.43);\n  position: absolute;\n  right: 8px;\n}\n:root .ant-cascader-menu-item-expand:after {\n  -webkit-filter: none;\n          filter: none;\n}\n:root .ant-cascader-menu-item-expand:after {\n  font-size: 12px;\n}\n.ant-cascader-menu-item-loading:after {\n  font-family: 'anticon';\n  text-rendering: optimizeLegibility;\n  -webkit-font-smoothing: antialiased;\n  -moz-osx-font-smoothing: grayscale;\n  content: \"\\E64D\";\n  animation: loadingCircle 1s infinite linear;\n}\n.ant-cascader-menu-item .ant-cascader-menu-item-keyword {\n  color: #f04134;\n}\n", ""]);

// exports


/***/ }),

/***/ 196:
/***/ (function(module, exports, __webpack_require__) {

exports = module.exports = __webpack_require__(24)();
// imports


// module
exports.push([module.i, "/* stylelint-disable at-rule-empty-line-before,at-rule-name-space-after,at-rule-no-unknown */\n/* stylelint-disable declaration-bang-space-before */\n/* stylelint-disable declaration-bang-space-before */\n@keyframes antCheckboxEffect {\n  0% {\n    transform: scale(1);\n    opacity: 0.5;\n  }\n  100% {\n    transform: scale(1.6);\n    opacity: 0;\n  }\n}\n.ant-transfer {\n  position: relative;\n  line-height: 1.5;\n}\n.ant-transfer-list {\n  font-size: 12px;\n  border: 1px solid #d9d9d9;\n  display: inline-block;\n  border-radius: 4px;\n  vertical-align: middle;\n  position: relative;\n  width: 180px;\n  height: 200px;\n  padding-top: 33px;\n}\n.ant-transfer-list-with-footer {\n  padding-bottom: 33px;\n}\n.ant-transfer-list-search-action {\n  color: rgba(0, 0, 0, 0.25);\n  position: absolute;\n  top: 4px;\n  right: 4px;\n  bottom: 4px;\n  width: 28px;\n  line-height: 26px;\n  text-align: center;\n  font-size: 14px;\n}\n.ant-transfer-list-search-action .anticon {\n  transition: all .3s;\n  font-size: 12px;\n  color: rgba(0, 0, 0, 0.25);\n}\n.ant-transfer-list-search-action .anticon:hover {\n  color: rgba(0, 0, 0, 0.43);\n}\nspan.ant-transfer-list-search-action {\n  pointer-events: none;\n}\n.ant-transfer-list-header {\n  padding: 7px 15px;\n  border-radius: 4px 4px 0 0;\n  background: #fff;\n  color: rgba(0, 0, 0, 0.65);\n  border-bottom: 1px solid #e9e9e9;\n  overflow: hidden;\n  position: absolute;\n  top: 0;\n  left: 0;\n  width: 100%;\n}\n.ant-transfer-list-header-title {\n  position: absolute;\n  right: 15px;\n}\n.ant-transfer-list-body {\n  font-size: 12px;\n  position: relative;\n  height: 100%;\n}\n.ant-transfer-list-body-search-wrapper {\n  position: absolute;\n  top: 0;\n  left: 0;\n  padding: 4px;\n  width: 100%;\n}\n.ant-transfer-list-body-with-search {\n  padding-top: 34px;\n}\n.ant-transfer-list-content {\n  height: 100%;\n  overflow: auto;\n}\n.ant-transfer-list-content > .LazyLoad {\n  animation: transferHighlightIn 1s;\n}\n.ant-transfer-list-content-item {\n  overflow: hidden;\n  white-space: nowrap;\n  text-overflow: ellipsis;\n  padding: 7px 15px;\n  min-height: 32px;\n  transition: all .3s;\n}\n.ant-transfer-list-content-item:not(.ant-transfer-list-content-item-disabled):hover {\n  cursor: pointer;\n  background-color: #ecf6fd;\n}\n.ant-transfer-list-content-item-disabled {\n  cursor: not-allowed;\n  color: rgba(0, 0, 0, 0.25);\n}\n.ant-transfer-list-body-not-found {\n  padding-top: 0;\n  color: rgba(0, 0, 0, 0.25);\n  text-align: center;\n  display: none;\n  position: absolute;\n  top: 50%;\n  width: 100%;\n  margin-top: -10px;\n}\n.ant-transfer-list-content:empty + .ant-transfer-list-body-not-found {\n  display: block;\n}\n.ant-transfer-list-footer {\n  border-top: 1px solid #e9e9e9;\n  border-radius: 0 0 4px 4px;\n  position: absolute;\n  bottom: 0;\n  left: 0;\n  width: 100%;\n}\n.ant-transfer-operation {\n  display: inline-block;\n  overflow: hidden;\n  margin: 0 8px;\n  vertical-align: middle;\n}\n.ant-transfer-operation .ant-btn {\n  display: block;\n}\n.ant-transfer-operation .ant-btn:first-child {\n  margin-bottom: 4px;\n}\n.ant-transfer-operation .ant-btn .anticon {\n  display: inline-block;\n  font-size: 12px;\n  font-size: 10px \\9;\n  -ms-transform: scale(0.83333333) rotate(0deg);\n      transform: scale(0.83333333) rotate(0deg);\n  /* IE6-IE8 */\n  -ms-filter: \"progid:DXImageTransform.Microsoft.Matrix(sizingMethod='auto expand', M11=1, M12=0, M21=0, M22=1)\";\n  zoom: 1;\n}\n:root .ant-transfer-operation .ant-btn .anticon {\n  -webkit-filter: none;\n          filter: none;\n}\n:root .ant-transfer-operation .ant-btn .anticon {\n  font-size: 12px;\n}\n@keyframes transferHighlightIn {\n  0% {\n    background: #d2eafb;\n  }\n  100% {\n    background: transparent;\n  }\n}\n", ""]);

// exports


/***/ }),

/***/ 257:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
    value: true
});

var _classCallCheck2 = __webpack_require__(4);

var _classCallCheck3 = _interopRequireDefault(_classCallCheck2);

var _createClass2 = __webpack_require__(7);

var _createClass3 = _interopRequireDefault(_createClass2);

var _possibleConstructorReturn2 = __webpack_require__(6);

var _possibleConstructorReturn3 = _interopRequireDefault(_possibleConstructorReturn2);

var _inherits2 = __webpack_require__(5);

var _inherits3 = _interopRequireDefault(_inherits2);

var _react = __webpack_require__(0);

var _react2 = _interopRequireDefault(_react);

var _icon = __webpack_require__(42);

var _icon2 = _interopRequireDefault(_icon);

var _input = __webpack_require__(28);

var _input2 = _interopRequireDefault(_input);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var Search = function (_React$Component) {
    (0, _inherits3['default'])(Search, _React$Component);

    function Search() {
        (0, _classCallCheck3['default'])(this, Search);

        var _this = (0, _possibleConstructorReturn3['default'])(this, (Search.__proto__ || Object.getPrototypeOf(Search)).apply(this, arguments));

        _this.handleChange = function (e) {
            var onChange = _this.props.onChange;
            if (onChange) {
                onChange(e);
            }
        };
        _this.handleClear = function (e) {
            e.preventDefault();
            var handleClear = _this.props.handleClear;
            if (handleClear) {
                handleClear(e);
            }
        };
        return _this;
    }

    (0, _createClass3['default'])(Search, [{
        key: 'render',
        value: function render() {
            var _props = this.props,
                placeholder = _props.placeholder,
                value = _props.value,
                prefixCls = _props.prefixCls;

            var icon = value && value.length > 0 ? _react2['default'].createElement(
                'a',
                { href: '#', className: prefixCls + '-action', onClick: this.handleClear },
                _react2['default'].createElement(_icon2['default'], { type: 'cross-circle' })
            ) : _react2['default'].createElement(
                'span',
                { className: prefixCls + '-action' },
                _react2['default'].createElement(_icon2['default'], { type: 'search' })
            );
            return _react2['default'].createElement(
                'div',
                null,
                _react2['default'].createElement(_input2['default'], { placeholder: placeholder, className: prefixCls, value: value, ref: 'input', onChange: this.handleChange }),
                icon
            );
        }
    }]);
    return Search;
}(_react2['default'].Component);

exports['default'] = Search;

Search.defaultProps = {
    placeholder: ''
};
module.exports = exports['default'];

/***/ }),

/***/ 492:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(module, $) {

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _button = __webpack_require__(18);

var _button2 = _interopRequireDefault(_button);

var _transfer = __webpack_require__(568);

var _transfer2 = _interopRequireDefault(_transfer);

var _inputNumber = __webpack_require__(54);

var _inputNumber2 = _interopRequireDefault(_inputNumber);

var _modal = __webpack_require__(43);

var _modal2 = _interopRequireDefault(_modal);

var _cascader = __webpack_require__(518);

var _cascader2 = _interopRequireDefault(_cascader);

var _index = __webpack_require__(21);

var _index2 = _interopRequireDefault(_index);

var _index3 = __webpack_require__(19);

var _index4 = _interopRequireDefault(_index3);

var _react2 = __webpack_require__(0);

var _react3 = _interopRequireDefault(_react2);

var _index5 = __webpack_require__(20);

var _index6 = _interopRequireDefault(_index5);

var _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

__webpack_require__(22);

__webpack_require__(572);

__webpack_require__(55);

__webpack_require__(44);

__webpack_require__(519);

var _reactDom = __webpack_require__(11);

var _reactDom2 = _interopRequireDefault(_reactDom);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var _components = {
  Person: {
    displayName: 'Person'
  },
  Assign: {
    displayName: 'Assign'
  }
};

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2 = (0, _index6.default)({
  filename: '/Users/huang/work/dzoms_react/components/kp/assignResponsibility.js',
  components: _components,
  locals: [module],
  imports: [_react3.default]
});

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2 = (0, _index4.default)({
  filename: '/Users/huang/work/dzoms_react/components/kp/assignResponsibility.js',
  components: _components,
  locals: [],
  imports: [_react3.default, _index2.default]
});

function _wrapComponent(id) {
  return function (Component) {
    return _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2(_UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2(Component, id), id);
  };
}

var Person = _wrapComponent('Person')(function (_React$Component) {
  _inherits(Person, _React$Component);

  function Person(props) {
    _classCallCheck(this, Person);

    var _this = _possibleConstructorReturn(this, (Person.__proto__ || Object.getPrototypeOf(Person)).call(this, props));

    _this.state = {
      personId: "",
      newOptions: ""
    };
    return _this;
  }

  _createClass(Person, [{
    key: 'componentDidMount',
    value: function componentDidMount() {
      $.ajax({
        //url:"/person",
        url: this.props.userUrl,
        type: "get",
        dataType: 'json',
        contentType: 'application/json',
        success: function (data) {
          if (data) {
            var persondata = data;
            var options = [];
            var children = [];
            for (var i in persondata) {
              var flag = false;
              //检验该department是否已经存在在列表中
              var person = {
                value: persondata[i].uname,
                label: persondata[i].uname,
                id: persondata[i].uid
              };
              for (var j in options) {
                //如果存在 追加children
                if (options[j].value == persondata[i].department) {
                  options[j].children.push(person);
                  flag = true;
                  break;
                }
              }
              //如果不在 加入新的option
              if (!flag) {
                options.push({
                  value: persondata[i].department,
                  label: persondata[i].department,
                  children: [person]
                });
              }
            }
            this.setState({
              newOptions: options
            });
          } else {
            options: "";
          }
        }.bind(this),
        error: function error() {
          alert("请求失败");
        }
      });
    }
  }, {
    key: 'onChange',
    value: function onChange(value) {
      var targetKeys = [];
      var department = value[0];
      var options = this.state.newOptions;
      var id = "";
      for (var i in options) {
        if (options[i].value == value[0]) {
          for (var j in options[i].children) {
            if (options[i].children[j].value == value[1]) {
              id = options[i].children[j].id;
            }
          }
        }
      }
      this.setState({
        personId: id
      });
      //传输人的id,以及
      this.props.transferTargetkeys(targetKeys);
      this.props.transferDepartment(department);
      if (id != "") {
        this.props.changeId(id);
      }
    }
  }, {
    key: 'render',
    value: function render() {
      //console.log(this.props.url);
      return _react3.default.createElement(_cascader2.default, { style: { marginBottom: 15 }, options: this.state.newOptions, onChange: this.onChange.bind(this), placeholder: '\u804C\u5458\u9009\u62E9' });
    }
  }]);

  return Person;
}(_react3.default.Component));

var Assign = _wrapComponent('Assign')(function (_React$Component2) {
  _inherits(Assign, _React$Component2);

  function Assign(props) {
    _classCallCheck(this, Assign);

    var _this2 = _possibleConstructorReturn(this, (Assign.__proto__ || Object.getPrototypeOf(Assign)).call(this, props));

    _this2.state = {
      mockData: [],
      targetKeys: [],
      personId: "",
      recData: "",
      score: [],
      zongfen: "",
      department: ""
    };
    _this2.keyPairs = [];
    _this2.data = [];
    return _this2;
  }

  _createClass(Assign, [{
    key: 'componentDidMount',
    value: function componentDidMount() {
      $.ajax({
        url: this.props.url,
        type: "get",
        dataType: 'json',
        contentType: 'application/json',
        success: function (data) {
          var data = data.data;
          if (data) {
            for (var i = 0; i < data.length; i++) {
              data[i]["key"] = data[i].id;
            }
            //console.log(data);
            this.data = data;
            var mockData = data;
            var targetKeys = [];
            this.setState({ mockData: mockData, targetKeys: targetKeys });
          } else {
            recData: "";
          }
        }.bind(this),
        error: function error() {
          alert("请求失败");
        }
      });
    }
  }, {
    key: 'transferTargetkeys',
    value: function transferTargetkeys(targetKeys) {
      this.setState({
        targetKeys: targetKeys
      });
    }
  }, {
    key: 'transferDepartment',
    value: function transferDepartment(department) {
      var newMockData = [];
      this.data.map(function (i) {
        if (i.department == department) {
          newMockData.push(i);
        }
      });
      console.log(newMockData);
      this.setState({
        mockData: newMockData
      });
    }
  }, {
    key: 'handleChange',
    value: function handleChange(targetKeys, direction, moveKeys) {
      this.setState({ targetKeys: targetKeys });
    }
  }, {
    key: 'onChange',
    value: function onChange(key, value) {
      if (!this.keyPairs[key]) {
        this.keyPairs[key] = {};
      }
      if (!value || value === "") value = 0;
      this.keyPairs[key] = value;
    }
  }, {
    key: 'onBlur',
    value: function onBlur() {}
  }, {
    key: 'confirm',
    value: function confirm(item) {
      var result = { personId: this.state.personId, jobList: {} };
      var tranResult;
      var selectedRows = [];
      if (this.state.targetKeys.length > 0) {
        var that = this;
        this.state.targetKeys.map(function (item, index) {
          return result.jobList[item] = that.keyPairs[item];
        });
      }

      if (result.personId === "") {
        _modal2.default.error({
          title: '错误信息',
          content: '请选择分配职员'
        });
        return;
      } else {
        tranResult = result;
        // console.log(tranResult)  
        var self = this;
        $.ajax({
          type: "post",
          url: this.props.userJobUrl,
          data: JSON.stringify(tranResult),
          dataType: 'json',
          contentType: 'application/json',
          success: function success(data) {
            if (data.status > 0) {
              _modal2.default.success({
                title: '提示信息',
                content: '分配成功！',
                onOk: function onOk() {
                  history.go(0);
                }
              });
            } else {
              _modal2.default.error({
                title: '错误信息',
                content: '分配失败！'
              });
            }
          },
          error: function error(data) {
            alert("失败");
          }
        });
      }
    }
  }, {
    key: 'changeId',
    value: function changeId(id) {
      // console.log(id);
      this.setState({
        personId: id
      });
      this.keyPairs = [];
      //根据传过来的id 判断该人是否有分配过任务
      $.ajax({
        url: this.props.userJobUrl + "/" + id,
        // url:"/hasPersonData",
        type: "get",
        dataType: 'json',
        contentType: 'application/json',
        success: function (data) {
          console.log(data.data);
          if (data.data.length > 0) {
            var keys = [];
            var score = [];
            for (var i in data.data) {
              keys.push(data.data[i].key || data.data[i].id);
              score[data.data[i].key] = data.data[i].sortId;
              // score[data.data[i].key]=data.data[i].score;
            }
            //this.hasPersonData(keys,score); //上面的组件选择完人，调用该方法    
            if (keys.length > 0) {
              this.setState({
                targetKeys: keys,
                score: score
              });
              this.keyPairs = score;
            } else {
              this.keyPairs = [];
            }
          } else {
            this.setState({
              targetKeys: [],
              score: []
            });
          }
        }.bind(this),
        error: function error() {
          alert("请求失败");
        }
      });
    }
  }, {
    key: 'hasPersonData',
    value: function hasPersonData(keys, score) {//该方法用于判断该人是否分配过任务       
    }
  }, {
    key: 'renderItem',
    value: function renderItem(item) {
      var _this3 = this;

      var selectedKeys = [];
      if (this.state.targetKeys.length > 0) {
        this.state.targetKeys.map(function (i) {
          selectedKeys.push(i);
        });
      }
      var customLabel;
      var flag = false;
      for (var i in selectedKeys) {
        if (item.key == selectedKeys[i]) {
          flag = true;
          break;
        }
      }
      if (flag) {
        customLabel = _react3.default.createElement(
          'span',
          { className: 'custom-item' },
          _react3.default.createElement(_inputNumber2.default, {
            defaultValue: this.state.score[item.key],
            min: 0,
            max: 100,
            formatter: function formatter(value) {
              return '' + value;
            }
            // parser={value => value.replace('%', '')}
            , onBlur: this.onBlur.bind(this),
            onChange: this.onChange.bind(this, item.key),
            placeholder: '\u5E8F\u5217\u53F7',
            ref: function ref(input) {
              _this3.textInput = item.key;
            }
          }),
          item.proName,
          ' / ',
          item.childProName,
          ' / ',
          item.jobResponsibility
        );
      } else {
        customLabel = _react3.default.createElement(
          'span',
          { className: 'custom-item' },
          item.proName,
          ' / ',
          item.childProName,
          ' / ',
          item.jobResponsibility
        );
      }
      return {
        label: customLabel, // for displayed item
        value: item.title // for title and filter matching
      };
    }
  }, {
    key: 'cancel',
    value: function cancel() {
      history.go(0);
    }
  }, {
    key: 'render',
    value: function render() {
      var _this4 = this;

      var btnstyle = {
        float: "right",
        marginTop: "10px",
        marginRight: "130px"
      };
      return _react3.default.createElement(
        'div',
        null,
        _react3.default.createElement(Person, _extends({}, pageUrls, { changeId: this.changeId.bind(this), transferTargetkeys: function transferTargetkeys(targetKeys) {
            return _this4.transferTargetkeys(targetKeys);
          }, transferDepartment: function transferDepartment(department) {
            return _this4.transferDepartment(department);
          } })),
        _react3.default.createElement(_transfer2.default, {
          dataSource: this.state.mockData,
          listStyle: {
            width: "45%",
            minHeight: 500
          },
          targetKeys: this.state.targetKeys,
          onChange: this.handleChange.bind(this),
          render: this.renderItem.bind(this)
        }),
        _react3.default.createElement(
          'div',
          { style: btnstyle },
          _react3.default.createElement(
            _button2.default,
            { style: { marginRight: 5 }, onClick: this.confirm.bind(this), type: 'primary' },
            '\u63D0\u4EA4'
          ),
          _react3.default.createElement(
            _button2.default,
            { type: 'primary', onClick: this.cancel.bind(this) },
            '\u53D6\u6D88'
          )
        )
      );
    }
  }]);

  return Assign;
}(_react3.default.Component));

if (document.getElementById("assignResponsibility")) _reactDom2.default.render(_react3.default.createElement(Assign, pageUrls), document.getElementById("assignResponsibility"));
exports.default = Assign;
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(14)(module), __webpack_require__(16)))

/***/ }),

/***/ 493:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function($) {

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _button = __webpack_require__(18);

var _button2 = _interopRequireDefault(_button);

var _table = __webpack_require__(31);

var _table2 = _interopRequireDefault(_table);

var _inputNumber = __webpack_require__(54);

var _inputNumber2 = _interopRequireDefault(_inputNumber);

var _modal = __webpack_require__(43);

var _modal2 = _interopRequireDefault(_modal);

var _datePicker = __webpack_require__(35);

var _datePicker2 = _interopRequireDefault(_datePicker);

var _input = __webpack_require__(28);

var _input2 = _interopRequireDefault(_input);

var _form = __webpack_require__(29);

var _form2 = _interopRequireDefault(_form);

var _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

__webpack_require__(22);

__webpack_require__(32);

__webpack_require__(55);

__webpack_require__(44);

__webpack_require__(36);

__webpack_require__(23);

__webpack_require__(30);

var _react = __webpack_require__(0);

var _react2 = _interopRequireDefault(_react);

var _reactDom = __webpack_require__(11);

var _reactDom2 = _interopRequireDefault(_reactDom);

var _personalPerformance = __webpack_require__(119);

var _personalPerformance2 = _interopRequireDefault(_personalPerformance);

var _moment = __webpack_require__(1);

var _moment2 = _interopRequireDefault(_moment);

var _Sorter = __webpack_require__(33);

var _Sorter2 = _interopRequireDefault(_Sorter);

var _Filters = __webpack_require__(40);

var _Filters2 = _interopRequireDefault(_Filters);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var FormItem = _form2.default.Item;
var TextArea = _input2.default.TextArea;
var MonthPicker = _datePicker2.default.MonthPicker,
    RangePicker = _datePicker2.default.RangePicker;

var dateFormat = 'YYYY/MM/DD';
var monthFormat = 'YYYY/MM';

var Bumenkp = function (_Performance) {
  _inherits(Bumenkp, _Performance);

  function Bumenkp(props) {
    _classCallCheck(this, Bumenkp);

    var _this = _possibleConstructorReturn(this, (Bumenkp.__proto__ || Object.getPrototypeOf(Bumenkp)).call(this, props));

    _this.state = {
      selectedRowKeys: [], // Check here to configure the default column
      loading: false,
      recData: [], //从后台接收到的数据
      newKey: 1,
      recScorezp: [],
      recInputs: [],
      evaluateName: "",
      totalZiping: "",
      totalBumen: "",
      visible: false,
      zipingList: []
    };
    _this.keyPairs = {};
    _this.key = 0;
    return _this;
  }

  _createClass(Bumenkp, [{
    key: 'componentDidUpdate',
    value: function componentDidUpdate() {
      var trs = document.querySelectorAll('tbody tr');
      // console.log(this.state.zipingList)
      //  console.log(trs)
      for (var i = 0; i < trs.length; i++) {
        if (this.state.zipingList[i] > 0) {
          trs[i].style.backgroundColor = "#95CFF4";
        } else if (this.state.zipingList[i] == 0) {
          trs[i].style.backgroundColor = "#fff";
        } else {
          trs[i].style.backgroundColor = "#F5B8C8";
        }
      }
    }
  }, {
    key: 'componentDidMount',
    value: function componentDidMount() {
      $.ajax({
        url: this.props.departmentEvaluate,
        type: "get",
        dataType: 'json',
        contentType: 'application/json',
        success: function (data) {
          var data = data.data;
          var evaluateName = "";
          var list = [];
          if (data) {
            for (var i = 0; i < data.length; i++) {
              data[i]["key"] = data[i].id;
              evaluateName = data[0].evaluateName;
            }
            var zipingSum = 100;
            var bumenSum = 100;
            for (var i in data) {
              zipingSum += parseFloat(data[i].personal.score);
              if (data[i].bumen.complete != null) {
                bumenSum += parseFloat(data[i].bumen.score);
              }
              list.push(data[i].personal.score);
            }
            for (var i in data) {
              if (!this.keyPairs[data[i].id]) {
                this.keyPairs[data[i].id] = { inputs: "", score: 0, remarks: "" };
                // this.keyPairs[data[i].id].score = data[i].childProValue
                this.keyPairs[data[i].id].remarks = data[i].remarks;
                if (data[i].bumen.score != null) {
                  // console.log(data[i].bumen.score);
                  this.keyPairs[data[i].id].inputs = data[i].bumen.complete;
                  this.keyPairs[data[i].id].score = data[i].bumen.score;
                }
              }
            }
            // console.log(this.keyPairs)
            zipingSum = zipingSum.toFixed(2);
            bumenSum = bumenSum.toFixed(2);
            this.setState({
              recData: data,
              evaluateName: evaluateName,
              totalZiping: zipingSum,
              totalBumen: bumenSum,
              zipingList: list
            });
          } else {
            recData: "";
          }
        }.bind(this),
        error: function error() {
          alert("请求失败");
        }
      });
    }
  }, {
    key: 'onScoreChange',
    value: function onScoreChange(index, value) {
      if (!value) {
        value = 0;
      }
      value = parseFloat(value).toFixed(2);
      index = this.state.recData[index].id;
      this.keyPairs[index].score = value;
      var sum = 100;
      for (var i in this.keyPairs) {
        sum += parseFloat(this.keyPairs[i].score);
      }
      sum = sum.toFixed(2);
      this.setState({
        totalBumen: sum
      });
    }
  }, {
    key: 'onCompleteChange',
    value: function onCompleteChange(index, value) {
      // console.log(index,value)
      index = this.state.recData[index].id;
      if (!this.keyPairs[index]) {
        this.keyPairs[index] = { inputs: "", score: "" };
      }
      if (typeof value == 'string' && value.constructor == String) this.keyPairs[index].inputs = value;else this.keyPairs[index].inputs = value.target.value;
      // console.log(this.keyPairs)
    }
  }, {
    key: 'spToInput',
    value: function spToInput(data, index) {
      var recInputs = this.state.recInputs;
      var subject = data + "";
      var regex = /.*?(##|#number#|#date#|\n)/g;
      var matched = null;
      var str;
      var sp;
      var lastStrLoc;
      var jsxs = [];
      var i = 0;
      while (matched = regex.exec(subject)) {
        str = matched[0];
        sp = matched[1];
        lastStrLoc = matched.index + str.length;
        jsxs.push(_react2.default.createElement(
          'span',
          null,
          str.substring(0, str.indexOf(sp))
        ));
        switch (sp) {
          case "##":
          case "#number#":
          case "#date#":
            jsxs.push(_react2.default.createElement(TextArea, { autosize: { minRows: 1 }, defaultValue: recInputs[index][i], disabled: !(this.props.department == "ziping"), onChange: this.onChange.bind(this, index, i) }));
            i++;
            break;
          case "\n":
            jsxs.push(_react2.default.createElement('br', null));
            break;
        }
      }
      jsxs.push(_react2.default.createElement(
        'span',
        null,
        subject.substring(lastStrLoc)
      ));
      return jsxs;
    }
    //部门退回 start

  }, {
    key: 'genRejectrReason',
    value: function genRejectrReason() {
      var personal;
      var bumen;
      var kpgroup;
      for (var i in this.state.recData) {
        var self = this;
        if (self.state.recData[i].reason) {
          if (self.state.recData[i].reason.personal) {
            personal = "个人退回理由：" + self.state.recData[i].reason.personal;
          }
          if (self.state.recData[i].reason.bumen) {
            bumen = "部门退回理由：" + self.state.recData[i].reason.bumen;
          }
          if (self.state.recData[i].reason.kpgroup) {
            kpgroup = "考评组退回理由：" + self.state.recData[i].reason.kpgroup;
          }
        }
      }
      var reasons = [];
      reasons.push(personal, bumen, kpgroup);
      var reasonList = reasons.map(function (row) {
        return _react2.default.createElement(
          'p',
          null,
          row
        );
      });
      return reasonList;
    }
  }, {
    key: 'returned',
    value: function returned() {
      this.setState({
        visible: true
      });
    }
  }, {
    key: 'handleOk',
    value: function handleOk(e) {
      var _this2 = this;

      //退回的提交
      this.props.form.validateFields(function (err, values) {
        values["taskId"] = _this2.props.departmentEvaluate.substring(_this2.props.departmentEvaluate.lastIndexOf('/') + 1, _this2.props.departmentEvaluate.length);
        if (!err) {
          var self = _this2;
          $.ajax({
            type: "post",
            url: self.props.regectUrl,
            data: JSON.stringify(values),
            dataType: 'json',
            contentType: 'application/json',
            success: function success(data) {
              self.setState({
                visible: false
              });
              if (data.status > 0) {
                _modal2.default.success({
                  title: '提示信息',
                  content: '回退成功！'
                });
                window.location.href = self.props.jumpUrl;
              } else {
                _modal2.default.error({
                  title: '提示信息',
                  content: '回退失败！'
                });
              }
            },
            error: function error(data) {
              alert("失败");
            }
          });
        }
      });
    }
  }, {
    key: 'onRemarkChange',
    value: function onRemarkChange(index, value) {
      index = this.state.recData[index].id;
      if (typeof value == 'string' && value.constructor == String) this.keyPairs[index].remarks = value;else this.keyPairs[index].remarks = value.target.value;
    }
  }, {
    key: 'handleCancel',
    value: function handleCancel(e) {
      this.setState({
        visible: false
      });
    }
  }, {
    key: 'submit',
    value: function submit() {
      //var result=this.keyPairs;
      var result = {};
      result["departmentEvaluate"] = this.keyPairs;
      result["evaluateName"] = this.state.evaluateName;
      var total = 100;
      for (var i in result.departmentEvaluate) {
        total += parseFloat(result.departmentEvaluate[i].score);
      }
      total = total.toFixed(2);
      result["total"] = total;
      // console.log(result); 
      //发给后台的数据
      var self = this;
      $.ajax({
        type: "post",
        url: self.props.departmentEvaluate,
        //url:"/test",
        data: JSON.stringify(result),
        dataType: 'json',
        contentType: 'application/json',
        success: function success(data) {
          if (data.status > 0) {
            window.location.href = self.props.jumpUrl;
          } else {
            _modal2.default.error({
              title: '错误信息',
              content: '保存失败！'
            });
          }
        },
        error: function error(data) {
          alert("失败");
        }
      });
    }
  }, {
    key: 'render',
    value: function render() {
      var _this3 = this;

      var formItemLayout = {
        labelCol: { span: 4 },
        wrapperCol: { span: 20 }
      };
      var recScorezp = this.state.recScorezp;
      var recData = this.state.recData;
      // var remarks=[]
      // for(var i in recData){
      //    if(recData[i].remarks){
      //    	 if(recData[i].bumen.score!=null){ //判断一下如果有bumen这个属性，就代表是退回状态，这时只需带着remarks即可 否则要拼接
      //    	 	remarks.push(recData[i].remarks); 
      //    	 }else{
      //    	 	remarks.push(recData[i].remarks+"\n部门备注："); 
      //    	 }
      //    }
      // }
      var filterData = new _Filters2.default().filter(this.state.recData);
      var columns = [{
        title: '项目',
        dataIndex: 'proName',
        width: 100,
        filters: filterData.proName,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.proName, b.proName);
        },
        onFilter: function onFilter(value, record) {
          return record.proName.indexOf(value) === 0;
        }
      }, {
        title: '子项目',
        dataIndex: 'childProName',
        width: 110,
        filters: filterData.childProName,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.childProName, b.childProName);
        },
        onFilter: function onFilter(value, record) {
          return record.childProName.indexOf(value) === 0;
        },
        render: function render(text, record, index) {
          return _this3.spToInput(text, index);
        }
      }, {
        title: '工作职责',
        dataIndex: 'jobResponsibility',
        width: 180,
        render: function render(text, record, index) {
          return _this3.spToInput(text, index);
        }
      }, {
        title: '工作标准',
        dataIndex: 'jobStandard',
        width: 180,
        render: function render(text, record, index) {
          return _this3.spToInput(text, index);
        }
      }, {
        title: '完成情况',
        dataIndex: 'complete',
        children: [{
          title: "个人",
          dataIndex: "personal",
          width: 240,
          render: function render(text, record, index) {
            return _react2.default.createElement(TextArea, { style: { color: "#757171" }, defaultValue: _this3.state.recData[index].personal.complete, autosize: { minRows: 4, maxRows: 10 }, disabled: true });
          }
        }, {
          title: "部门",
          dataIndex: "department",
          width: 240,
          render: function render(text, record, index) {
            return _react2.default.createElement(TextArea, { style: { color: "#757171" }, defaultValue: _this3.state.recData[index].bumen.complete ? _this3.state.recData[index].bumen.complete : "", autosize: { minRows: 4, maxRows: 10 }, onChange: _this3.onCompleteChange.bind(_this3, index) });
          }
        }, {
          title: "考评组",
          dataIndex: "kpGroup",
          width: 240,
          render: function render(text, record, index) {
            return _react2.default.createElement(TextArea, { style: { color: "#757171" }, disabled: true, autosize: { minRows: 4, maxRows: 10 } });
          }
        }]
      }, {
        title: '备注',
        dataIndex: 'remarks',
        width: 180,
        render: function render(text, record, index) {
          return _react2.default.createElement(TextArea, { defaultValue: recData[index].remarks, autosize: { minRows: 4, maxRows: 10 }, onChange: _this3.onRemarkChange.bind(_this3, index) });
        }
      }, {
        title: '评分标准',
        dataIndex: 'scoreStandard',
        width: 200,
        render: function render(text, record, index) {
          return _this3.spToInput(text, index);
        }
      }, {
        title: '评分',
        dataIndex: 'pingfen',
        children: [{
          title: "自评",
          dataIndex: "ziping",
          width: 20,
          render: function render(text, record, index) {
            return _react2.default.createElement(_inputNumber2.default, { defaultValue: _this3.state.recData[index].personal.score, disabled: true });
          }
        }, {
          title: "部门",
          dataIndex: "bumen",
          width: 20,
          render: function render(text, record, index) {
            return _react2.default.createElement(_inputNumber2.default, { defaultValue: _this3.state.recData[index].bumen.score == null ? 0 : _this3.state.recData[index].bumen.score, disabled: !(_this3.props.department == "bumen"), onChange: _this3.onScoreChange.bind(_this3, index) });
          }
        }, {
          title: "考评组",
          dataIndex: "pfgroup",
          width: 20,
          render: function render(text, record, index) {
            return _react2.default.createElement(_inputNumber2.default, { disabled: true });
          }
        }]
      }];

      var _state = this.state,
          loading = _state.loading,
          selectedRowKeys = _state.selectedRowKeys;

      var rowSelection = {
        selectedRowKeys: selectedRowKeys,
        onChange: this.onSelectChange.bind(this)
      };
      var hasSelected = selectedRowKeys.length > 0;
      var getFieldDecorator = this.props.form.getFieldDecorator;

      return _react2.default.createElement(
        'div',
        { style: { marginBottom: 100 } },
        _react2.default.createElement(
          'div',
          { id: 'header' },
          _react2.default.createElement(
            'h2',
            null,
            this.state.evaluateName
          )
        ),
        _react2.default.createElement(
          'div',
          { style: { marginBottom: 16, height: 20 } },
          _react2.default.createElement(
            'span',
            { style: { marginLeft: 8, float: 'left' } },
            hasSelected ? 'Selected ' + selectedRowKeys.length + ' items' : ''
          ),
          _react2.default.createElement(
            'div',
            { style: { paddingLeft: '10px', color: 'red', float: 'left' } },
            this.genRejectrReason()
          )
        ),
        _react2.default.createElement('div', { style: { clear: 'both' } }),
        _react2.default.createElement(_table2.default, { bordered: true, key: this.key, scroll: { x: 1200 }, pagination: false, rowSelection: rowSelection, columns: columns, dataSource: this.state.recData }),
        _react2.default.createElement(
          'div',
          { style: { margin: '10px 0' } },
          _react2.default.createElement(
            'span',
            { style: { float: 'right', fontSize: 16, color: 'red' } },
            '\u90E8\u95E8\u603B\u5206\uFF1A',
            this.state.totalBumen ? this.state.totalBumen : 0
          ),
          _react2.default.createElement(
            'span',
            { style: { float: 'right', fontSize: 16, color: 'red' } },
            '\u81EA\u8BC4\u603B\u5206\uFF1A',
            this.state.totalZiping ? this.state.totalZiping : 0,
            ' \xA0\xA0'
          )
        ),
        _react2.default.createElement('div', { style: { clear: 'both' } }),
        _react2.default.createElement(
          'div',
          { style: { margin: '10px 0' } },
          _react2.default.createElement(
            _button2.default,
            { type: 'primary', style: { float: 'right', padding: '6px 30px' }, onClick: this.submit.bind(this) },
            '\u63D0\u4EA4'
          ),
          _react2.default.createElement(
            _button2.default,
            { type: 'danger', style: { margin: '0 15px', float: 'right', padding: '6px 30px' }, onClick: this.returned.bind(this) },
            '\u9000\u56DE'
          )
        ),
        _react2.default.createElement(
          _modal2.default,
          {
            title: '\u9000\u56DE',
            style: { display: 'block' },
            visible: this.state.visible,
            onOk: this.handleOk.bind(this),
            onCancel: this.handleCancel.bind(this)
          },
          _react2.default.createElement(
            FormItem,
            _extends({
              label: '\u9000\u56DE\u7406\u7531',
              style: { 'width': '100%' }
            }, formItemLayout),
            getFieldDecorator('reason', {
              rules: [{ required: true, message: '该字段不能为空!' }]
            })(_react2.default.createElement(TextArea, { style: { 'width': '100%' } }))
          )
        )
      );
    }
  }]);

  return Bumenkp;
}(_personalPerformance2.default);

var WrappedBumenkp = _form2.default.create()(Bumenkp);
if (document.getElementById("bumenkaoPing")) _reactDom2.default.render(_react2.default.createElement(WrappedBumenkp, _extends({}, pageUrls, { department: 'bumen' })), document.getElementById("bumenkaoPing"));
exports.default = Bumenkp;
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(16)))

/***/ }),

/***/ 494:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function($) {

Object.defineProperty(exports, "__esModule", {
    value: true
});

var _table = __webpack_require__(31);

var _table2 = _interopRequireDefault(_table);

var _select = __webpack_require__(37);

var _select2 = _interopRequireDefault(_select);

var _button = __webpack_require__(18);

var _button2 = _interopRequireDefault(_button);

var _datePicker = __webpack_require__(35);

var _datePicker2 = _interopRequireDefault(_datePicker);

var _form = __webpack_require__(29);

var _form2 = _interopRequireDefault(_form);

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

__webpack_require__(32);

__webpack_require__(39);

__webpack_require__(22);

__webpack_require__(36);

__webpack_require__(30);

var _react = __webpack_require__(0);

var _react2 = _interopRequireDefault(_react);

var _reactDom = __webpack_require__(11);

var _reactDom2 = _interopRequireDefault(_reactDom);

var _personalPerformance = __webpack_require__(119);

var _personalPerformance2 = _interopRequireDefault(_personalPerformance);

var _moment = __webpack_require__(1);

var _moment2 = _interopRequireDefault(_moment);

__webpack_require__(109);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

_moment2.default.locale('zh-cn');
var FormItem = _form2.default.Item;
var MonthPicker = _datePicker2.default.MonthPicker,
    RangePicker = _datePicker2.default.RangePicker;

var dateFormat = 'YYYY/MM/DD';
var monthFormat = 'YYYY/MM';

var KpHistory = function (_Performance) {
    _inherits(KpHistory, _Performance);

    function KpHistory(props) {
        _classCallCheck(this, KpHistory);

        var _this = _possibleConstructorReturn(this, (KpHistory.__proto__ || Object.getPrototypeOf(KpHistory)).call(this, props));

        var date = new Date();
        var year = date.getFullYear();
        var month = date.getMonth() + 1;
        month = month < 10 ? "0" + month : month;
        var currentDate = year.toString() + "-" + month.toString();
        _this.state = {
            userName: "",
            selectedDate: currentDate, //获取系统当前时间，这个功能暂时未用。
            recData: []
        };
        _this.personId = "";
        return _this;
    }

    _createClass(KpHistory, [{
        key: 'componentDidMount',
        value: function componentDidMount() {
            $.ajax({
                //url:"/historyxinxi",
                url: this.props.selfEvaluateUrl,
                type: "get",
                dataType: 'json',
                contentType: 'application/json',
                success: function (data) {
                    if (data.status > 0) {
                        //var data=data.data.detail;       
                        for (var i = 0; i < data.data.detail.length; i++) {
                            data.data.detail[i]["key"] = data.data.detail[i].id;
                        }
                        this.setState({
                            recData: data.data.detail,
                            userName: data.data.personName
                        });
                        // console.log(data);
                        this.personId = data.data.personId;
                    }
                }.bind(this),
                error: function error() {
                    alert("请求失败");
                }
            });
        }
    }, {
        key: 'checkHistoryInfo',
        value: function checkHistoryInfo(index, value) {
            console.log(this.personId);
            var id = this.state.recData[index].id;
            window.location.href = this.props.everyMonthHistorykp + "?id=" + id + "&personId=" + this.personId;
        }
    }, {
        key: 'onChange',
        value: function onChange(value) {
            var self = this;
            console.log(value);
            $.get(self.props.selfEvaluateUrl + "/" + value, function (data) {
                console.log(data.data);
                self.setState({
                    recData: data.data.detail
                });
            });
        }
    }, {
        key: 'render',
        value: function render() {
            var _this2 = this;

            var divStyle = {
                fontSize: 14,
                overflow: 'hidden'
            };

            var columns = [{
                title: '序号',
                dataIndex: 'id',
                render: function render(text, record, index) {
                    return _react2.default.createElement(
                        'span',
                        null,
                        ++index
                    );
                }
            }, {
                title: '历史绩效',
                dataIndex: 'name',
                render: function render(text) {
                    return _react2.default.createElement(
                        'a',
                        { href: '#' },
                        text
                    );
                }
            }, {
                title: '操作',
                dataIndex: 'action',
                render: function render(text, record, index) {
                    return _react2.default.createElement(
                        _button2.default,
                        { onClick: _this2.checkHistoryInfo.bind(_this2, index) },
                        '\u67E5\u770B'
                    );
                }
            }];
            return _react2.default.createElement(
                'div',
                null,
                _react2.default.createElement(
                    'div',
                    { style: divStyle },
                    _react2.default.createElement(
                        'div',
                        { style: { float: 'left' } },
                        _react2.default.createElement(
                            'span',
                            null,
                            '\u5F53\u524D\u7528\u6237\uFF1A'
                        ),
                        _react2.default.createElement(
                            'span',
                            null,
                            this.state.userName
                        )
                    ),
                    _react2.default.createElement(
                        'div',
                        { style: { float: 'right' } },
                        _react2.default.createElement(
                            _select2.default,
                            {
                                showSearch: true,
                                style: { float: 'right', minWidth: '100px' },
                                placeholder: '\u5E74\u4EFD\u9009\u62E9',
                                optionFilterProp: 'children',
                                onChange: this.onChange.bind(this),
                                filterOption: function filterOption(input, option) {
                                    return option.props.value.toLowerCase().indexOf(input.toLowerCase()) >= 0;
                                }
                            },
                            _react2.default.createElement(
                                Option,
                                { value: '2020' },
                                '2020'
                            ),
                            _react2.default.createElement(
                                Option,
                                { value: '2019' },
                                '2019'
                            ),
                            _react2.default.createElement(
                                Option,
                                { value: '2018' },
                                '2018'
                            ),
                            _react2.default.createElement(
                                Option,
                                { value: '2017' },
                                '2017'
                            ),
                            _react2.default.createElement(
                                Option,
                                { value: '2016' },
                                '2016'
                            ),
                            _react2.default.createElement(
                                Option,
                                { value: '2015' },
                                '2015'
                            )
                        ),
                        _react2.default.createElement(
                            'span',
                            { style: { float: 'right', paddingTop: '4px' } },
                            '\u65E5\u671F\uFF1A'
                        )
                    )
                ),
                _react2.default.createElement(_table2.default, { style: { overflow: 'hidden', textAlign: 'center' }, pagination: false, columns: columns, dataSource: this.state.recData })
            );
        }
    }]);

    return KpHistory;
}(_personalPerformance2.default);

if (document.getElementById("kpHistoryInfor")) _reactDom2.default.render(_react2.default.createElement(KpHistory, pageUrls), document.getElementById("kpHistoryInfor"));
exports.default = KpHistory;
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(16)))

/***/ }),

/***/ 495:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function($) {

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _button = __webpack_require__(18);

var _button2 = _interopRequireDefault(_button);

var _table = __webpack_require__(31);

var _table2 = _interopRequireDefault(_table);

var _inputNumber = __webpack_require__(54);

var _inputNumber2 = _interopRequireDefault(_inputNumber);

var _modal = __webpack_require__(43);

var _modal2 = _interopRequireDefault(_modal);

var _regenerator = __webpack_require__(56);

var _regenerator2 = _interopRequireDefault(_regenerator);

var _input = __webpack_require__(28);

var _input2 = _interopRequireDefault(_input);

var _datePicker = __webpack_require__(35);

var _datePicker2 = _interopRequireDefault(_datePicker);

var _form = __webpack_require__(29);

var _form2 = _interopRequireDefault(_form);

var _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

__webpack_require__(22);

__webpack_require__(32);

__webpack_require__(55);

__webpack_require__(44);

__webpack_require__(23);

__webpack_require__(36);

__webpack_require__(30);

var _react = __webpack_require__(0);

var _react2 = _interopRequireDefault(_react);

var _reactDom = __webpack_require__(11);

var _reactDom2 = _interopRequireDefault(_reactDom);

var _moment = __webpack_require__(1);

var _moment2 = _interopRequireDefault(_moment);

var _personalPerformance = __webpack_require__(119);

var _personalPerformance2 = _interopRequireDefault(_personalPerformance);

var _Sorter = __webpack_require__(33);

var _Sorter2 = _interopRequireDefault(_Sorter);

var _Filters = __webpack_require__(40);

var _Filters2 = _interopRequireDefault(_Filters);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var FormItem = _form2.default.Item;
var MonthPicker = _datePicker2.default.MonthPicker,
    RangePicker = _datePicker2.default.RangePicker;
var TextArea = _input2.default.TextArea;

var dateFormat = 'YYYY/MM/DD';
var monthFormat = 'YYYY/MM';

var Managementkp = function (_Performance) {
  _inherits(Managementkp, _Performance);

  function Managementkp(props) {
    _classCallCheck(this, Managementkp);

    var _this = _possibleConstructorReturn(this, (Managementkp.__proto__ || Object.getPrototypeOf(Managementkp)).call(this, props));

    _this.state = {
      selectedRowKeys: [], // Check here to configure the default column
      loading: false,
      recData: [], //从后台接收到的数据
      newKey: 1,
      recScorezp: [],
      recScorebm: [],
      recInputs: [],
      evaluateName: "",
      totalZiping: "",
      totalBumen: "",
      totalkpgroup: "",
      visible: false,
      scoreList: [] //存放部门打分
    };
    _this.keyPairs = {};
    _this.key = 0;
    _this.urlDate = "";
    return _this;
  }

  _createClass(Managementkp, [{
    key: 'componentDidUpdate',
    value: function componentDidUpdate() {
      var trs = document.querySelectorAll('tbody tr');
      // console.log(this.state.scoreList)
      for (var i = 0; i < trs.length; i++) {
        if (this.state.scoreList[i] != null) {
          if (this.state.scoreList[i] > 0) {
            trs[i].style.backgroundColor = "#95CFF4"; //蓝色
          } else if (this.state.scoreList[i] == 0) {
            trs[i].style.backgroundColor = "#fff";
          } else {
            trs[i].style.backgroundColor = "#F5B8C8"; //红色
          }
        }
      }
    }
  }, {
    key: 'componentDidMount',
    value: function () {
      var _ref = _asyncToGenerator( /*#__PURE__*/_regenerator2.default.mark(function _callee() {
        var self;
        return _regenerator2.default.wrap(function _callee$(_context) {
          while (1) {
            switch (_context.prev = _context.next) {
              case 0:
                self = this;

                self.urlDate = window.location.href.substring(window.location.href.lastIndexOf("/") + 1);
                $.ajax({
                  //url:"/bumenkaoPing",
                  url: self.props.managerEvaluate,
                  type: "get",
                  dataType: 'json',
                  contentType: 'application/json',
                  success: function (data) {
                    if (data.status > 0) {
                      if (data) {
                        var data = data.data;
                        var evaluateName = "";
                        for (var i = 0; i < data.length; i++) {
                          data[i]["key"] = data[i].id;
                          evaluateName = data[0].evaluateName;
                        }
                        var zipingSum = 100;
                        var bumenSum = 100;
                        var kpgroupSum = 100;
                        var list = [];
                        for (var i in data) {
                          if (data[i].personal) {
                            zipingSum += parseFloat(data[i].personal.score);
                          }
                          if (data[i].bumen) {
                            bumenSum += parseFloat(data[i].bumen.score);
                          }
                          if (this.props.department == "historykp" || data[i].kpgroup.complete != null) {
                            kpgroupSum += parseFloat(data[i].kpgroup.score);
                            list.push(data[i].kpgroup.score);
                          } else {
                            list.push(data[i].bumen.score);
                          }
                        }
                        for (var i in data) {
                          if (!this.keyPairs[data[i].id]) {
                            this.keyPairs[data[i].id] = { inputs: "", score: 0, remarks: "" };
                            this.keyPairs[data[i].id].remarks = data[i].remarks;
                            if (data[i].kpgroup.score != null) {
                              this.keyPairs[data[i].id].inputs = data[i].kpgroup.complete;
                              this.keyPairs[data[i].id].score = data[i].kpgroup.score;
                            }
                          }
                        }
                        zipingSum = zipingSum.toFixed(2);
                        bumenSum = bumenSum.toFixed(2);
                        kpgroupSum = kpgroupSum.toFixed(2);
                        self.setState({
                          recData: data,
                          evaluateName: evaluateName,
                          totalZiping: zipingSum,
                          totalBumen: bumenSum,
                          totalkpgroup: kpgroupSum,
                          scoreList: list
                        });
                      } else {
                        recData: "";
                      }
                    } else {
                      return;
                    }
                  }.bind(this),
                  error: function error() {
                    alert("请求失败");
                  }
                });

              case 3:
              case 'end':
                return _context.stop();
            }
          }
        }, _callee, this);
      }));

      function componentDidMount() {
        return _ref.apply(this, arguments);
      }

      return componentDidMount;
    }()
  }, {
    key: 'onScoreChange',
    value: function onScoreChange(index, value) {
      if (!value) {
        value = 0;
      }
      value = parseFloat(value).toFixed(2);
      index = this.state.recData[index].id;
      if (!this.keyPairs[index]) {
        this.keyPairs[index] = { inputs: "", score: "" };
      }
      this.keyPairs[index].score = value;
      var sum = 100;
      for (var i in this.keyPairs) {
        sum += parseFloat(this.keyPairs[i].score);
      }
      sum = sum.toFixed(2);
      this.setState({
        totalkpgroup: sum
      });
    }
  }, {
    key: 'onCompleteChange',
    value: function onCompleteChange(index, value) {
      // console.log(index,value)
      index = this.state.recData[index].id;
      if (!this.keyPairs[index]) {
        this.keyPairs[index] = { inputs: "", score: "" };
      }
      if (typeof value == 'string' && value.constructor == String) this.keyPairs[index].inputs = value;else this.keyPairs[index].inputs = value.target.value;
      // console.log(this.keyPairs)
    }
  }, {
    key: 'onRemarkChange',
    value: function onRemarkChange(index, value) {
      index = this.state.recData[index].id;
      if (typeof value == 'string' && value.constructor == String) this.keyPairs[index].remarks = value;else this.keyPairs[index].remarks = value.target.value;
    }
  }, {
    key: 'spToInput',
    value: function spToInput(data, index) {
      var recInputs = this.state.recInputs;
      var subject = data + "";
      var regex = /.*?(##|#number#|#date#|\n)/g;
      var matched = null;
      var str;
      var sp;
      var lastStrLoc;
      var jsxs = [];
      var i = 0;
      while (matched = regex.exec(subject)) {
        str = matched[0];
        sp = matched[1];
        lastStrLoc = matched.index + str.length;
        jsxs.push(_react2.default.createElement(
          'span',
          null,
          str.substring(0, str.indexOf(sp))
        ));
        switch (sp) {
          case "##":
          case "#number#":
          case "#date#":
            jsxs.push(_react2.default.createElement(TextArea, { autosize: { minRows: 1 }, defaultValue: recInputs[index][i], disabled: !(this.props.department == "ziping"), onChange: this.onChange.bind(this, index, i) }));
            i++;
            break;
          case "\n":
            jsxs.push(_react2.default.createElement('br', null));
            break;
        }
      }
      jsxs.push(_react2.default.createElement(
        'span',
        null,
        subject.substring(lastStrLoc)
      ));
      return jsxs;
    }
    //退回处理 start

  }, {
    key: 'returned',
    value: function returned() {
      this.setState({
        visible: true
      });
    }
  }, {
    key: 'handleOk',
    value: function handleOk(e) {
      var _this2 = this;

      this.props.form.validateFields(function (err, values) {
        values["taskId"] = _this2.props.managerEvaluate.substring(_this2.props.managerEvaluate.lastIndexOf('/') + 1, _this2.props.managerEvaluate.length);
        console.log(values);
        if (!err) {
          var self = _this2;
          $.ajax({
            type: "post",
            url: self.props.regectUrl,
            data: JSON.stringify(values),
            dataType: 'json',
            contentType: 'application/json',
            success: function success(data) {
              self.setState({
                visible: false
              });
              if (data.status > 0) {
                _modal2.default.success({
                  title: '提示信息',
                  content: '回退成功！'
                });
                window.location.href = self.props.jumpUrl;
              } else {
                _modal2.default.error({
                  title: '提示信息',
                  content: '回退失败！'
                });
              }
            },
            error: function error(data) {
              alert("失败");
            }
          });
        }
      });
    }
  }, {
    key: 'handleCancel',
    value: function handleCancel(e) {
      this.setState({
        visible: false
      });
    }
    //退回处理 end
    //部门退回 start

  }, {
    key: 'genRejectrReason',
    value: function genRejectrReason() {
      var personal;
      var bumen;
      var kpgroup;
      for (var i in this.state.recData) {
        var self = this;
        if (self.state.recData[i].reason) {
          if (self.state.recData[i].reason.personal) {
            personal = "个人退回理由：" + self.state.recData[i].reason.personal;
          }
          if (self.state.recData[i].reason.bumen) {
            bumen = "部门退回理由：" + self.state.recData[i].reason.bumen;
          }
          if (self.state.recData[i].reason.kpgroup) {
            kpgroup = "考评组退回理由：" + self.state.recData[i].reason.kpgroup;
          }
        }
      }
      var reasons = [];
      reasons.push(personal, bumen, kpgroup);
      var reasonList = reasons.map(function (row) {
        return _react2.default.createElement(
          'p',
          null,
          row
        );
      });
      return reasonList;
    }
    //正常提交

  }, {
    key: 'submit',
    value: function submit() {
      var result = {};
      result["managerEvaluate"] = this.keyPairs;
      result["evaluateName"] = this.state.evaluateName;
      var total = 100;
      for (var i in result.managerEvaluate) {
        total += parseFloat(result.managerEvaluate[i].score);
      }
      total = total.toFixed(2);
      result["total"] = total;
      //发给后台的数据
      var self = this;
      $.ajax({
        type: "post",
        url: self.props.managerEvaluate,
        data: JSON.stringify(result),
        dataType: 'json',
        contentType: 'application/json',
        success: function success(data) {
          if (data.status > 0) {
            window.location.href = self.props.jumpUrl;
          } else {
            _modal2.default.error({
              title: '错误信息',
              content: '保存失败！'
            });
          }
        },
        error: function error(data) {
          alert("失败");
        }
      });
    }
  }, {
    key: 'render',
    value: function render() {
      var _this3 = this;

      var filterData = new _Filters2.default().filter(this.state.recData);
      var formItemLayout = {
        labelCol: { span: 4 },
        wrapperCol: { span: 20 }
      };
      var recScorezp = this.state.recScorezp;
      var recScorebm = this.state.recScorebm;
      var recData = this.state.recData;
      var remarks = [];
      for (var i in recData) {
        if (this.props.department != "historykp") {
          if (recData[i].kpgroup.score != null) {
            //判断一下如果有kpgroup.score这个属性，就代表是退回状态，这时只需带着remarks即可 否则要拼接
            remarks.push(recData[i].remarks);
          } else {
            remarks.push(recData[i].remarks + "\n考评组备注：");
          }
        } else {
          remarks.push(recData[i].remarks);
        }
      }
      // console.log(remarks)
      var completeDefaultValue = [];
      var scoreDefaultValue = [];
      //查看历史考评或者被退回时都赋默认值
      for (var index in this.state.recData) {
        if (this.props.department == "historykp" || this.state.recData[index].kpgroup.score != null) {
          // console.log(this.state.recData[index].kpgroup)
          completeDefaultValue.push(this.state.recData[index].kpgroup.complete);
          scoreDefaultValue.push(this.state.recData[index].kpgroup.score);
        } else {
          completeDefaultValue.push("");
          scoreDefaultValue.push(0);
        }
      }
      // console.log(completeDefaultValue)
      var columns = [{
        title: '项目',
        dataIndex: 'proName',
        width: 100,
        filters: filterData.proName,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.proName, b.proName);
        },
        onFilter: function onFilter(value, record) {
          return record.proName.indexOf(value) === 0;
        }
      }, {
        title: '子项目',
        dataIndex: 'childProName',
        width: 110,
        filters: filterData.childProName,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.childProName, b.childProName);
        },
        onFilter: function onFilter(value, record) {
          return record.childProName.indexOf(value) === 0;
        },
        render: function render(text, record, index) {
          return _this3.spToInput(text, index);
        }
      }, {
        title: '工作职责',
        dataIndex: 'jobResponsibility',
        width: 180,
        render: function render(text, record, index) {
          return _this3.spToInput(text, index);
        }
      }, {
        title: '工作标准',
        dataIndex: 'jobStandard',
        width: 180,
        render: function render(text, record, index) {
          return _this3.spToInput(text, index);
        }
      }, {
        title: '完成情况',
        dataIndex: 'complete',
        children: [{
          title: "个人",
          dataIndex: "personal",
          width: 240,
          render: function render(text, record, index) {
            return _react2.default.createElement(TextArea, { style: { color: "#757171" }, defaultValue: _this3.state.recData[index].personal ? _this3.state.recData[index].personal.complete : "", autosize: { minRows: 4, maxRows: 10 }, disabled: true });
          }
        }, {
          title: "部门",
          dataIndex: "department",
          width: 240,
          render: function render(text, record, index) {
            return _react2.default.createElement(TextArea, { style: { color: "#757171" }, defaultValue: _this3.state.recData[index].bumen ? _this3.state.recData[index].bumen.complete : "", autosize: { minRows: 4, maxRows: 10 }, disabled: true });
          }
        }, {
          title: "考评组",
          dataIndex: "kpGroup",
          width: 240,
          render: function render(text, record, index) {
            return _react2.default.createElement(TextArea, { style: { color: "#757171" }, autosize: { minRows: 4, maxRows: 10 }, onChange: _this3.onCompleteChange.bind(_this3, index), defaultValue: completeDefaultValue[index], disabled: _this3.props.department == "historykp" ? true : false });
          }
        }]
      }, {
        title: '备注',
        dataIndex: 'remarks',
        width: 180,
        render: function render(text, record, index) {
          return _react2.default.createElement(TextArea, { style: { color: "#757171" }, defaultValue: recData[index].remarks, autosize: { minRows: 4, maxRows: 10 }, disabled: _this3.props.department == "historykp" ? true : false, onChange: _this3.onRemarkChange.bind(_this3, index) });
        }
      }, {
        title: '评分标准',
        dataIndex: 'scoreStandard',
        width: 200,
        render: function render(text, record, index) {
          return _this3.spToInput(text, index);
        }
      }, {
        title: '评分',
        dataIndex: 'pingfen',
        children: [{
          title: "自评",
          dataIndex: "ziping",
          width: 30,
          render: function render(text, record, index) {
            return _react2.default.createElement(_inputNumber2.default, { defaultValue: _this3.state.recData[index].personal ? _this3.state.recData[index].personal.score : "", disabled: true });
          }
        }, {
          title: "部门",
          dataIndex: "bumen",
          width: 30,
          render: function render(text, record, index) {
            return _react2.default.createElement(_inputNumber2.default, { defaultValue: _this3.state.recData[index].bumen ? _this3.state.recData[index].bumen.score : "", disabled: true });
          }
        }, {
          title: "考评组",
          dataIndex: "pfgroup",
          width: 30,
          render: function render(text, record, index) {
            return _react2.default.createElement(_inputNumber2.default, { defaultValue: scoreDefaultValue[index], disabled: _this3.props.department == "historykp" ? true : false, onChange: _this3.onScoreChange.bind(_this3, index) });
          }
        }]
      }];
      // (key)=>this.spToInput.bind(this,key)
      var _state = this.state,
          loading = _state.loading,
          selectedRowKeys = _state.selectedRowKeys;

      var rowSelection = {
        selectedRowKeys: selectedRowKeys,
        onChange: this.onSelectChange.bind(this)
      };
      var hasSelected = selectedRowKeys.length > 0;
      var getFieldDecorator = this.props.form.getFieldDecorator;

      return _react2.default.createElement(
        'div',
        { style: { marginBottom: 100 } },
        _react2.default.createElement(
          'div',
          { id: 'header' },
          _react2.default.createElement(
            'h2',
            null,
            this.props.department == "historykp" ? "个人历史绩效" : this.state.evaluateName
          )
        ),
        _react2.default.createElement(
          'div',
          { style: { marginBottom: 16, height: 20 } },
          _react2.default.createElement(
            'span',
            { style: { marginLeft: 8, float: 'left' } },
            hasSelected ? 'Selected ' + selectedRowKeys.length + ' items' : ''
          ),
          _react2.default.createElement(
            'div',
            { style: { paddingLeft: '10px', color: 'red', float: 'left' } },
            this.genRejectrReason()
          )
        ),
        _react2.default.createElement('div', { style: { clear: 'both' } }),
        _react2.default.createElement(_table2.default, { scroll: { x: 1200 }, bordered: true, pagination: false, rowSelection: rowSelection, columns: columns, dataSource: this.state.recData }),
        _react2.default.createElement(
          'div',
          { style: { margin: '10px 0' } },
          _react2.default.createElement(
            'span',
            { style: { float: 'right', fontSize: 16, color: 'red' } },
            '\u8003\u8BC4\u7EC4\u603B\u5206\uFF1A',
            this.state.totalkpgroup ? this.state.totalkpgroup : 100
          ),
          _react2.default.createElement(
            'span',
            { style: { float: 'right', fontSize: 16, color: 'red' } },
            '\u90E8\u95E8\u603B\u5206\uFF1A',
            this.state.totalBumen ? this.state.totalBumen : 100,
            ' \xA0\xA0'
          ),
          _react2.default.createElement(
            'span',
            { style: { float: 'right', fontSize: 16, color: 'red' } },
            '\u81EA\u8BC4\u603B\u5206\uFF1A',
            this.state.totalZiping ? this.state.totalZiping : 100,
            ' \xA0\xA0'
          )
        ),
        _react2.default.createElement('div', { style: { clear: 'both' } }),
        _react2.default.createElement(
          'div',
          { style: { margin: '10px 0' } },
          _react2.default.createElement(
            _button2.default,
            { type: 'primary', style: { float: 'right', padding: '6px 30px' }, disabled: this.props.department == "historykp" ? true : false, onClick: this.submit.bind(this) },
            '\u63D0\u4EA4'
          ),
          _react2.default.createElement(
            _button2.default,
            { type: 'danger', style: { margin: '0 15px', float: 'right', padding: '6px 30px' }, disabled: this.props.department == "historykp" ? true : false, onClick: this.returned.bind(this) },
            '\u9000\u56DE'
          )
        ),
        _react2.default.createElement(
          _modal2.default,
          {
            title: '\u9000\u56DE',
            style: { display: 'block' },
            visible: this.state.visible,
            onOk: this.handleOk.bind(this),
            onCancel: this.handleCancel.bind(this)
          },
          _react2.default.createElement(
            FormItem,
            _extends({
              label: '\u9000\u56DE\u7406\u7531',
              style: { 'width': '100%' }
            }, formItemLayout),
            getFieldDecorator('reason', {
              rules: [{ required: true, message: '该字段不能为空!' }]
            })(_react2.default.createElement(TextArea, { style: { 'width': '100%' } }))
          )
        )
      );
    }
  }]);

  return Managementkp;
}(_personalPerformance2.default);

var WrappedManagementkp = _form2.default.create()(Managementkp);
if (document.getElementById("historykp")) {
  _reactDom2.default.render(_react2.default.createElement(WrappedManagementkp, _extends({}, pageUrls, { department: 'historykp' })), document.getElementById("historykp"));
}
if (document.getElementById("managementkp")) {
  _reactDom2.default.render(_react2.default.createElement(WrappedManagementkp, _extends({}, pageUrls, { department: 'management' })), document.getElementById("managementkp"));
}
exports.default = Managementkp;
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(16)))

/***/ }),

/***/ 496:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(module, $) {

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _table = __webpack_require__(31);

var _table2 = _interopRequireDefault(_table);

var _button = __webpack_require__(18);

var _button2 = _interopRequireDefault(_button);

var _input = __webpack_require__(28);

var _input2 = _interopRequireDefault(_input);

var _datePicker = __webpack_require__(35);

var _datePicker2 = _interopRequireDefault(_datePicker);

var _index = __webpack_require__(21);

var _index2 = _interopRequireDefault(_index);

var _index3 = __webpack_require__(19);

var _index4 = _interopRequireDefault(_index3);

var _react2 = __webpack_require__(0);

var _react3 = _interopRequireDefault(_react2);

var _index5 = __webpack_require__(20);

var _index6 = _interopRequireDefault(_index5);

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

__webpack_require__(32);

__webpack_require__(22);

__webpack_require__(23);

__webpack_require__(36);

var _reactDom = __webpack_require__(11);

var _reactDom2 = _interopRequireDefault(_reactDom);

var _Sorter = __webpack_require__(33);

var _Sorter2 = _interopRequireDefault(_Sorter);

var _Filters = __webpack_require__(40);

var _Filters2 = _interopRequireDefault(_Filters);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var _components = {
  MonthSummarySheet: {
    displayName: 'MonthSummarySheet'
  }
};

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2 = (0, _index6.default)({
  filename: '/Users/huang/work/dzoms_react/components/kp/monthSummarySheet.js',
  components: _components,
  locals: [module],
  imports: [_react3.default]
});

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2 = (0, _index4.default)({
  filename: '/Users/huang/work/dzoms_react/components/kp/monthSummarySheet.js',
  components: _components,
  locals: [],
  imports: [_react3.default, _index2.default]
});

function _wrapComponent(id) {
  return function (Component) {
    return _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2(_UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2(Component, id), id);
  };
}

var MonthPicker = _datePicker2.default.MonthPicker,
    RangePicker = _datePicker2.default.RangePicker;
var TextArea = _input2.default.TextArea;

var dateFormat = 'YYYY/MM/DD';
var monthFormat = 'YYYY/MM';

var MonthSummarySheet = _wrapComponent('MonthSummarySheet')(function (_React$Component) {
  _inherits(MonthSummarySheet, _React$Component);

  function MonthSummarySheet(props) {
    _classCallCheck(this, MonthSummarySheet);

    var _this = _possibleConstructorReturn(this, (MonthSummarySheet.__proto__ || Object.getPrototypeOf(MonthSummarySheet)).call(this, props));

    _this.state = {
      recData: []
    };
    return _this;
  }

  _createClass(MonthSummarySheet, [{
    key: 'componentDidMount',
    value: function componentDidMount() {
      var self = this;
      $.ajax({
        url: self.props.monthSummarySheetUrl,
        type: "get",
        dataType: 'json',
        contentType: 'application/json',
        success: function (data) {
          if (data.status > 0) {
            if (data) {
              var data = data.data;
              for (var i = 0; i < data.length; i++) {
                data[i]["key"] = i + 1;
                var kpScore = data[i].kpScore;
                var plusOrMinusPoints = data[i].plusOrMinusPoints;
                Object.assign(data[i], kpScore, plusOrMinusPoints);
                // for(var j in data[i]){ //数据类型转换，数字类型筛选的时候会报错
                //     data[i][j]=String(data[i][j]);
                // }
              }
              self.setState({
                recData: data
              });
            } else {
              recData: "";
            }
          } else {
            return;
          }
        }.bind(self),
        error: function error() {
          alert("请求失败");
        }
      });
    }
  }, {
    key: 'render',
    value: function render() {
      var filterData = new _Filters2.default().filter(this.state.recData);
      var formItemLayout = {
        labelCol: { span: 4 },
        wrapperCol: { span: 20 }
      };
      var recData = this.state.recData;
      // console.log(filterData)
      var columns = [{
        title: '序号',
        width: 150,
        dataIndex: 'key',
        // filters: filterData.key,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.key, b.key);
        }
        // onFilter: (value, record) => record.key.indexOf(value) === 0,
      }, {
        title: '部门',
        width: 170,
        dataIndex: 'department',
        // filters: filterData.department,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.department, b.department);
        }
        // onFilter: (value, record) => record.department.indexOf(value) === 0,
      }, {
        title: '姓名',
        width: 170,
        dataIndex: 'name',
        // filters: filterData.name,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.name, b.name);
        }
        // onFilter: (value, record) => record.name.indexOf(value) === 0,
      }, {
        title: '考核得分',
        dataIndex: 'kpScore',
        children: [{
          title: "合计",
          width: 170,
          dataIndex: "total",
          // filters: filterData.total,
          sorter: function sorter(a, b) {
            return new _Sorter2.default().sort(a.total, b.total);
          }
          // onFilter: (value, record) => record.total.indexOf(value) === 0,
        }, {
          title: "临时工作",
          width: 170,
          dataIndex: "lsxgz",
          // filters: filterData.lsxgz,
          sorter: function sorter(a, b) {
            return new _Sorter2.default().sort(a.lsxgz, b.lsxgz);
          }
          // onFilter: (value, record) => record.lsxgz.indexOf(value) === 0,
        }, {
          title: "日常工作",
          width: 170,
          dataIndex: "rcgz",
          // filters: filterData.rcgz,
          sorter: function sorter(a, b) {
            return new _Sorter2.default().sort(a.rcgz, b.rcgz);
          }
          // onFilter: (value, record) => record.rcgz.indexOf(value) === 0,
        }, {
          title: "行为规范",
          width: 170,
          dataIndex: "xwgf",
          // filters: filterData.xwgf,
          sorter: function sorter(a, b) {
            return new _Sorter2.default().sort(a.xwgf, b.xwgf);
          }
          // onFilter: (value, record) => record.xwgf.indexOf(value) === 0,
        }]
      }, {
        title: '备注',
        width: 800,
        dataIndex: 'remarks'
        // filters: filterData.remarks,
        // sorter: (a, b) => (new Sorter().sort(a.remarks, b.remarks)),
        // onFilter: (value, record) => record.remarks.indexOf(value) === 0,
      }];
      return _react3.default.createElement(
        'div',
        null,
        _react3.default.createElement(
          'div',
          { id: 'header' },
          _react3.default.createElement(
            'h2',
            null,
            '\u6708\u5EA6\u7EE9\u6548\u8003\u6838\u6C47\u603B\u8868'
          )
        ),
        _react3.default.createElement(
          'div',
          { style: { marginLeft: 200, marginBottom: 10 } },
          _react3.default.createElement(
            _button2.default,
            { type: 'primary', style: { width: 200 } },
            _react3.default.createElement(
              'a',
              { href: this.props.exportUrl },
              '\u5BFC\u51FA'
            )
          )
        ),
        _react3.default.createElement(_table2.default, { style: { width: 1200, margin: '0 auto' }, bordered: true, columns: columns, dataSource: this.state.recData })
      );
    }
  }]);

  return MonthSummarySheet;
}(_react3.default.Component));

if (document.getElementById("monthSummarySheet")) {
  _reactDom2.default.render(_react3.default.createElement(MonthSummarySheet, pageUrls), document.getElementById("monthSummarySheet"));
}
exports.default = MonthSummarySheet;
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(14)(module), __webpack_require__(16)))

/***/ }),

/***/ 497:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(module, $) {

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _table = __webpack_require__(31);

var _table2 = _interopRequireDefault(_table);

var _select = __webpack_require__(37);

var _select2 = _interopRequireDefault(_select);

var _button = __webpack_require__(18);

var _button2 = _interopRequireDefault(_button);

var _modal = __webpack_require__(43);

var _modal2 = _interopRequireDefault(_modal);

var _datePicker = __webpack_require__(35);

var _datePicker2 = _interopRequireDefault(_datePicker);

var _input = __webpack_require__(28);

var _input2 = _interopRequireDefault(_input);

var _form = __webpack_require__(29);

var _form2 = _interopRequireDefault(_form);

var _index = __webpack_require__(21);

var _index2 = _interopRequireDefault(_index);

var _index3 = __webpack_require__(19);

var _index4 = _interopRequireDefault(_index3);

var _react2 = __webpack_require__(0);

var _react3 = _interopRequireDefault(_react2);

var _index5 = __webpack_require__(20);

var _index6 = _interopRequireDefault(_index5);

var _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

__webpack_require__(32);

__webpack_require__(39);

__webpack_require__(22);

__webpack_require__(44);

__webpack_require__(36);

__webpack_require__(23);

__webpack_require__(30);

var _reactDom = __webpack_require__(11);

var _reactDom2 = _interopRequireDefault(_reactDom);

var _Sorter = __webpack_require__(33);

var _Sorter2 = _interopRequireDefault(_Sorter);

var _Filters = __webpack_require__(40);

var _Filters2 = _interopRequireDefault(_Filters);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var _components = {
  AppModal: {
    displayName: 'AppModal'
  },
  AppTable: {
    displayName: 'AppTable'
  }
};

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2 = (0, _index6.default)({
  filename: '/Users/huang/work/dzoms_react/components/kp/proManagement.js',
  components: _components,
  locals: [module],
  imports: [_react3.default]
});

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2 = (0, _index4.default)({
  filename: '/Users/huang/work/dzoms_react/components/kp/proManagement.js',
  components: _components,
  locals: [],
  imports: [_react3.default, _index2.default]
});

function _wrapComponent(id) {
  return function (Component) {
    return _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2(_UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2(Component, id), id);
  };
}

var FormItem = _form2.default.Item;
var TextArea = _input2.default.TextArea;
var MonthPicker = _datePicker2.default.MonthPicker,
    RangePicker = _datePicker2.default.RangePicker;

var dateFormat = 'YYYY/MM/DD';
var monthFormat = 'YYYY/MM';

var AppModal = _wrapComponent('AppModal')(function (_React$Component) {
  _inherits(AppModal, _React$Component);

  function AppModal(props) {
    _classCallCheck(this, AppModal);

    var _this = _possibleConstructorReturn(this, (AppModal.__proto__ || Object.getPrototypeOf(AppModal)).call(this, props));

    _this.state = {
      loading: false,
      visible: false,
      newKey: 0,
      type: "",
      msg: ""
      //recData:""  //从后台接收到的数据
    };
    _this.tableData = ""; //传送给后台的数据
    _this.key = 0;
    _this.departments = [];
    return _this;
  }

  _createClass(AppModal, [{
    key: 'componentDidMount',
    value: function componentDidMount() {
      var self = this;
      $.ajax({
        url: self.props.userUrl,
        type: "get",
        dataType: 'json',
        contentType: 'application/json',
        success: function (data) {
          if (data) {
            data.map(function (i) {
              self.departments.push(i.department);
            });
            self.departments = Array.from(new Set(self.departments));
          }
        }.bind(this),
        error: function error() {
          alert("请求失败");
        }
      });
    }
  }, {
    key: 'showAddModal',
    value: function showAddModal() {
      this.setState({
        visible: true,
        type: "post"
      });
    }
    //修改

  }, {
    key: 'showUpdateModal',
    value: function showUpdateModal(type, id) {
      var recData = this.props.recData;
      if (id.length > 1) {
        _modal2.default.error({
          title: '错误信息',
          content: '只能选择一行进行修改！'
        });
        return;
      } else if (id.length < 1) {
        _modal2.default.error({
          title: '错误信息',
          content: '请先选择一行在进行修改！'
        });
        return;
      }
      for (var i in recData) {
        if (id[0] == recData[i].id) {
          var updateData = this.props.form.setFields({
            department: {
              value: recData[i].department
            },
            id: {
              value: recData[i].id
            },
            proName: {
              value: recData[i].proName
            },
            childProName: {
              value: recData[i].childProName
            },
            jobResponsibility: {
              value: recData[i].jobResponsibility
            },
            jobStandard: {
              value: recData[i].jobStandard
            },
            complete: {
              value: recData[i].complete
            },
            scoreStandard: {
              value: recData[i].scoreStandard
            }
          });
        }
      }

      this.setState({
        visible: true,
        type: "put"
      });
    }
    //删除

  }, {
    key: 'delete',
    value: function _delete(ids) {
      var recData = [];
      if (ids.length < 1) {
        _modal2.default.error({
          title: '错误信息',
          content: '请选择要删除的行！'
        });
        return;
      }
      var that = this;
      _modal2.default.info({
        title: '删除项目',
        content: '确认删除之后将无法恢复该记录，确认要删除吗？',
        onOk: function onOk() {
          //根据选中的id 删除对应的行 
          for (var rowNum = 0; rowNum < that.props.recData.length; rowNum++) {
            var inFlag = false;
            var k = that.props.recData[rowNum].key;
            for (var i in ids) {
              if (ids[i] == k) {
                inFlag = true;
              }
            }
            if (!inFlag) {
              recData.push(that.props.recData[rowNum]);
            }
          }
          //测试删除
          //that.props.transferMsg(recData);   
          //把选中要删除的id传给后台
          $.ajax({
            type: "delete",
            url: that.props.url,
            data: JSON.stringify(ids),
            dataType: 'json',
            contentType: 'application/json',
            success: function success(data) {
              if (data.status > 0) {
                //判断如果传回来的状态是可以删除的,就通知下面的函数更改recData
                that.props.transferMsg(recData);
              } else {
                _modal2.default.error({
                  title: '错误信息',
                  content: '删除失败！'
                });
              }
            },
            error: function error(data) {
              alert("失败");
            }
          });
        }
      });
    }
  }, {
    key: 'addOrUpdate',
    value: function addOrUpdate(id) {
      var _this2 = this;

      //验证并储存表单数据
      var tableData;
      var recData = this.props.recData;
      this.props.form.validateFields(function (err, values) {
        if (!err) {
          _this2.setState({ loading: false, visible: false });
          _this2.tableData = values;
          tableData = _this2.tableData;
          //测试添加start
          // recData.splice(0,0,tableData); //添到数组最前面的位置
          // this.props.transferMsg(recData);   
          //测试添加end
        } else {
          _this2.setState({
            loading: false,
            visible: true
          });
          return;
        }
      });
      //判断操作类型
      var type = this.state.type;
      var url;
      var that = this;
      for (var i in id) {
        tableData["id"] = id[i];
      }
      console.log(tableData);
      // document.cookie="department"+"="+tableData.department;
      // document.cookie="proName"+"="+tableData.proName;
      //后台处理  
      $.ajax({
        type: type,
        url: this.props.url,
        data: JSON.stringify(tableData),
        dataType: 'json',
        contentType: 'application/json',
        success: function success(data) {
          if (data.status > 0) {
            // that.props.form.resetFields();    
            //console.log("aaaa");
            if (type == "put") {
              for (var i in id) {
                tableData["id"] = id[i];
              }
              for (var i in recData) {
                if (tableData.id == recData[i].id) {
                  Object.assign(recData[i], tableData);
                }
              }
              that.props.transferMsg(recData);
              _modal2.default.success({
                title: '提示信息',
                content: '更新成功！'
              });
            } else if (type == "post") {
              tableData["id"] = data.data.id;
              tableData["key"] = data.data.id;
              //recData.push(tableData);
              recData.splice(0, 0, tableData); //添到数组最前面的位置
              that.props.transferMsg(recData);
              _modal2.default.success({
                title: '提示信息',
                content: '添加成功！'
              });
            }
          } else {
            console.log(data);
            if (type == "put") {
              _modal2.default.error({
                title: '错误信息',
                content: '更新失败！'
              });
            } else if (type == "post") {
              _modal2.default.error({
                title: '错误信息',
                content: '添加失败！'
              });
            }
          }
        },
        error: function error(data) {
          alert("失败");
        }
      });
    }
  }, {
    key: 'handleCancel',
    value: function handleCancel() {
      this.setState({ visible: false });
    }
  }, {
    key: 'genDepartmentOptions',
    value: function genDepartmentOptions() {
      var departments = this.departments.map(function (i) {
        return _react3.default.createElement(
          Option,
          { value: i },
          i
        );
      });
      return departments;
    }
  }, {
    key: 'render',
    value: function render() {
      var key = this.state.newKey;
      var formItemLayout = {
        labelCol: { span: 24 },
        wrapperCol: { span: 24 }
      };
      var getFieldDecorator = this.props.form.getFieldDecorator;

      var br = "<br>";
      return _react3.default.createElement(
        'div',
        null,
        _react3.default.createElement(
          _button2.default,
          { type: 'primary', onClick: this.showAddModal.bind(this, "post") },
          '\u6DFB\u52A0\u9879\u76EE'
        ),
        _react3.default.createElement(
          _button2.default,
          { style: { marginLeft: 15 }, type: 'primary', onClick: this.showUpdateModal.bind(this, "put", this.props.rows) },
          '\u4FEE\u6539\u9879\u76EE'
        ),
        _react3.default.createElement(
          _button2.default,
          { style: { marginLeft: 15 }, type: 'primary', onClick: this.delete.bind(this, this.props.rows) },
          '\u5220\u9664\u9879\u76EE'
        ),
        _react3.default.createElement(
          _modal2.default,
          {
            maskClosable: false,
            visible: this.state.visible,
            width: '1200',
            onCancel: this.handleCancel.bind(this),
            footer: [_react3.default.createElement(
              _button2.default,
              { key: 'back', size: 'large', onClick: this.handleCancel.bind(this) },
              '\u53D6\u6D88'
            ), _react3.default.createElement(
              _button2.default,
              { type: 'primary', size: 'large', loading: this.state.loading, onClick: this.addOrUpdate.bind(this, this.props.rows) },
              '\u63D0\u4EA4'
            )]
          },
          _react3.default.createElement(
            _form2.default,
            null,
            _react3.default.createElement(
              FormItem,
              {

                label: '\u90E8\u95E8',
                style: { width: '100%', marginRight: 5 }
              },
              getFieldDecorator('department', {
                rules: [{ required: true, message: '该字段不能为空!' }]
              })(_react3.default.createElement(
                _select2.default,
                {
                  showSearch: true,
                  style: { width: 200 },
                  placeholder: '\u9009\u62E9\u90E8\u95E8',
                  optionFilterProp: 'children',
                  filterOption: function filterOption(input, option) {
                    return option.props.children.toLowerCase().indexOf(input.toLowerCase()) >= 0;
                  }
                },
                this.genDepartmentOptions()
              ))
            ),
            _react3.default.createElement(
              FormItem,
              _extends({
                label: '\u9879\u76EE',
                style: { width: '16%', marginRight: 5 }
              }, formItemLayout),
              getFieldDecorator('proName', {
                rules: [{ required: true, message: '该字段不能为空!' }]
              })(_react3.default.createElement(TextArea, { autosize: { minRows: 6 }, style: { 'minHeight': 200 } }))
            ),
            _react3.default.createElement(
              FormItem,
              _extends({
                style: { width: '16%', marginRight: 5 },
                label: '\u5B50\u9879\u76EE'
              }, formItemLayout),
              getFieldDecorator('childProName')(_react3.default.createElement(TextArea, { autosize: { minRows: 6 }, style: { 'minHeight': 200 } }))
            ),
            _react3.default.createElement(
              FormItem,
              _extends({
                style: { width: '16%', marginRight: 5 },
                label: '\u5DE5\u4F5C\u804C\u8D23'
              }, formItemLayout),
              getFieldDecorator('jobResponsibility')(_react3.default.createElement(TextArea, { autosize: { minRows: 6 }, style: { 'minHeight': 200 } }))
            ),
            _react3.default.createElement(
              FormItem,
              _extends({
                style: { width: '16%', marginRight: 5 },
                label: '\u5DE5\u4F5C\u6807\u51C6'
              }, formItemLayout),
              getFieldDecorator('jobStandard', {
                rules: [{ required: true, message: '该字段不能为空!' }]
              })(_react3.default.createElement(TextArea, { autosize: { minRows: 6 }, style: { 'minHeight': 200 } }))
            ),
            _react3.default.createElement(
              FormItem,
              _extends({
                style: { width: '16%', marginRight: 5 },
                label: '\u5B8C\u6210\u60C5\u51B5'
              }, formItemLayout),
              getFieldDecorator('complete', {
                rules: [{ required: true, message: '该字段不能为空!' }]
              })(_react3.default.createElement(TextArea, { autosize: { minRows: 6 }, style: { 'minHeight': 200 } }))
            ),
            _react3.default.createElement(
              FormItem,
              _extends({
                style: { width: '16%', marginRight: 5 },
                label: '\u8BC4\u5206\u6807\u51C6'
              }, formItemLayout),
              getFieldDecorator('scoreStandard', {
                rules: [{ required: true, message: '该字段不能为空!' }]
              })(_react3.default.createElement(TextArea, { autosize: { minRows: 6 }, style: { 'minHeight': 200 } }))
            )
          )
        )
      );
    }
  }]);

  return AppModal;
}(_react3.default.Component));

var AppTable = _wrapComponent('AppTable')(function (_React$Component2) {
  _inherits(AppTable, _React$Component2);

  function AppTable(props) {
    _classCallCheck(this, AppTable);

    var _this3 = _possibleConstructorReturn(this, (AppTable.__proto__ || Object.getPrototypeOf(AppTable)).call(this, props));

    _this3.state = {
      selectedRowKeys: [], // Check here to configure the default column
      loading: false,
      recData: [], //从后台接收到的数据
      newKey: 0
    };
    _this3.key = 0;
    return _this3;
  }

  _createClass(AppTable, [{
    key: 'componentDidMount',
    value: function componentDidMount() {
      $.ajax({
        url: this.props.url,
        //url:"/tables",
        type: "get",
        dataType: 'json',
        contentType: 'application/json',
        success: function (data) {
          var data = data.data;
          if (data) {
            for (var i = 0; i < data.length; i++) {
              data[i]["key"] = data[i].id;
            }
            data = data.reverse();
            this.setState({
              recData: data
            });
          } else {
            recData: "";
          }
        }.bind(this),
        error: function error() {
          alert("请求失败");
        }
      });
    }
  }, {
    key: 'transferMsg',
    value: function transferMsg(recData) {
      // console.log("transferMsg");
      // console.log(recData);
      this.setState({
        recData: recData,
        selectedRowKeys: []
      });
    }
  }, {
    key: 'onSelectChange',
    value: function onSelectChange(selectedRowKeys) {
      this.setState({ selectedRowKeys: selectedRowKeys });
      return selectedRowKeys;
    }
  }, {
    key: 'onChange',
    value: function onChange(index, seq, value) {
      //console.log(index,seq,value)
      if (!this.keyPairs[index]) this.keyPairs[index] = { inputs: [], ziping: "" };
      if (typeof value == 'string' && value.constructor == String) this.keyPairs[index].inputs[seq] = value;else this.keyPairs[index].inputs[seq] = value.target.value;
      console.log(this.keyPairs);
    }
  }, {
    key: 'spToInput',
    value: function spToInput(data, index) {
      var subject = data + "";
      var regex = /.*?(##|#number#|#date#|\n)/g;
      var matched = null;
      var str;
      var sp;
      var lastStrLoc;
      var jsxs = [];
      var i = 0;
      while (matched = regex.exec(subject)) {
        str = matched[0];
        sp = matched[1];
        lastStrLoc = matched.index + str.length;
        jsxs.push(_react3.default.createElement(
          'span',
          null,
          str.substring(0, str.indexOf(sp))
        ));
        switch (sp) {
          case "##":
            jsxs.push(_react3.default.createElement(TextArea, { autosize: { minRows: 1 }, defaultValue: "", onChange: this.onChange.bind(this, index, i) }));
            i++;
            break;
          case "#number#":
            jsxs.push(_react3.default.createElement(InputNumber, { min: 1, defaultValue: 0, onChange: this.onChange.bind(this, index, i) }));
            i++;
            break;
          case "#date#":
            jsxs.push(_react3.default.createElement(_datePicker2.default, { format: dateFormat, showToday: true }));
            i++;
            break;
          case "\n":
            jsxs.push(_react3.default.createElement('br', null));
            break;
        }
      }
      jsxs.push(_react3.default.createElement(
        'span',
        null,
        subject.substring(lastStrLoc)
      ));
      return jsxs;
    }
  }, {
    key: 'render',
    value: function render() {
      var _this4 = this;

      var filterData = new _Filters2.default().filter(this.state.recData);
      var columns = [{
        title: '部门',
        dataIndex: 'department',
        key: 'department',
        filters: filterData.department,
        width: 80,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.department, b.department);
        },
        onFilter: function onFilter(value, record) {
          return record.department.indexOf(value) === 0;
        }
      }, {
        title: '项目',
        dataIndex: 'proName',
        filters: filterData.proName,
        width: 80,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.proName, b.proName);
        },
        onFilter: function onFilter(value, record) {
          return record.proName.indexOf(value) === 0;
        }
      }, {
        title: '子项目',
        dataIndex: 'childProName',
        width: 80,
        render: function render(text, record, index) {
          return _this4.spToInput(text, index);
        }
      }, {
        title: '工作职责',
        dataIndex: 'jobResponsibility',
        width: 200,
        render: function render(text, record, index) {
          return _this4.spToInput(text, index);
        }
      }, {
        title: '工作标准',
        dataIndex: 'jobStandard',
        width: 200,
        render: function render(text, record, index) {
          return _this4.spToInput(text, index);
        }
      }, {
        title: '完成情况',
        dataIndex: 'complete',
        width: 300,
        render: function render(text, record, index) {
          return _this4.spToInput(text, index);
        }
      }, {
        title: '评分标准',
        dataIndex: 'scoreStandard',
        width: 200,
        render: function render(text, record, index) {
          return _this4.spToInput(text, index);
        }
      }];

      var _state = this.state,
          loading = _state.loading,
          selectedRowKeys = _state.selectedRowKeys;

      var rowSelection = {
        selectedRowKeys: selectedRowKeys,
        onChange: this.onSelectChange.bind(this)
      };
      var hasSelected = selectedRowKeys.length > 0;

      return _react3.default.createElement(
        'div',
        { style: { marginBottom: 50 } },
        _react3.default.createElement(
          'div',
          { style: { marginBottom: 16 } },
          _react3.default.createElement(WrappedProjectModal, _extends({}, pageUrls, { visible: this.state.visible, rows: this.state.selectedRowKeys,
            recData: this.state.recData, transferMsg: function transferMsg(recData) {
              return _this4.transferMsg(recData);
            } })),
          _react3.default.createElement(
            'span',
            { style: { marginLeft: 8 } },
            hasSelected ? 'Selected ' + selectedRowKeys.length + ' items' : ''
          )
        ),
        _react3.default.createElement(_table2.default, { key: this.key++, scroll: { y: 1000 }, bordered: true, pagination: false, rowSelection: rowSelection, columns: columns, onChange: this.onChange.bind(this), dataSource: this.state.recData })
      );
    }
  }]);

  return AppTable;
}(_react3.default.Component));

var WrappedProjectModal = _form2.default.create()(AppModal);
if (document.getElementById("proManagement")) _reactDom2.default.render(_react3.default.createElement(AppTable, pageUrls), document.getElementById("proManagement"));
exports.default = AppTable;
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(14)(module), __webpack_require__(16)))

/***/ }),

/***/ 498:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(module, $) {

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _table = __webpack_require__(31);

var _table2 = _interopRequireDefault(_table);

var _button = __webpack_require__(18);

var _button2 = _interopRequireDefault(_button);

var _input = __webpack_require__(28);

var _input2 = _interopRequireDefault(_input);

var _datePicker = __webpack_require__(35);

var _datePicker2 = _interopRequireDefault(_datePicker);

var _index = __webpack_require__(21);

var _index2 = _interopRequireDefault(_index);

var _index3 = __webpack_require__(19);

var _index4 = _interopRequireDefault(_index3);

var _react2 = __webpack_require__(0);

var _react3 = _interopRequireDefault(_react2);

var _index5 = __webpack_require__(20);

var _index6 = _interopRequireDefault(_index5);

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

__webpack_require__(32);

__webpack_require__(22);

__webpack_require__(23);

__webpack_require__(36);

var _reactDom = __webpack_require__(11);

var _reactDom2 = _interopRequireDefault(_reactDom);

var _Sorter = __webpack_require__(33);

var _Sorter2 = _interopRequireDefault(_Sorter);

var _Filters = __webpack_require__(40);

var _Filters2 = _interopRequireDefault(_Filters);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var _components = {
  YearSummarySheet: {
    displayName: 'YearSummarySheet'
  }
};

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2 = (0, _index6.default)({
  filename: '/Users/huang/work/dzoms_react/components/kp/yearSummarySheet.js',
  components: _components,
  locals: [module],
  imports: [_react3.default]
});

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2 = (0, _index4.default)({
  filename: '/Users/huang/work/dzoms_react/components/kp/yearSummarySheet.js',
  components: _components,
  locals: [],
  imports: [_react3.default, _index2.default]
});

function _wrapComponent(id) {
  return function (Component) {
    return _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2(_UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2(Component, id), id);
  };
}

var MonthPicker = _datePicker2.default.MonthPicker,
    RangePicker = _datePicker2.default.RangePicker;
var TextArea = _input2.default.TextArea;

var dateFormat = 'YYYY/MM/DD';
var monthFormat = 'YYYY/MM';

var YearSummarySheet = _wrapComponent('YearSummarySheet')(function (_React$Component) {
  _inherits(YearSummarySheet, _React$Component);

  function YearSummarySheet(props) {
    _classCallCheck(this, YearSummarySheet);

    var _this = _possibleConstructorReturn(this, (YearSummarySheet.__proto__ || Object.getPrototypeOf(YearSummarySheet)).call(this, props));

    _this.state = {
      recData: []
    };
    return _this;
  }

  _createClass(YearSummarySheet, [{
    key: 'componentDidMount',
    value: function componentDidMount() {
      var self = this;
      $.ajax({
        url: self.props.yearSummarySheetUrl,
        type: "get",
        dataType: 'json',
        contentType: 'application/json',
        success: function (data) {
          if (data.status > 0) {
            if (data) {
              var data = data.data;
              for (var i = 0; i < data.length; i++) {
                for (var j in data[i]) {
                  //数据类型转换，数字类型筛选的时候会报错
                  if (data[i][j] == null) {
                    data[i][j] = "无";
                  }
                }
              }
              self.setState({
                recData: data
              });
            } else {
              recData: "";
            }
          } else {
            return;
          }
        }.bind(self),
        error: function error() {
          alert("请求失败");
        }
      });
    }
  }, {
    key: 'render',
    value: function render() {
      var filterData = new _Filters2.default().filter(this.state.recData);
      var formItemLayout = {
        labelCol: { span: 4 },
        wrapperCol: { span: 20 }
      };
      var recData = this.state.recData;
      var columns = [{
        title: '姓名',
        dataIndex: 'name',
        filters: filterData.name,
        width: 170,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.name, b.name);
        },
        onFilter: function onFilter(value, record) {
          return record.name.indexOf(value) === 0;
        }
      }, {
        title: '部门',
        dataIndex: 'department',
        filters: filterData.department,
        width: 170,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.department, b.department);
        },
        onFilter: function onFilter(value, record) {
          return record.department.indexOf(value) === 0;
        }
      }, {
        title: '一月',
        dataIndex: 'january',
        width: 150,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.january, b.january);
        }
      }, {
        title: '二月',
        dataIndex: 'february',
        width: 150,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.february, b.february);
        }
      }, {
        title: '三月',
        dataIndex: 'march',
        width: 150,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.march, b.march);
        }
      }, {
        title: '四月',
        dataIndex: 'april',
        width: 150,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.april, b.april);
        }
      }, {
        title: '五月',
        dataIndex: 'may',
        width: 150,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.may, b.may);
        }
      }, {
        title: '六月',
        dataIndex: 'june',
        width: 150,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.june, b.june);
        }
      }, {
        title: '七月',
        dataIndex: 'july',
        width: 150,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.july, b.july);
        }
      }, {
        title: '八月',
        dataIndex: 'august',
        width: 150,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.august, b.august);
        }
      }, {
        title: '九月',
        dataIndex: 'september',
        width: 150,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.september, b.september);
        }
      }, {
        title: '十月',
        dataIndex: 'october',
        width: 150,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.october, b.october);
        }
      }, {
        title: '十一月',
        dataIndex: 'november',
        width: 150,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.november, b.november);
        }
      }, {
        title: '十二月',
        dataIndex: 'december',
        width: 150,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.december, b.december);
        }
      }, {
        title: '总分',
        dataIndex: 'total',
        width: 170,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.total, b.total);
        }
      }, {
        title: '平均分',
        dataIndex: 'average',
        width: 170,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.average, b.average);
        }
      }];
      return _react3.default.createElement(
        'div',
        { style: { marginBottom: 100 } },
        _react3.default.createElement(
          'div',
          { id: 'header' },
          _react3.default.createElement(
            'h2',
            null,
            '\u5E74\u5EA6\u7EE9\u6548\u8003\u6838\u6C47\u603B\u8868'
          )
        ),
        _react3.default.createElement(
          'div',
          { style: { marginLeft: 200, marginBottom: 10 } },
          _react3.default.createElement(
            _button2.default,
            { type: 'primary', style: { width: 200 } },
            _react3.default.createElement(
              'a',
              { href: this.props.exportUrl, target: '_blank' },
              '\u5BFC\u51FA'
            )
          )
        ),
        _react3.default.createElement(_table2.default, { style: { width: 1200, margin: '0 auto' }, bordered: true, columns: columns, dataSource: this.state.recData })
      );
    }
  }]);

  return YearSummarySheet;
}(_react3.default.Component));

if (document.getElementById("yearSummarySheet")) {
  _reactDom2.default.render(_react3.default.createElement(YearSummarySheet, pageUrls), document.getElementById("yearSummarySheet"));
}
exports.default = YearSummarySheet;
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(14)(module), __webpack_require__(16)))

/***/ }),

/***/ 512:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
    value: true
});
exports['default'] = triggerEvent;
function triggerEvent(el, type) {
    if ('createEvent' in document) {
        // modern browsers, IE9+
        var e = document.createEvent('HTMLEvents');
        e.initEvent(type, false, true);
        el.dispatchEvent(e);
    }
}
module.exports = exports['default'];

/***/ }),

/***/ 518:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
    value: true
});

var _extends2 = __webpack_require__(3);

var _extends3 = _interopRequireDefault(_extends2);

var _defineProperty2 = __webpack_require__(10);

var _defineProperty3 = _interopRequireDefault(_defineProperty2);

var _classCallCheck2 = __webpack_require__(4);

var _classCallCheck3 = _interopRequireDefault(_classCallCheck2);

var _createClass2 = __webpack_require__(7);

var _createClass3 = _interopRequireDefault(_createClass2);

var _possibleConstructorReturn2 = __webpack_require__(6);

var _possibleConstructorReturn3 = _interopRequireDefault(_possibleConstructorReturn2);

var _inherits2 = __webpack_require__(5);

var _inherits3 = _interopRequireDefault(_inherits2);

var _react = __webpack_require__(0);

var _react2 = _interopRequireDefault(_react);

var _rcCascader = __webpack_require__(836);

var _rcCascader2 = _interopRequireDefault(_rcCascader);

var _arrayTreeFilter = __webpack_require__(154);

var _arrayTreeFilter2 = _interopRequireDefault(_arrayTreeFilter);

var _classnames = __webpack_require__(9);

var _classnames2 = _interopRequireDefault(_classnames);

var _omit = __webpack_require__(64);

var _omit2 = _interopRequireDefault(_omit);

var _KeyCode = __webpack_require__(49);

var _KeyCode2 = _interopRequireDefault(_KeyCode);

var _input = __webpack_require__(28);

var _input2 = _interopRequireDefault(_input);

var _icon = __webpack_require__(42);

var _icon2 = _interopRequireDefault(_icon);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var __rest = undefined && undefined.__rest || function (s, e) {
    var t = {};
    for (var p in s) {
        if (Object.prototype.hasOwnProperty.call(s, p) && e.indexOf(p) < 0) t[p] = s[p];
    }if (s != null && typeof Object.getOwnPropertySymbols === "function") for (var i = 0, p = Object.getOwnPropertySymbols(s); i < p.length; i++) {
        if (e.indexOf(p[i]) < 0) t[p[i]] = s[p[i]];
    }return t;
};

function highlightKeyword(str, keyword, prefixCls) {
    return str.split(keyword).map(function (node, index) {
        return index === 0 ? node : [_react2['default'].createElement(
            'span',
            { className: prefixCls + '-menu-item-keyword', key: 'seperator' },
            keyword
        ), node];
    });
}
function defaultFilterOption(inputValue, path) {
    return path.some(function (option) {
        return option.label.indexOf(inputValue) > -1;
    });
}
function defaultRenderFilteredOption(inputValue, path, prefixCls) {
    return path.map(function (_ref, index) {
        var label = _ref.label;

        var node = label.indexOf(inputValue) > -1 ? highlightKeyword(label, inputValue, prefixCls) : label;
        return index === 0 ? node : [' / ', node];
    });
}
function defaultSortFilteredOption(a, b, inputValue) {
    function callback(elem) {
        return elem.label.indexOf(inputValue) > -1;
    }
    return a.findIndex(callback) - b.findIndex(callback);
}
var defaultDisplayRender = function defaultDisplayRender(label) {
    return label.join(' / ');
};

var Cascader = function (_React$Component) {
    (0, _inherits3['default'])(Cascader, _React$Component);

    function Cascader(props) {
        (0, _classCallCheck3['default'])(this, Cascader);

        var _this = (0, _possibleConstructorReturn3['default'])(this, (Cascader.__proto__ || Object.getPrototypeOf(Cascader)).call(this, props));

        _this.handleChange = function (value, selectedOptions) {
            _this.setState({ inputValue: '' });
            if (selectedOptions[0].__IS_FILTERED_OPTION) {
                var unwrappedValue = value[0];
                var unwrappedSelectedOptions = selectedOptions[0].path;
                _this.setValue(unwrappedValue, unwrappedSelectedOptions);
                return;
            }
            _this.setValue(value, selectedOptions);
        };
        _this.handlePopupVisibleChange = function (popupVisible) {
            if (!('popupVisible' in _this.props)) {
                _this.setState({
                    popupVisible: popupVisible,
                    inputFocused: popupVisible,
                    inputValue: popupVisible ? _this.state.inputValue : ''
                });
            }
            var onPopupVisibleChange = _this.props.onPopupVisibleChange;
            if (onPopupVisibleChange) {
                onPopupVisibleChange(popupVisible);
            }
        };
        _this.handleInputBlur = function () {
            _this.setState({
                inputFocused: false
            });
        };
        _this.handleInputClick = function (e) {
            var _this$state = _this.state,
                inputFocused = _this$state.inputFocused,
                popupVisible = _this$state.popupVisible;
            // Prevent `Trigger` behaviour.

            if (inputFocused || popupVisible) {
                e.stopPropagation();
                e.nativeEvent.stopImmediatePropagation();
            }
        };
        _this.handleKeyDown = function (e) {
            if (e.keyCode === _KeyCode2['default'].BACKSPACE) {
                e.stopPropagation();
            }
        };
        _this.handleInputChange = function (e) {
            var inputValue = e.target.value;
            _this.setState({ inputValue: inputValue });
        };
        _this.setValue = function (value) {
            var selectedOptions = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : [];

            if (!('value' in _this.props)) {
                _this.setState({ value: value });
            }
            var onChange = _this.props.onChange;
            if (onChange) {
                onChange(value, selectedOptions);
            }
        };
        _this.clearSelection = function (e) {
            e.preventDefault();
            e.stopPropagation();
            if (!_this.state.inputValue) {
                _this.setValue([]);
                _this.handlePopupVisibleChange(false);
            } else {
                _this.setState({ inputValue: '' });
            }
        };
        _this.state = {
            value: props.value || props.defaultValue || [],
            inputValue: '',
            inputFocused: false,
            popupVisible: props.popupVisible,
            flattenOptions: props.showSearch && _this.flattenTree(props.options, props.changeOnSelect)
        };
        return _this;
    }

    (0, _createClass3['default'])(Cascader, [{
        key: 'componentWillReceiveProps',
        value: function componentWillReceiveProps(nextProps) {
            if ('value' in nextProps) {
                this.setState({ value: nextProps.value || [] });
            }
            if ('popupVisible' in nextProps) {
                this.setState({ popupVisible: nextProps.popupVisible });
            }
            if (nextProps.showSearch && this.props.options !== nextProps.options) {
                this.setState({ flattenOptions: this.flattenTree(nextProps.options, nextProps.changeOnSelect) });
            }
        }
    }, {
        key: 'getLabel',
        value: function getLabel() {
            var _props = this.props,
                options = _props.options,
                _props$displayRender = _props.displayRender,
                displayRender = _props$displayRender === undefined ? defaultDisplayRender : _props$displayRender;

            var value = this.state.value;
            var unwrappedValue = Array.isArray(value[0]) ? value[0] : value;
            var selectedOptions = (0, _arrayTreeFilter2['default'])(options, function (o, level) {
                return o.value === unwrappedValue[level];
            });
            var label = selectedOptions.map(function (o) {
                return o.label;
            });
            return displayRender(label, selectedOptions);
        }
    }, {
        key: 'flattenTree',
        value: function flattenTree(options, changeOnSelect) {
            var _this2 = this;

            var ancestor = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : [];

            var flattenOptions = [];
            options.forEach(function (option) {
                var path = ancestor.concat(option);
                if (changeOnSelect || !option.children || !option.children.length) {
                    flattenOptions.push(path);
                }
                if (option.children) {
                    flattenOptions = flattenOptions.concat(_this2.flattenTree(option.children, changeOnSelect, path));
                }
            });
            return flattenOptions;
        }
    }, {
        key: 'generateFilteredOptions',
        value: function generateFilteredOptions(prefixCls) {
            var _this3 = this;

            var _props2 = this.props,
                showSearch = _props2.showSearch,
                notFoundContent = _props2.notFoundContent;
            var _showSearch$filter = showSearch.filter,
                filter = _showSearch$filter === undefined ? defaultFilterOption : _showSearch$filter,
                _showSearch$render = showSearch.render,
                render = _showSearch$render === undefined ? defaultRenderFilteredOption : _showSearch$render,
                _showSearch$sort = showSearch.sort,
                sort = _showSearch$sort === undefined ? defaultSortFilteredOption : _showSearch$sort;
            var _state = this.state,
                flattenOptions = _state.flattenOptions,
                inputValue = _state.inputValue;

            var filtered = flattenOptions.filter(function (path) {
                return filter(_this3.state.inputValue, path);
            }).sort(function (a, b) {
                return sort(a, b, inputValue);
            });
            if (filtered.length > 0) {
                return filtered.map(function (path) {
                    return {
                        __IS_FILTERED_OPTION: true,
                        path: path,
                        label: render(inputValue, path, prefixCls),
                        value: path.map(function (o) {
                            return o.value;
                        }),
                        disabled: path.some(function (o) {
                            return o.disabled;
                        })
                    };
                });
            }
            return [{ label: notFoundContent, value: 'ANT_CASCADER_NOT_FOUND', disabled: true }];
        }
    }, {
        key: 'render',
        value: function render() {
            var _classNames, _classNames2, _classNames3;

            var props = this.props,
                state = this.state;

            var prefixCls = props.prefixCls,
                inputPrefixCls = props.inputPrefixCls,
                children = props.children,
                placeholder = props.placeholder,
                size = props.size,
                disabled = props.disabled,
                className = props.className,
                style = props.style,
                allowClear = props.allowClear,
                _props$showSearch = props.showSearch,
                showSearch = _props$showSearch === undefined ? false : _props$showSearch,
                otherProps = __rest(props, ["prefixCls", "inputPrefixCls", "children", "placeholder", "size", "disabled", "className", "style", "allowClear", "showSearch"]);

            var value = state.value;
            var sizeCls = (0, _classnames2['default'])((_classNames = {}, (0, _defineProperty3['default'])(_classNames, inputPrefixCls + '-lg', size === 'large'), (0, _defineProperty3['default'])(_classNames, inputPrefixCls + '-sm', size === 'small'), _classNames));
            var clearIcon = allowClear && !disabled && value.length > 0 || state.inputValue ? _react2['default'].createElement(_icon2['default'], { type: 'cross-circle', className: prefixCls + '-picker-clear', onClick: this.clearSelection }) : null;
            var arrowCls = (0, _classnames2['default'])((_classNames2 = {}, (0, _defineProperty3['default'])(_classNames2, prefixCls + '-picker-arrow', true), (0, _defineProperty3['default'])(_classNames2, prefixCls + '-picker-arrow-expand', state.popupVisible), _classNames2));
            var pickerCls = (0, _classnames2['default'])(className, (_classNames3 = {}, (0, _defineProperty3['default'])(_classNames3, prefixCls + '-picker', true), (0, _defineProperty3['default'])(_classNames3, prefixCls + '-picker-with-value', state.inputValue), (0, _defineProperty3['default'])(_classNames3, prefixCls + '-picker-disabled', disabled), _classNames3));
            // Fix bug of https://github.com/facebook/react/pull/5004
            // and https://fb.me/react-unknown-prop
            var inputProps = (0, _omit2['default'])(otherProps, ['onChange', 'options', 'popupPlacement', 'transitionName', 'displayRender', 'onPopupVisibleChange', 'changeOnSelect', 'expandTrigger', 'popupVisible', 'getPopupContainer', 'loadData', 'popupClassName', 'filterOption', 'renderFilteredOption', 'sortFilteredOption', 'notFoundContent']);
            var options = props.options;
            if (state.inputValue) {
                options = this.generateFilteredOptions(prefixCls);
            }
            // Dropdown menu should keep previous status until it is fully closed.
            if (!state.popupVisible) {
                options = this.cachedOptions;
            } else {
                this.cachedOptions = options;
            }
            var dropdownMenuColumnStyle = {};
            var isNotFound = (options || []).length === 1 && options[0].value === 'ANT_CASCADER_NOT_FOUND';
            if (isNotFound) {
                dropdownMenuColumnStyle.height = 'auto'; // Height of one row.
            }
            // The default value of `matchInputWidth` is `true`
            var resultListMatchInputWidth = showSearch.matchInputWidth === false ? false : true;
            if (resultListMatchInputWidth && state.inputValue && this.refs.input) {
                dropdownMenuColumnStyle.width = this.refs.input.refs.input.offsetWidth;
            }
            var input = children || _react2['default'].createElement(
                'span',
                { style: style, className: pickerCls },
                _react2['default'].createElement(
                    'span',
                    { className: prefixCls + '-picker-label' },
                    this.getLabel()
                ),
                _react2['default'].createElement(_input2['default'], (0, _extends3['default'])({}, inputProps, { ref: 'input', prefixCls: inputPrefixCls, placeholder: value && value.length > 0 ? undefined : placeholder, className: prefixCls + '-input ' + sizeCls, value: state.inputValue, disabled: disabled, readOnly: !showSearch, autoComplete: 'off', onClick: showSearch ? this.handleInputClick : undefined, onBlur: showSearch ? this.handleInputBlur : undefined, onKeyDown: this.handleKeyDown, onChange: showSearch ? this.handleInputChange : undefined })),
                clearIcon,
                _react2['default'].createElement(_icon2['default'], { type: 'down', className: arrowCls })
            );
            return _react2['default'].createElement(
                _rcCascader2['default'],
                (0, _extends3['default'])({}, props, { options: options, value: value, popupVisible: state.popupVisible, onPopupVisibleChange: this.handlePopupVisibleChange, onChange: this.handleChange, dropdownMenuColumnStyle: dropdownMenuColumnStyle }),
                input
            );
        }
    }]);
    return Cascader;
}(_react2['default'].Component);

exports['default'] = Cascader;

Cascader.defaultProps = {
    prefixCls: 'ant-cascader',
    inputPrefixCls: 'ant-input',
    placeholder: 'Please select',
    transitionName: 'slide-up',
    popupPlacement: 'bottomLeft',
    options: [],
    disabled: false,
    allowClear: true,
    notFoundContent: 'Not Found'
};
module.exports = exports['default'];

/***/ }),

/***/ 519:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


__webpack_require__(26);

__webpack_require__(1021);

__webpack_require__(23);

/***/ }),

/***/ 568:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
    value: true
});

var _toConsumableArray2 = __webpack_require__(61);

var _toConsumableArray3 = _interopRequireDefault(_toConsumableArray2);

var _defineProperty2 = __webpack_require__(10);

var _defineProperty3 = _interopRequireDefault(_defineProperty2);

var _classCallCheck2 = __webpack_require__(4);

var _classCallCheck3 = _interopRequireDefault(_classCallCheck2);

var _createClass2 = __webpack_require__(7);

var _createClass3 = _interopRequireDefault(_createClass2);

var _possibleConstructorReturn2 = __webpack_require__(6);

var _possibleConstructorReturn3 = _interopRequireDefault(_possibleConstructorReturn2);

var _inherits2 = __webpack_require__(5);

var _inherits3 = _interopRequireDefault(_inherits2);

var _react = __webpack_require__(0);

var _react2 = _interopRequireDefault(_react);

var _propTypes = __webpack_require__(2);

var _propTypes2 = _interopRequireDefault(_propTypes);

var _classnames = __webpack_require__(9);

var _classnames2 = _interopRequireDefault(_classnames);

var _list = __webpack_require__(570);

var _list2 = _interopRequireDefault(_list);

var _operation = __webpack_require__(571);

var _operation2 = _interopRequireDefault(_operation);

var _search = __webpack_require__(257);

var _search2 = _interopRequireDefault(_search);

var _injectLocale = __webpack_require__(150);

var _injectLocale2 = _interopRequireDefault(_injectLocale);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

function noop() {}

var Transfer = function (_React$Component) {
    (0, _inherits3['default'])(Transfer, _React$Component);

    function Transfer(props) {
        (0, _classCallCheck3['default'])(this, Transfer);

        var _this = (0, _possibleConstructorReturn3['default'])(this, (Transfer.__proto__ || Object.getPrototypeOf(Transfer)).call(this, props));

        _this.moveTo = function (direction) {
            var _this$props = _this.props,
                _this$props$targetKey = _this$props.targetKeys,
                targetKeys = _this$props$targetKey === undefined ? [] : _this$props$targetKey,
                _this$props$dataSourc = _this$props.dataSource,
                dataSource = _this$props$dataSourc === undefined ? [] : _this$props$dataSourc,
                onChange = _this$props.onChange;
            var _this$state = _this.state,
                sourceSelectedKeys = _this$state.sourceSelectedKeys,
                targetSelectedKeys = _this$state.targetSelectedKeys;

            var moveKeys = direction === 'right' ? sourceSelectedKeys : targetSelectedKeys;
            // filter the disabled options
            var newMoveKeys = moveKeys.filter(function (key) {
                return !dataSource.some(function (data) {
                    return !!(key === data.key && data.disabled);
                });
            });
            // move items to target box
            var newTargetKeys = direction === 'right' ? newMoveKeys.concat(targetKeys) : targetKeys.filter(function (targetKey) {
                return newMoveKeys.indexOf(targetKey) === -1;
            });
            // empty checked keys
            var oppositeDirection = direction === 'right' ? 'left' : 'right';
            _this.setState((0, _defineProperty3['default'])({}, _this.getSelectedKeysName(oppositeDirection), []));
            _this.handleSelectChange(oppositeDirection, []);
            if (onChange) {
                onChange(newTargetKeys, direction, newMoveKeys);
            }
        };
        _this.moveToLeft = function () {
            return _this.moveTo('left');
        };
        _this.moveToRight = function () {
            return _this.moveTo('right');
        };
        _this.handleSelectAll = function (direction, filteredDataSource, checkAll) {
            var originalSelectedKeys = _this.state[_this.getSelectedKeysName(direction)] || [];
            var currentKeys = filteredDataSource.map(function (item) {
                return item.key;
            });
            // Only operate current keys from original selected keys
            var newKeys1 = originalSelectedKeys.filter(function (key) {
                return currentKeys.indexOf(key) === -1;
            });
            var newKeys2 = [].concat((0, _toConsumableArray3['default'])(originalSelectedKeys));
            currentKeys.forEach(function (key) {
                if (newKeys2.indexOf(key) === -1) {
                    newKeys2.push(key);
                }
            });
            var holder = checkAll ? newKeys1 : newKeys2;
            _this.handleSelectChange(direction, holder);
            if (!_this.props.selectedKeys) {
                _this.setState((0, _defineProperty3['default'])({}, _this.getSelectedKeysName(direction), holder));
            }
        };
        _this.handleLeftSelectAll = function (filteredDataSource, checkAll) {
            return _this.handleSelectAll('left', filteredDataSource, checkAll);
        };
        _this.handleRightSelectAll = function (filteredDataSource, checkAll) {
            return _this.handleSelectAll('right', filteredDataSource, checkAll);
        };
        _this.handleFilter = function (direction, e) {
            _this.setState((0, _defineProperty3['default'])({}, direction + 'Filter', e.target.value));
            if (_this.props.onSearchChange) {
                _this.props.onSearchChange(direction, e);
            }
        };
        _this.handleLeftFilter = function (e) {
            return _this.handleFilter('left', e);
        };
        _this.handleRightFilter = function (e) {
            return _this.handleFilter('right', e);
        };
        _this.handleClear = function (direction) {
            _this.setState((0, _defineProperty3['default'])({}, direction + 'Filter', ''));
        };
        _this.handleLeftClear = function () {
            return _this.handleClear('left');
        };
        _this.handleRightClear = function () {
            return _this.handleClear('right');
        };
        _this.handleSelect = function (direction, selectedItem, checked) {
            var _this$state2 = _this.state,
                sourceSelectedKeys = _this$state2.sourceSelectedKeys,
                targetSelectedKeys = _this$state2.targetSelectedKeys;

            var holder = direction === 'left' ? [].concat((0, _toConsumableArray3['default'])(sourceSelectedKeys)) : [].concat((0, _toConsumableArray3['default'])(targetSelectedKeys));
            var index = holder.indexOf(selectedItem.key);
            if (index > -1) {
                holder.splice(index, 1);
            }
            if (checked) {
                holder.push(selectedItem.key);
            }
            _this.handleSelectChange(direction, holder);
            if (!_this.props.selectedKeys) {
                _this.setState((0, _defineProperty3['default'])({}, _this.getSelectedKeysName(direction), holder));
            }
        };
        _this.handleLeftSelect = function (selectedItem, checked) {
            return _this.handleSelect('left', selectedItem, checked);
        };
        _this.handleRightSelect = function (selectedItem, checked) {
            return _this.handleSelect('right', selectedItem, checked);
        };
        _this.handleScroll = function (direction, e) {
            var onScroll = _this.props.onScroll;

            if (onScroll) {
                onScroll(direction, e);
            }
        };
        _this.handleLeftScroll = function (e) {
            return _this.handleScroll('left', e);
        };
        _this.handleRightScroll = function (e) {
            return _this.handleScroll('right', e);
        };
        var _props$selectedKeys = props.selectedKeys,
            selectedKeys = _props$selectedKeys === undefined ? [] : _props$selectedKeys,
            _props$targetKeys = props.targetKeys,
            targetKeys = _props$targetKeys === undefined ? [] : _props$targetKeys;

        _this.state = {
            leftFilter: '',
            rightFilter: '',
            sourceSelectedKeys: selectedKeys.filter(function (key) {
                return targetKeys.indexOf(key) === -1;
            }),
            targetSelectedKeys: selectedKeys.filter(function (key) {
                return targetKeys.indexOf(key) > -1;
            })
        };
        return _this;
    }

    (0, _createClass3['default'])(Transfer, [{
        key: 'componentWillReceiveProps',
        value: function componentWillReceiveProps(nextProps) {
            var _state = this.state,
                sourceSelectedKeys = _state.sourceSelectedKeys,
                targetSelectedKeys = _state.targetSelectedKeys;

            if (nextProps.targetKeys !== this.props.targetKeys || nextProps.dataSource !== this.props.dataSource) {
                // clear cached splited dataSource
                this.splitedDataSource = null;
                if (!nextProps.selectedKeys) {
                    // clear key nolonger existed
                    // clear checkedKeys according to targetKeys
                    var dataSource = nextProps.dataSource,
                        _nextProps$targetKeys = nextProps.targetKeys,
                        targetKeys = _nextProps$targetKeys === undefined ? [] : _nextProps$targetKeys;

                    var newSourceSelectedKeys = [];
                    var newTargetSelectedKeys = [];
                    dataSource.forEach(function (_ref) {
                        var key = _ref.key;

                        if (sourceSelectedKeys.includes(key) && !targetKeys.includes(key)) {
                            newSourceSelectedKeys.push(key);
                        }
                        if (targetSelectedKeys.includes(key) && targetKeys.includes(key)) {
                            newTargetSelectedKeys.push(key);
                        }
                    });
                    this.setState({
                        sourceSelectedKeys: newSourceSelectedKeys,
                        targetSelectedKeys: newTargetSelectedKeys
                    });
                }
            }
            if (nextProps.selectedKeys) {
                var _targetKeys = nextProps.targetKeys || [];
                this.setState({
                    sourceSelectedKeys: nextProps.selectedKeys.filter(function (key) {
                        return !_targetKeys.includes(key);
                    }),
                    targetSelectedKeys: nextProps.selectedKeys.filter(function (key) {
                        return _targetKeys.includes(key);
                    })
                });
            }
        }
    }, {
        key: 'splitDataSource',
        value: function splitDataSource(props) {
            if (this.splitedDataSource) {
                return this.splitedDataSource;
            }
            var dataSource = props.dataSource,
                rowKey = props.rowKey,
                _props$targetKeys2 = props.targetKeys,
                targetKeys = _props$targetKeys2 === undefined ? [] : _props$targetKeys2;

            var leftDataSource = [];
            var rightDataSource = new Array(targetKeys.length);
            dataSource.forEach(function (record) {
                if (rowKey) {
                    record.key = rowKey(record);
                }
                // rightDataSource should be ordered by targetKeys
                // leftDataSource should be ordered by dataSource
                var indexOfKey = targetKeys.indexOf(record.key);
                if (indexOfKey !== -1) {
                    rightDataSource[indexOfKey] = record;
                } else {
                    leftDataSource.push(record);
                }
            });
            this.splitedDataSource = {
                leftDataSource: leftDataSource,
                rightDataSource: rightDataSource
            };
            return this.splitedDataSource;
        }
    }, {
        key: 'handleSelectChange',
        value: function handleSelectChange(direction, holder) {
            var _state2 = this.state,
                sourceSelectedKeys = _state2.sourceSelectedKeys,
                targetSelectedKeys = _state2.targetSelectedKeys;

            var onSelectChange = this.props.onSelectChange;
            if (!onSelectChange) {
                return;
            }
            if (direction === 'left') {
                onSelectChange(holder, targetSelectedKeys);
            } else {
                onSelectChange(sourceSelectedKeys, holder);
            }
        }
    }, {
        key: 'getTitles',
        value: function getTitles() {
            var props = this.props;

            if (props.titles) {
                return props.titles;
            }
            var transferLocale = this.getLocale();
            return transferLocale.titles;
        }
    }, {
        key: 'getSelectedKeysName',
        value: function getSelectedKeysName(direction) {
            return direction === 'left' ? 'sourceSelectedKeys' : 'targetSelectedKeys';
        }
    }, {
        key: 'render',
        value: function render() {
            var locale = this.getLocale();
            var _props = this.props,
                _props$prefixCls = _props.prefixCls,
                prefixCls = _props$prefixCls === undefined ? 'ant-transfer' : _props$prefixCls,
                className = _props.className,
                _props$operations = _props.operations,
                operations = _props$operations === undefined ? [] : _props$operations,
                showSearch = _props.showSearch,
                _props$notFoundConten = _props.notFoundContent,
                notFoundContent = _props$notFoundConten === undefined ? locale.notFoundContent : _props$notFoundConten,
                _props$searchPlacehol = _props.searchPlaceholder,
                searchPlaceholder = _props$searchPlacehol === undefined ? locale.searchPlaceholder : _props$searchPlacehol,
                body = _props.body,
                footer = _props.footer,
                listStyle = _props.listStyle,
                filterOption = _props.filterOption,
                render = _props.render,
                lazy = _props.lazy;
            var _state3 = this.state,
                leftFilter = _state3.leftFilter,
                rightFilter = _state3.rightFilter,
                sourceSelectedKeys = _state3.sourceSelectedKeys,
                targetSelectedKeys = _state3.targetSelectedKeys;

            var _splitDataSource = this.splitDataSource(this.props),
                leftDataSource = _splitDataSource.leftDataSource,
                rightDataSource = _splitDataSource.rightDataSource;

            var leftActive = targetSelectedKeys.length > 0;
            var rightActive = sourceSelectedKeys.length > 0;
            var cls = (0, _classnames2['default'])(className, prefixCls);
            var titles = this.getTitles();
            return _react2['default'].createElement(
                'div',
                { className: cls },
                _react2['default'].createElement(_list2['default'], { prefixCls: prefixCls + '-list', titleText: titles[0], dataSource: leftDataSource, filter: leftFilter, filterOption: filterOption, style: listStyle, checkedKeys: sourceSelectedKeys, handleFilter: this.handleLeftFilter, handleClear: this.handleLeftClear, handleSelect: this.handleLeftSelect, handleSelectAll: this.handleLeftSelectAll, render: render, showSearch: showSearch, searchPlaceholder: searchPlaceholder, notFoundContent: notFoundContent, itemUnit: locale.itemUnit, itemsUnit: locale.itemsUnit, body: body, footer: footer, lazy: lazy, onScroll: this.handleLeftScroll }),
                _react2['default'].createElement(_operation2['default'], { className: prefixCls + '-operation', rightActive: rightActive, rightArrowText: operations[0], moveToRight: this.moveToRight, leftActive: leftActive, leftArrowText: operations[1], moveToLeft: this.moveToLeft }),
                _react2['default'].createElement(_list2['default'], { prefixCls: prefixCls + '-list', titleText: titles[1], dataSource: rightDataSource, filter: rightFilter, filterOption: filterOption, style: listStyle, checkedKeys: targetSelectedKeys, handleFilter: this.handleRightFilter, handleClear: this.handleRightClear, handleSelect: this.handleRightSelect, handleSelectAll: this.handleRightSelectAll, render: render, showSearch: showSearch, searchPlaceholder: searchPlaceholder, notFoundContent: notFoundContent, itemUnit: locale.itemUnit, itemsUnit: locale.itemsUnit, body: body, footer: footer, lazy: lazy, onScroll: this.handleRightScroll })
            );
        }
    }]);
    return Transfer;
}(_react2['default'].Component);
// For high-level customized Transfer @dqaria


Transfer.List = _list2['default'];
Transfer.Operation = _operation2['default'];
Transfer.Search = _search2['default'];
Transfer.defaultProps = {
    dataSource: [],
    render: noop,
    showSearch: false
};
Transfer.propTypes = {
    prefixCls: _propTypes2['default'].string,
    dataSource: _propTypes2['default'].array,
    render: _propTypes2['default'].func,
    targetKeys: _propTypes2['default'].array,
    onChange: _propTypes2['default'].func,
    height: _propTypes2['default'].number,
    listStyle: _propTypes2['default'].object,
    className: _propTypes2['default'].string,
    titles: _propTypes2['default'].array,
    operations: _propTypes2['default'].array,
    showSearch: _propTypes2['default'].bool,
    filterOption: _propTypes2['default'].func,
    searchPlaceholder: _propTypes2['default'].string,
    notFoundContent: _propTypes2['default'].node,
    body: _propTypes2['default'].func,
    footer: _propTypes2['default'].func,
    rowKey: _propTypes2['default'].func,
    lazy: _propTypes2['default'].oneOfType([_propTypes2['default'].object, _propTypes2['default'].bool])
};
var injectTransferLocale = (0, _injectLocale2['default'])('Transfer', {
    titles: ['', ''],
    searchPlaceholder: 'Search',
    notFoundContent: 'Not Found'
});
exports['default'] = injectTransferLocale(Transfer);
module.exports = exports['default'];

/***/ }),

/***/ 569:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
    value: true
});

var _extends2 = __webpack_require__(3);

var _extends3 = _interopRequireDefault(_extends2);

var _defineProperty2 = __webpack_require__(10);

var _defineProperty3 = _interopRequireDefault(_defineProperty2);

var _classCallCheck2 = __webpack_require__(4);

var _classCallCheck3 = _interopRequireDefault(_classCallCheck2);

var _createClass2 = __webpack_require__(7);

var _createClass3 = _interopRequireDefault(_createClass2);

var _possibleConstructorReturn2 = __webpack_require__(6);

var _possibleConstructorReturn3 = _interopRequireDefault(_possibleConstructorReturn2);

var _inherits2 = __webpack_require__(5);

var _inherits3 = _interopRequireDefault(_inherits2);

var _react = __webpack_require__(0);

var _react2 = _interopRequireDefault(_react);

var _classnames = __webpack_require__(9);

var _classnames2 = _interopRequireDefault(_classnames);

var _PureRenderMixin = __webpack_require__(138);

var _PureRenderMixin2 = _interopRequireDefault(_PureRenderMixin);

var _reactLazyLoad = __webpack_require__(989);

var _reactLazyLoad2 = _interopRequireDefault(_reactLazyLoad);

var _checkbox = __webpack_require__(99);

var _checkbox2 = _interopRequireDefault(_checkbox);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var Item = function (_React$Component) {
    (0, _inherits3['default'])(Item, _React$Component);

    function Item() {
        (0, _classCallCheck3['default'])(this, Item);
        return (0, _possibleConstructorReturn3['default'])(this, (Item.__proto__ || Object.getPrototypeOf(Item)).apply(this, arguments));
    }

    (0, _createClass3['default'])(Item, [{
        key: 'shouldComponentUpdate',
        value: function shouldComponentUpdate() {
            for (var _len = arguments.length, args = Array(_len), _key = 0; _key < _len; _key++) {
                args[_key] = arguments[_key];
            }

            return _PureRenderMixin2['default'].shouldComponentUpdate.apply(this, args);
        }
    }, {
        key: 'render',
        value: function render() {
            var _classNames;

            var _props = this.props,
                renderedText = _props.renderedText,
                renderedEl = _props.renderedEl,
                item = _props.item,
                lazy = _props.lazy,
                checked = _props.checked,
                prefixCls = _props.prefixCls,
                onClick = _props.onClick;

            var className = (0, _classnames2['default'])((_classNames = {}, (0, _defineProperty3['default'])(_classNames, prefixCls + '-content-item', true), (0, _defineProperty3['default'])(_classNames, prefixCls + '-content-item-disabled', item.disabled), _classNames));
            var listItem = _react2['default'].createElement(
                'li',
                { className: className, title: renderedText, onClick: item.disabled ? undefined : function () {
                        return onClick(item);
                    } },
                _react2['default'].createElement(_checkbox2['default'], { checked: checked, disabled: item.disabled }),
                _react2['default'].createElement(
                    'span',
                    null,
                    renderedEl
                )
            );
            var children = null;
            if (lazy) {
                var lazyProps = (0, _extends3['default'])({ height: 32, offset: 500, throttle: 0, debounce: false }, lazy);
                children = _react2['default'].createElement(
                    _reactLazyLoad2['default'],
                    lazyProps,
                    listItem
                );
            } else {
                children = listItem;
            }
            return children;
        }
    }]);
    return Item;
}(_react2['default'].Component);

exports['default'] = Item;
module.exports = exports['default'];

/***/ }),

/***/ 570:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
    value: true
});

var _defineProperty2 = __webpack_require__(10);

var _defineProperty3 = _interopRequireDefault(_defineProperty2);

var _extends2 = __webpack_require__(3);

var _extends3 = _interopRequireDefault(_extends2);

var _classCallCheck2 = __webpack_require__(4);

var _classCallCheck3 = _interopRequireDefault(_classCallCheck2);

var _createClass2 = __webpack_require__(7);

var _createClass3 = _interopRequireDefault(_createClass2);

var _possibleConstructorReturn2 = __webpack_require__(6);

var _possibleConstructorReturn3 = _interopRequireDefault(_possibleConstructorReturn2);

var _inherits2 = __webpack_require__(5);

var _inherits3 = _interopRequireDefault(_inherits2);

var _react = __webpack_require__(0);

var _react2 = _interopRequireDefault(_react);

var _reactDom = __webpack_require__(11);

var _classnames = __webpack_require__(9);

var _classnames2 = _interopRequireDefault(_classnames);

var _rcAnimate = __webpack_require__(65);

var _rcAnimate2 = _interopRequireDefault(_rcAnimate);

var _PureRenderMixin = __webpack_require__(138);

var _PureRenderMixin2 = _interopRequireDefault(_PureRenderMixin);

var _checkbox = __webpack_require__(99);

var _checkbox2 = _interopRequireDefault(_checkbox);

var _search = __webpack_require__(257);

var _search2 = _interopRequireDefault(_search);

var _item = __webpack_require__(569);

var _item2 = _interopRequireDefault(_item);

var _triggerEvent = __webpack_require__(512);

var _triggerEvent2 = _interopRequireDefault(_triggerEvent);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

function noop() {}
function isRenderResultPlainObject(result) {
    return result && !_react2['default'].isValidElement(result) && Object.prototype.toString.call(result) === '[object Object]';
}

var TransferList = function (_React$Component) {
    (0, _inherits3['default'])(TransferList, _React$Component);

    function TransferList(props) {
        (0, _classCallCheck3['default'])(this, TransferList);

        var _this = (0, _possibleConstructorReturn3['default'])(this, (TransferList.__proto__ || Object.getPrototypeOf(TransferList)).call(this, props));

        _this.handleSelect = function (selectedItem) {
            var checkedKeys = _this.props.checkedKeys;

            var result = checkedKeys.some(function (key) {
                return key === selectedItem.key;
            });
            _this.props.handleSelect(selectedItem, !result);
        };
        _this.handleFilter = function (e) {
            _this.props.handleFilter(e);
            if (!e.target.value) {
                return;
            }
            // Manually trigger scroll event for lazy search bug
            // https://github.com/ant-design/ant-design/issues/5631
            _this.triggerScrollTimer = setTimeout(function () {
                var listNode = (0, _reactDom.findDOMNode)(_this).querySelectorAll('.ant-transfer-list-content')[0];
                if (listNode) {
                    (0, _triggerEvent2['default'])(listNode, 'scroll');
                }
            }, 0);
        };
        _this.handleClear = function () {
            _this.props.handleClear();
        };
        _this.matchFilter = function (text, item) {
            var _this$props = _this.props,
                filter = _this$props.filter,
                filterOption = _this$props.filterOption;

            if (filterOption) {
                return filterOption(filter, item);
            }
            return text.indexOf(filter) >= 0;
        };
        _this.renderItem = function (item) {
            var _this$props$render = _this.props.render,
                render = _this$props$render === undefined ? noop : _this$props$render;

            var renderResult = render(item);
            var isRenderResultPlain = isRenderResultPlainObject(renderResult);
            return {
                renderedText: isRenderResultPlain ? renderResult.value : renderResult,
                renderedEl: isRenderResultPlain ? renderResult.label : renderResult
            };
        };
        _this.state = {
            mounted: false
        };
        return _this;
    }

    (0, _createClass3['default'])(TransferList, [{
        key: 'componentDidMount',
        value: function componentDidMount() {
            var _this2 = this;

            this.timer = setTimeout(function () {
                _this2.setState({
                    mounted: true
                });
            }, 0);
        }
    }, {
        key: 'componentWillUnmount',
        value: function componentWillUnmount() {
            clearTimeout(this.timer);
            clearTimeout(this.triggerScrollTimer);
        }
    }, {
        key: 'shouldComponentUpdate',
        value: function shouldComponentUpdate() {
            for (var _len = arguments.length, args = Array(_len), _key = 0; _key < _len; _key++) {
                args[_key] = arguments[_key];
            }

            return _PureRenderMixin2['default'].shouldComponentUpdate.apply(this, args);
        }
    }, {
        key: 'getCheckStatus',
        value: function getCheckStatus(filteredDataSource) {
            var checkedKeys = this.props.checkedKeys;

            if (checkedKeys.length === 0) {
                return 'none';
            } else if (filteredDataSource.every(function (item) {
                return checkedKeys.indexOf(item.key) >= 0;
            })) {
                return 'all';
            }
            return 'part';
        }
    }, {
        key: 'render',
        value: function render() {
            var _this3 = this;

            var _props = this.props,
                prefixCls = _props.prefixCls,
                dataSource = _props.dataSource,
                titleText = _props.titleText,
                checkedKeys = _props.checkedKeys,
                lazy = _props.lazy,
                _props$body = _props.body,
                body = _props$body === undefined ? noop : _props$body,
                _props$footer = _props.footer,
                footer = _props$footer === undefined ? noop : _props$footer,
                showSearch = _props.showSearch,
                style = _props.style,
                filter = _props.filter,
                searchPlaceholder = _props.searchPlaceholder,
                notFoundContent = _props.notFoundContent,
                itemUnit = _props.itemUnit,
                itemsUnit = _props.itemsUnit,
                onScroll = _props.onScroll;
            // Custom Layout

            var footerDom = footer((0, _extends3['default'])({}, this.props));
            var bodyDom = body((0, _extends3['default'])({}, this.props));
            var listCls = (0, _classnames2['default'])(prefixCls, (0, _defineProperty3['default'])({}, prefixCls + '-with-footer', !!footerDom));
            var filteredDataSource = [];
            var totalDataSource = [];
            var showItems = dataSource.map(function (item) {
                var _renderItem = _this3.renderItem(item),
                    renderedText = _renderItem.renderedText,
                    renderedEl = _renderItem.renderedEl;

                if (filter && filter.trim() && !_this3.matchFilter(renderedText, item)) {
                    return null;
                }
                // all show items
                totalDataSource.push(item);
                if (!item.disabled) {
                    // response to checkAll items
                    filteredDataSource.push(item);
                }
                var checked = checkedKeys.indexOf(item.key) >= 0;
                return _react2['default'].createElement(_item2['default'], { key: item.key, item: item, lazy: lazy, renderedText: renderedText, renderedEl: renderedEl, checked: checked, prefixCls: prefixCls, onClick: _this3.handleSelect });
            });
            var unit = dataSource.length > 1 ? itemsUnit : itemUnit;
            var search = showSearch ? _react2['default'].createElement(
                'div',
                { className: prefixCls + '-body-search-wrapper' },
                _react2['default'].createElement(_search2['default'], { prefixCls: prefixCls + '-search', onChange: this.handleFilter, handleClear: this.handleClear, placeholder: searchPlaceholder, value: filter })
            ) : null;
            var listBody = bodyDom || _react2['default'].createElement(
                'div',
                { className: showSearch ? prefixCls + '-body ' + prefixCls + '-body-with-search' : prefixCls + '-body' },
                search,
                _react2['default'].createElement(
                    _rcAnimate2['default'],
                    { component: 'ul', componentProps: { onScroll: onScroll }, className: prefixCls + '-content', transitionName: this.state.mounted ? prefixCls + '-content-item-highlight' : '', transitionLeave: false },
                    showItems
                ),
                _react2['default'].createElement(
                    'div',
                    { className: prefixCls + '-body-not-found' },
                    notFoundContent
                )
            );
            var listFooter = footerDom ? _react2['default'].createElement(
                'div',
                { className: prefixCls + '-footer' },
                footerDom
            ) : null;
            var checkStatus = this.getCheckStatus(filteredDataSource);
            var checkedAll = checkStatus === 'all';
            var checkAllCheckbox = _react2['default'].createElement(_checkbox2['default'], { ref: 'checkbox', checked: checkedAll, indeterminate: checkStatus === 'part', onChange: function onChange() {
                    return _this3.props.handleSelectAll(filteredDataSource, checkedAll);
                } });
            return _react2['default'].createElement(
                'div',
                { className: listCls, style: style },
                _react2['default'].createElement(
                    'div',
                    { className: prefixCls + '-header' },
                    checkAllCheckbox,
                    _react2['default'].createElement(
                        'span',
                        { className: prefixCls + '-header-selected' },
                        _react2['default'].createElement(
                            'span',
                            null,
                            (checkedKeys.length > 0 ? checkedKeys.length + '/' : '') + totalDataSource.length,
                            ' ',
                            unit
                        ),
                        _react2['default'].createElement(
                            'span',
                            { className: prefixCls + '-header-title' },
                            titleText
                        )
                    )
                ),
                listBody,
                listFooter
            );
        }
    }]);
    return TransferList;
}(_react2['default'].Component);

exports['default'] = TransferList;

TransferList.defaultProps = {
    dataSource: [],
    titleText: '',
    showSearch: false,
    render: noop,
    lazy: {}
};
module.exports = exports['default'];

/***/ }),

/***/ 571:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
    value: true
});

var _classCallCheck2 = __webpack_require__(4);

var _classCallCheck3 = _interopRequireDefault(_classCallCheck2);

var _createClass2 = __webpack_require__(7);

var _createClass3 = _interopRequireDefault(_createClass2);

var _possibleConstructorReturn2 = __webpack_require__(6);

var _possibleConstructorReturn3 = _interopRequireDefault(_possibleConstructorReturn2);

var _inherits2 = __webpack_require__(5);

var _inherits3 = _interopRequireDefault(_inherits2);

var _react = __webpack_require__(0);

var _react2 = _interopRequireDefault(_react);

var _button = __webpack_require__(18);

var _button2 = _interopRequireDefault(_button);

var _icon = __webpack_require__(42);

var _icon2 = _interopRequireDefault(_icon);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

function noop() {}

var TransferOperation = function (_React$Component) {
    (0, _inherits3['default'])(TransferOperation, _React$Component);

    function TransferOperation() {
        (0, _classCallCheck3['default'])(this, TransferOperation);
        return (0, _possibleConstructorReturn3['default'])(this, (TransferOperation.__proto__ || Object.getPrototypeOf(TransferOperation)).apply(this, arguments));
    }

    (0, _createClass3['default'])(TransferOperation, [{
        key: 'render',
        value: function render() {
            var _props = this.props,
                moveToLeft = _props.moveToLeft,
                moveToRight = _props.moveToRight,
                leftArrowText = _props.leftArrowText,
                rightArrowText = _props.rightArrowText,
                leftActive = _props.leftActive,
                rightActive = _props.rightActive,
                className = _props.className;

            var moveToLeftButton = _react2['default'].createElement(
                _button2['default'],
                { type: 'primary', size: 'small', disabled: !leftActive, onClick: moveToLeft },
                _react2['default'].createElement(
                    'span',
                    null,
                    _react2['default'].createElement(_icon2['default'], { type: 'left' }),
                    leftArrowText
                )
            );
            var moveToRightButton = _react2['default'].createElement(
                _button2['default'],
                { type: 'primary', size: 'small', disabled: !rightActive, onClick: moveToRight },
                _react2['default'].createElement(
                    'span',
                    null,
                    rightArrowText,
                    _react2['default'].createElement(_icon2['default'], { type: 'right' })
                )
            );
            return _react2['default'].createElement(
                'div',
                { className: className },
                moveToLeftButton,
                moveToRightButton
            );
        }
    }]);
    return TransferOperation;
}(_react2['default'].Component);

exports['default'] = TransferOperation;

TransferOperation.defaultProps = {
    leftArrowText: '',
    rightArrowText: '',
    moveToLeft: noop,
    moveToRight: noop
};
module.exports = exports['default'];

/***/ }),

/***/ 572:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


__webpack_require__(26);

__webpack_require__(1038);

__webpack_require__(244);

__webpack_require__(22);

__webpack_require__(23);

/***/ }),

/***/ 601:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


__webpack_require__(493);
__webpack_require__(495);
__webpack_require__(119);
__webpack_require__(497);
__webpack_require__(492);
__webpack_require__(494);
__webpack_require__(496);
__webpack_require__(498);

/***/ }),

/***/ 666:
/***/ (function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_RESULT__;(function(root,factory){
    if (true) {
        !(__WEBPACK_AMD_DEFINE_FACTORY__ = (factory),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.call(exports, __webpack_require__, exports, module)) :
				__WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
    } else if (typeof exports === 'object') {
        module.exports = factory();
    } else {
        root.eventListener = factory();
  }
}(this, function () {
	function wrap(standard, fallback) {
		return function (el, evtName, listener, useCapture) {
			if (el[standard]) {
				el[standard](evtName, listener, useCapture);
			} else if (el[fallback]) {
				el[fallback]('on' + evtName, listener);
			}
		}
	}

    return {
		add: wrap('addEventListener', 'attachEvent'),
		remove: wrap('removeEventListener', 'detachEvent')
	};
}));

/***/ }),

/***/ 691:
/***/ (function(module, exports, __webpack_require__) {

/* WEBPACK VAR INJECTION */(function(global) {/**
 * lodash (Custom Build) <https://lodash.com/>
 * Build: `lodash modularize exports="npm" -o ./`
 * Copyright jQuery Foundation and other contributors <https://jquery.org/>
 * Released under MIT license <https://lodash.com/license>
 * Based on Underscore.js 1.8.3 <http://underscorejs.org/LICENSE>
 * Copyright Jeremy Ashkenas, DocumentCloud and Investigative Reporters & Editors
 */

/** Used as the `TypeError` message for "Functions" methods. */
var FUNC_ERROR_TEXT = 'Expected a function';

/** Used as references for various `Number` constants. */
var NAN = 0 / 0;

/** `Object#toString` result references. */
var symbolTag = '[object Symbol]';

/** Used to match leading and trailing whitespace. */
var reTrim = /^\s+|\s+$/g;

/** Used to detect bad signed hexadecimal string values. */
var reIsBadHex = /^[-+]0x[0-9a-f]+$/i;

/** Used to detect binary string values. */
var reIsBinary = /^0b[01]+$/i;

/** Used to detect octal string values. */
var reIsOctal = /^0o[0-7]+$/i;

/** Built-in method references without a dependency on `root`. */
var freeParseInt = parseInt;

/** Detect free variable `global` from Node.js. */
var freeGlobal = typeof global == 'object' && global && global.Object === Object && global;

/** Detect free variable `self`. */
var freeSelf = typeof self == 'object' && self && self.Object === Object && self;

/** Used as a reference to the global object. */
var root = freeGlobal || freeSelf || Function('return this')();

/** Used for built-in method references. */
var objectProto = Object.prototype;

/**
 * Used to resolve the
 * [`toStringTag`](http://ecma-international.org/ecma-262/7.0/#sec-object.prototype.tostring)
 * of values.
 */
var objectToString = objectProto.toString;

/* Built-in method references for those with the same name as other `lodash` methods. */
var nativeMax = Math.max,
    nativeMin = Math.min;

/**
 * Gets the timestamp of the number of milliseconds that have elapsed since
 * the Unix epoch (1 January 1970 00:00:00 UTC).
 *
 * @static
 * @memberOf _
 * @since 2.4.0
 * @category Date
 * @returns {number} Returns the timestamp.
 * @example
 *
 * _.defer(function(stamp) {
 *   console.log(_.now() - stamp);
 * }, _.now());
 * // => Logs the number of milliseconds it took for the deferred invocation.
 */
var now = function() {
  return root.Date.now();
};

/**
 * Creates a debounced function that delays invoking `func` until after `wait`
 * milliseconds have elapsed since the last time the debounced function was
 * invoked. The debounced function comes with a `cancel` method to cancel
 * delayed `func` invocations and a `flush` method to immediately invoke them.
 * Provide `options` to indicate whether `func` should be invoked on the
 * leading and/or trailing edge of the `wait` timeout. The `func` is invoked
 * with the last arguments provided to the debounced function. Subsequent
 * calls to the debounced function return the result of the last `func`
 * invocation.
 *
 * **Note:** If `leading` and `trailing` options are `true`, `func` is
 * invoked on the trailing edge of the timeout only if the debounced function
 * is invoked more than once during the `wait` timeout.
 *
 * If `wait` is `0` and `leading` is `false`, `func` invocation is deferred
 * until to the next tick, similar to `setTimeout` with a timeout of `0`.
 *
 * See [David Corbacho's article](https://css-tricks.com/debouncing-throttling-explained-examples/)
 * for details over the differences between `_.debounce` and `_.throttle`.
 *
 * @static
 * @memberOf _
 * @since 0.1.0
 * @category Function
 * @param {Function} func The function to debounce.
 * @param {number} [wait=0] The number of milliseconds to delay.
 * @param {Object} [options={}] The options object.
 * @param {boolean} [options.leading=false]
 *  Specify invoking on the leading edge of the timeout.
 * @param {number} [options.maxWait]
 *  The maximum time `func` is allowed to be delayed before it's invoked.
 * @param {boolean} [options.trailing=true]
 *  Specify invoking on the trailing edge of the timeout.
 * @returns {Function} Returns the new debounced function.
 * @example
 *
 * // Avoid costly calculations while the window size is in flux.
 * jQuery(window).on('resize', _.debounce(calculateLayout, 150));
 *
 * // Invoke `sendMail` when clicked, debouncing subsequent calls.
 * jQuery(element).on('click', _.debounce(sendMail, 300, {
 *   'leading': true,
 *   'trailing': false
 * }));
 *
 * // Ensure `batchLog` is invoked once after 1 second of debounced calls.
 * var debounced = _.debounce(batchLog, 250, { 'maxWait': 1000 });
 * var source = new EventSource('/stream');
 * jQuery(source).on('message', debounced);
 *
 * // Cancel the trailing debounced invocation.
 * jQuery(window).on('popstate', debounced.cancel);
 */
function debounce(func, wait, options) {
  var lastArgs,
      lastThis,
      maxWait,
      result,
      timerId,
      lastCallTime,
      lastInvokeTime = 0,
      leading = false,
      maxing = false,
      trailing = true;

  if (typeof func != 'function') {
    throw new TypeError(FUNC_ERROR_TEXT);
  }
  wait = toNumber(wait) || 0;
  if (isObject(options)) {
    leading = !!options.leading;
    maxing = 'maxWait' in options;
    maxWait = maxing ? nativeMax(toNumber(options.maxWait) || 0, wait) : maxWait;
    trailing = 'trailing' in options ? !!options.trailing : trailing;
  }

  function invokeFunc(time) {
    var args = lastArgs,
        thisArg = lastThis;

    lastArgs = lastThis = undefined;
    lastInvokeTime = time;
    result = func.apply(thisArg, args);
    return result;
  }

  function leadingEdge(time) {
    // Reset any `maxWait` timer.
    lastInvokeTime = time;
    // Start the timer for the trailing edge.
    timerId = setTimeout(timerExpired, wait);
    // Invoke the leading edge.
    return leading ? invokeFunc(time) : result;
  }

  function remainingWait(time) {
    var timeSinceLastCall = time - lastCallTime,
        timeSinceLastInvoke = time - lastInvokeTime,
        result = wait - timeSinceLastCall;

    return maxing ? nativeMin(result, maxWait - timeSinceLastInvoke) : result;
  }

  function shouldInvoke(time) {
    var timeSinceLastCall = time - lastCallTime,
        timeSinceLastInvoke = time - lastInvokeTime;

    // Either this is the first call, activity has stopped and we're at the
    // trailing edge, the system time has gone backwards and we're treating
    // it as the trailing edge, or we've hit the `maxWait` limit.
    return (lastCallTime === undefined || (timeSinceLastCall >= wait) ||
      (timeSinceLastCall < 0) || (maxing && timeSinceLastInvoke >= maxWait));
  }

  function timerExpired() {
    var time = now();
    if (shouldInvoke(time)) {
      return trailingEdge(time);
    }
    // Restart the timer.
    timerId = setTimeout(timerExpired, remainingWait(time));
  }

  function trailingEdge(time) {
    timerId = undefined;

    // Only invoke if we have `lastArgs` which means `func` has been
    // debounced at least once.
    if (trailing && lastArgs) {
      return invokeFunc(time);
    }
    lastArgs = lastThis = undefined;
    return result;
  }

  function cancel() {
    if (timerId !== undefined) {
      clearTimeout(timerId);
    }
    lastInvokeTime = 0;
    lastArgs = lastCallTime = lastThis = timerId = undefined;
  }

  function flush() {
    return timerId === undefined ? result : trailingEdge(now());
  }

  function debounced() {
    var time = now(),
        isInvoking = shouldInvoke(time);

    lastArgs = arguments;
    lastThis = this;
    lastCallTime = time;

    if (isInvoking) {
      if (timerId === undefined) {
        return leadingEdge(lastCallTime);
      }
      if (maxing) {
        // Handle invocations in a tight loop.
        timerId = setTimeout(timerExpired, wait);
        return invokeFunc(lastCallTime);
      }
    }
    if (timerId === undefined) {
      timerId = setTimeout(timerExpired, wait);
    }
    return result;
  }
  debounced.cancel = cancel;
  debounced.flush = flush;
  return debounced;
}

/**
 * Checks if `value` is the
 * [language type](http://www.ecma-international.org/ecma-262/7.0/#sec-ecmascript-language-types)
 * of `Object`. (e.g. arrays, functions, objects, regexes, `new Number(0)`, and `new String('')`)
 *
 * @static
 * @memberOf _
 * @since 0.1.0
 * @category Lang
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is an object, else `false`.
 * @example
 *
 * _.isObject({});
 * // => true
 *
 * _.isObject([1, 2, 3]);
 * // => true
 *
 * _.isObject(_.noop);
 * // => true
 *
 * _.isObject(null);
 * // => false
 */
function isObject(value) {
  var type = typeof value;
  return !!value && (type == 'object' || type == 'function');
}

/**
 * Checks if `value` is object-like. A value is object-like if it's not `null`
 * and has a `typeof` result of "object".
 *
 * @static
 * @memberOf _
 * @since 4.0.0
 * @category Lang
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is object-like, else `false`.
 * @example
 *
 * _.isObjectLike({});
 * // => true
 *
 * _.isObjectLike([1, 2, 3]);
 * // => true
 *
 * _.isObjectLike(_.noop);
 * // => false
 *
 * _.isObjectLike(null);
 * // => false
 */
function isObjectLike(value) {
  return !!value && typeof value == 'object';
}

/**
 * Checks if `value` is classified as a `Symbol` primitive or object.
 *
 * @static
 * @memberOf _
 * @since 4.0.0
 * @category Lang
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is a symbol, else `false`.
 * @example
 *
 * _.isSymbol(Symbol.iterator);
 * // => true
 *
 * _.isSymbol('abc');
 * // => false
 */
function isSymbol(value) {
  return typeof value == 'symbol' ||
    (isObjectLike(value) && objectToString.call(value) == symbolTag);
}

/**
 * Converts `value` to a number.
 *
 * @static
 * @memberOf _
 * @since 4.0.0
 * @category Lang
 * @param {*} value The value to process.
 * @returns {number} Returns the number.
 * @example
 *
 * _.toNumber(3.2);
 * // => 3.2
 *
 * _.toNumber(Number.MIN_VALUE);
 * // => 5e-324
 *
 * _.toNumber(Infinity);
 * // => Infinity
 *
 * _.toNumber('3.2');
 * // => 3.2
 */
function toNumber(value) {
  if (typeof value == 'number') {
    return value;
  }
  if (isSymbol(value)) {
    return NAN;
  }
  if (isObject(value)) {
    var other = typeof value.valueOf == 'function' ? value.valueOf() : value;
    value = isObject(other) ? (other + '') : other;
  }
  if (typeof value != 'string') {
    return value === 0 ? value : +value;
  }
  value = value.replace(reTrim, '');
  var isBinary = reIsBinary.test(value);
  return (isBinary || reIsOctal.test(value))
    ? freeParseInt(value.slice(2), isBinary ? 2 : 8)
    : (reIsBadHex.test(value) ? NAN : +value);
}

module.exports = debounce;

/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(53)))

/***/ }),

/***/ 696:
/***/ (function(module, exports, __webpack_require__) {

/* WEBPACK VAR INJECTION */(function(global) {/**
 * lodash (Custom Build) <https://lodash.com/>
 * Build: `lodash modularize exports="npm" -o ./`
 * Copyright jQuery Foundation and other contributors <https://jquery.org/>
 * Released under MIT license <https://lodash.com/license>
 * Based on Underscore.js 1.8.3 <http://underscorejs.org/LICENSE>
 * Copyright Jeremy Ashkenas, DocumentCloud and Investigative Reporters & Editors
 */

/** Used as the `TypeError` message for "Functions" methods. */
var FUNC_ERROR_TEXT = 'Expected a function';

/** Used as references for various `Number` constants. */
var NAN = 0 / 0;

/** `Object#toString` result references. */
var symbolTag = '[object Symbol]';

/** Used to match leading and trailing whitespace. */
var reTrim = /^\s+|\s+$/g;

/** Used to detect bad signed hexadecimal string values. */
var reIsBadHex = /^[-+]0x[0-9a-f]+$/i;

/** Used to detect binary string values. */
var reIsBinary = /^0b[01]+$/i;

/** Used to detect octal string values. */
var reIsOctal = /^0o[0-7]+$/i;

/** Built-in method references without a dependency on `root`. */
var freeParseInt = parseInt;

/** Detect free variable `global` from Node.js. */
var freeGlobal = typeof global == 'object' && global && global.Object === Object && global;

/** Detect free variable `self`. */
var freeSelf = typeof self == 'object' && self && self.Object === Object && self;

/** Used as a reference to the global object. */
var root = freeGlobal || freeSelf || Function('return this')();

/** Used for built-in method references. */
var objectProto = Object.prototype;

/**
 * Used to resolve the
 * [`toStringTag`](http://ecma-international.org/ecma-262/7.0/#sec-object.prototype.tostring)
 * of values.
 */
var objectToString = objectProto.toString;

/* Built-in method references for those with the same name as other `lodash` methods. */
var nativeMax = Math.max,
    nativeMin = Math.min;

/**
 * Gets the timestamp of the number of milliseconds that have elapsed since
 * the Unix epoch (1 January 1970 00:00:00 UTC).
 *
 * @static
 * @memberOf _
 * @since 2.4.0
 * @category Date
 * @returns {number} Returns the timestamp.
 * @example
 *
 * _.defer(function(stamp) {
 *   console.log(_.now() - stamp);
 * }, _.now());
 * // => Logs the number of milliseconds it took for the deferred invocation.
 */
var now = function() {
  return root.Date.now();
};

/**
 * Creates a debounced function that delays invoking `func` until after `wait`
 * milliseconds have elapsed since the last time the debounced function was
 * invoked. The debounced function comes with a `cancel` method to cancel
 * delayed `func` invocations and a `flush` method to immediately invoke them.
 * Provide `options` to indicate whether `func` should be invoked on the
 * leading and/or trailing edge of the `wait` timeout. The `func` is invoked
 * with the last arguments provided to the debounced function. Subsequent
 * calls to the debounced function return the result of the last `func`
 * invocation.
 *
 * **Note:** If `leading` and `trailing` options are `true`, `func` is
 * invoked on the trailing edge of the timeout only if the debounced function
 * is invoked more than once during the `wait` timeout.
 *
 * If `wait` is `0` and `leading` is `false`, `func` invocation is deferred
 * until to the next tick, similar to `setTimeout` with a timeout of `0`.
 *
 * See [David Corbacho's article](https://css-tricks.com/debouncing-throttling-explained-examples/)
 * for details over the differences between `_.debounce` and `_.throttle`.
 *
 * @static
 * @memberOf _
 * @since 0.1.0
 * @category Function
 * @param {Function} func The function to debounce.
 * @param {number} [wait=0] The number of milliseconds to delay.
 * @param {Object} [options={}] The options object.
 * @param {boolean} [options.leading=false]
 *  Specify invoking on the leading edge of the timeout.
 * @param {number} [options.maxWait]
 *  The maximum time `func` is allowed to be delayed before it's invoked.
 * @param {boolean} [options.trailing=true]
 *  Specify invoking on the trailing edge of the timeout.
 * @returns {Function} Returns the new debounced function.
 * @example
 *
 * // Avoid costly calculations while the window size is in flux.
 * jQuery(window).on('resize', _.debounce(calculateLayout, 150));
 *
 * // Invoke `sendMail` when clicked, debouncing subsequent calls.
 * jQuery(element).on('click', _.debounce(sendMail, 300, {
 *   'leading': true,
 *   'trailing': false
 * }));
 *
 * // Ensure `batchLog` is invoked once after 1 second of debounced calls.
 * var debounced = _.debounce(batchLog, 250, { 'maxWait': 1000 });
 * var source = new EventSource('/stream');
 * jQuery(source).on('message', debounced);
 *
 * // Cancel the trailing debounced invocation.
 * jQuery(window).on('popstate', debounced.cancel);
 */
function debounce(func, wait, options) {
  var lastArgs,
      lastThis,
      maxWait,
      result,
      timerId,
      lastCallTime,
      lastInvokeTime = 0,
      leading = false,
      maxing = false,
      trailing = true;

  if (typeof func != 'function') {
    throw new TypeError(FUNC_ERROR_TEXT);
  }
  wait = toNumber(wait) || 0;
  if (isObject(options)) {
    leading = !!options.leading;
    maxing = 'maxWait' in options;
    maxWait = maxing ? nativeMax(toNumber(options.maxWait) || 0, wait) : maxWait;
    trailing = 'trailing' in options ? !!options.trailing : trailing;
  }

  function invokeFunc(time) {
    var args = lastArgs,
        thisArg = lastThis;

    lastArgs = lastThis = undefined;
    lastInvokeTime = time;
    result = func.apply(thisArg, args);
    return result;
  }

  function leadingEdge(time) {
    // Reset any `maxWait` timer.
    lastInvokeTime = time;
    // Start the timer for the trailing edge.
    timerId = setTimeout(timerExpired, wait);
    // Invoke the leading edge.
    return leading ? invokeFunc(time) : result;
  }

  function remainingWait(time) {
    var timeSinceLastCall = time - lastCallTime,
        timeSinceLastInvoke = time - lastInvokeTime,
        result = wait - timeSinceLastCall;

    return maxing ? nativeMin(result, maxWait - timeSinceLastInvoke) : result;
  }

  function shouldInvoke(time) {
    var timeSinceLastCall = time - lastCallTime,
        timeSinceLastInvoke = time - lastInvokeTime;

    // Either this is the first call, activity has stopped and we're at the
    // trailing edge, the system time has gone backwards and we're treating
    // it as the trailing edge, or we've hit the `maxWait` limit.
    return (lastCallTime === undefined || (timeSinceLastCall >= wait) ||
      (timeSinceLastCall < 0) || (maxing && timeSinceLastInvoke >= maxWait));
  }

  function timerExpired() {
    var time = now();
    if (shouldInvoke(time)) {
      return trailingEdge(time);
    }
    // Restart the timer.
    timerId = setTimeout(timerExpired, remainingWait(time));
  }

  function trailingEdge(time) {
    timerId = undefined;

    // Only invoke if we have `lastArgs` which means `func` has been
    // debounced at least once.
    if (trailing && lastArgs) {
      return invokeFunc(time);
    }
    lastArgs = lastThis = undefined;
    return result;
  }

  function cancel() {
    if (timerId !== undefined) {
      clearTimeout(timerId);
    }
    lastInvokeTime = 0;
    lastArgs = lastCallTime = lastThis = timerId = undefined;
  }

  function flush() {
    return timerId === undefined ? result : trailingEdge(now());
  }

  function debounced() {
    var time = now(),
        isInvoking = shouldInvoke(time);

    lastArgs = arguments;
    lastThis = this;
    lastCallTime = time;

    if (isInvoking) {
      if (timerId === undefined) {
        return leadingEdge(lastCallTime);
      }
      if (maxing) {
        // Handle invocations in a tight loop.
        timerId = setTimeout(timerExpired, wait);
        return invokeFunc(lastCallTime);
      }
    }
    if (timerId === undefined) {
      timerId = setTimeout(timerExpired, wait);
    }
    return result;
  }
  debounced.cancel = cancel;
  debounced.flush = flush;
  return debounced;
}

/**
 * Creates a throttled function that only invokes `func` at most once per
 * every `wait` milliseconds. The throttled function comes with a `cancel`
 * method to cancel delayed `func` invocations and a `flush` method to
 * immediately invoke them. Provide `options` to indicate whether `func`
 * should be invoked on the leading and/or trailing edge of the `wait`
 * timeout. The `func` is invoked with the last arguments provided to the
 * throttled function. Subsequent calls to the throttled function return the
 * result of the last `func` invocation.
 *
 * **Note:** If `leading` and `trailing` options are `true`, `func` is
 * invoked on the trailing edge of the timeout only if the throttled function
 * is invoked more than once during the `wait` timeout.
 *
 * If `wait` is `0` and `leading` is `false`, `func` invocation is deferred
 * until to the next tick, similar to `setTimeout` with a timeout of `0`.
 *
 * See [David Corbacho's article](https://css-tricks.com/debouncing-throttling-explained-examples/)
 * for details over the differences between `_.throttle` and `_.debounce`.
 *
 * @static
 * @memberOf _
 * @since 0.1.0
 * @category Function
 * @param {Function} func The function to throttle.
 * @param {number} [wait=0] The number of milliseconds to throttle invocations to.
 * @param {Object} [options={}] The options object.
 * @param {boolean} [options.leading=true]
 *  Specify invoking on the leading edge of the timeout.
 * @param {boolean} [options.trailing=true]
 *  Specify invoking on the trailing edge of the timeout.
 * @returns {Function} Returns the new throttled function.
 * @example
 *
 * // Avoid excessively updating the position while scrolling.
 * jQuery(window).on('scroll', _.throttle(updatePosition, 100));
 *
 * // Invoke `renewToken` when the click event is fired, but not more than once every 5 minutes.
 * var throttled = _.throttle(renewToken, 300000, { 'trailing': false });
 * jQuery(element).on('click', throttled);
 *
 * // Cancel the trailing throttled invocation.
 * jQuery(window).on('popstate', throttled.cancel);
 */
function throttle(func, wait, options) {
  var leading = true,
      trailing = true;

  if (typeof func != 'function') {
    throw new TypeError(FUNC_ERROR_TEXT);
  }
  if (isObject(options)) {
    leading = 'leading' in options ? !!options.leading : leading;
    trailing = 'trailing' in options ? !!options.trailing : trailing;
  }
  return debounce(func, wait, {
    'leading': leading,
    'maxWait': wait,
    'trailing': trailing
  });
}

/**
 * Checks if `value` is the
 * [language type](http://www.ecma-international.org/ecma-262/7.0/#sec-ecmascript-language-types)
 * of `Object`. (e.g. arrays, functions, objects, regexes, `new Number(0)`, and `new String('')`)
 *
 * @static
 * @memberOf _
 * @since 0.1.0
 * @category Lang
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is an object, else `false`.
 * @example
 *
 * _.isObject({});
 * // => true
 *
 * _.isObject([1, 2, 3]);
 * // => true
 *
 * _.isObject(_.noop);
 * // => true
 *
 * _.isObject(null);
 * // => false
 */
function isObject(value) {
  var type = typeof value;
  return !!value && (type == 'object' || type == 'function');
}

/**
 * Checks if `value` is object-like. A value is object-like if it's not `null`
 * and has a `typeof` result of "object".
 *
 * @static
 * @memberOf _
 * @since 4.0.0
 * @category Lang
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is object-like, else `false`.
 * @example
 *
 * _.isObjectLike({});
 * // => true
 *
 * _.isObjectLike([1, 2, 3]);
 * // => true
 *
 * _.isObjectLike(_.noop);
 * // => false
 *
 * _.isObjectLike(null);
 * // => false
 */
function isObjectLike(value) {
  return !!value && typeof value == 'object';
}

/**
 * Checks if `value` is classified as a `Symbol` primitive or object.
 *
 * @static
 * @memberOf _
 * @since 4.0.0
 * @category Lang
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is a symbol, else `false`.
 * @example
 *
 * _.isSymbol(Symbol.iterator);
 * // => true
 *
 * _.isSymbol('abc');
 * // => false
 */
function isSymbol(value) {
  return typeof value == 'symbol' ||
    (isObjectLike(value) && objectToString.call(value) == symbolTag);
}

/**
 * Converts `value` to a number.
 *
 * @static
 * @memberOf _
 * @since 4.0.0
 * @category Lang
 * @param {*} value The value to process.
 * @returns {number} Returns the number.
 * @example
 *
 * _.toNumber(3.2);
 * // => 3.2
 *
 * _.toNumber(Number.MIN_VALUE);
 * // => 5e-324
 *
 * _.toNumber(Infinity);
 * // => Infinity
 *
 * _.toNumber('3.2');
 * // => 3.2
 */
function toNumber(value) {
  if (typeof value == 'number') {
    return value;
  }
  if (isSymbol(value)) {
    return NAN;
  }
  if (isObject(value)) {
    var other = typeof value.valueOf == 'function' ? value.valueOf() : value;
    value = isObject(other) ? (other + '') : other;
  }
  if (typeof value != 'string') {
    return value === 0 ? value : +value;
  }
  value = value.replace(reTrim, '');
  var isBinary = reIsBinary.test(value);
  return (isBinary || reIsOctal.test(value))
    ? freeParseInt(value.slice(2), isBinary ? 2 : 8)
    : (reIsBadHex.test(value) ? NAN : +value);
}

module.exports = throttle;

/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(53)))

/***/ }),

/***/ 834:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
  value: true
});

var _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };

var _react = __webpack_require__(0);

var _react2 = _interopRequireDefault(_react);

var _propTypes = __webpack_require__(2);

var _propTypes2 = _interopRequireDefault(_propTypes);

var _rcTrigger = __webpack_require__(94);

var _rcTrigger2 = _interopRequireDefault(_rcTrigger);

var _Menus = __webpack_require__(835);

var _Menus2 = _interopRequireDefault(_Menus);

var _KeyCode = __webpack_require__(49);

var _KeyCode2 = _interopRequireDefault(_KeyCode);

var _arrayTreeFilter = __webpack_require__(154);

var _arrayTreeFilter2 = _interopRequireDefault(_arrayTreeFilter);

var _arrays = __webpack_require__(1016);

var _arrays2 = _interopRequireDefault(_arrays);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

function _defaults(obj, defaults) { var keys = Object.getOwnPropertyNames(defaults); for (var i = 0; i < keys.length; i++) { var key = keys[i]; var value = Object.getOwnPropertyDescriptor(defaults, key); if (value && value.configurable && obj[key] === undefined) { Object.defineProperty(obj, key, value); } } return obj; }

function _objectWithoutProperties(obj, keys) { var target = {}; for (var i in obj) { if (keys.indexOf(i) >= 0) continue; if (!Object.prototype.hasOwnProperty.call(obj, i)) continue; target[i] = obj[i]; } return target; }

function _toConsumableArray(arr) { if (Array.isArray(arr)) { for (var i = 0, arr2 = Array(arr.length); i < arr.length; i++) { arr2[i] = arr[i]; } return arr2; } else { return Array.from(arr); } }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : _defaults(subClass, superClass); }

var BUILT_IN_PLACEMENTS = {
  bottomLeft: {
    points: ['tl', 'bl'],
    offset: [0, 4],
    overflow: {
      adjustX: 1,
      adjustY: 1
    }
  },
  topLeft: {
    points: ['bl', 'tl'],
    offset: [0, -4],
    overflow: {
      adjustX: 1,
      adjustY: 1
    }
  },
  bottomRight: {
    points: ['tr', 'br'],
    offset: [0, 4],
    overflow: {
      adjustX: 1,
      adjustY: 1
    }
  },
  topRight: {
    points: ['br', 'tr'],
    offset: [0, -4],
    overflow: {
      adjustX: 1,
      adjustY: 1
    }
  }
};

var Cascader = function (_Component) {
  _inherits(Cascader, _Component);

  function Cascader(props) {
    _classCallCheck(this, Cascader);

    var _this = _possibleConstructorReturn(this, _Component.call(this, props));

    _this.setPopupVisible = function (popupVisible) {
      if (!('popupVisible' in _this.props)) {
        _this.setState({ popupVisible: popupVisible });
      }
      // sync activeValue with value when panel open
      if (popupVisible && !_this.state.visible) {
        _this.setState({
          activeValue: _this.state.value
        });
      }
      _this.props.onPopupVisibleChange(popupVisible);
    };

    _this.handleChange = function (options, setProps, e) {
      if (e.type !== 'keydown' || e.keyCode === _KeyCode2["default"].ENTER) {
        _this.props.onChange(options.map(function (o) {
          return o.value;
        }), options);
        _this.setPopupVisible(setProps.visible);
      }
    };

    _this.handlePopupVisibleChange = function (popupVisible) {
      _this.setPopupVisible(popupVisible);
    };

    _this.handleMenuSelect = function (targetOption, menuIndex, e) {
      if (e && e.preventDefault) {
        e.preventDefault();
      }
      // Keep focused state for keyboard support
      var triggerNode = _this.refs.trigger.getRootDomNode();
      if (triggerNode && triggerNode.focus) {
        triggerNode.focus();
      }
      var _this$props = _this.props,
          changeOnSelect = _this$props.changeOnSelect,
          loadData = _this$props.loadData,
          expandTrigger = _this$props.expandTrigger;

      if (!targetOption || targetOption.disabled) {
        return;
      }
      var activeValue = _this.state.activeValue;

      activeValue = activeValue.slice(0, menuIndex + 1);
      activeValue[menuIndex] = targetOption.value;
      var activeOptions = _this.getActiveOptions(activeValue);
      if (targetOption.isLeaf === false && !targetOption.children && loadData) {
        if (changeOnSelect) {
          _this.handleChange(activeOptions, { visible: true }, e);
        }
        _this.setState({ activeValue: activeValue });
        loadData(activeOptions);
        return;
      }
      var newState = {};
      if (!targetOption.children || !targetOption.children.length) {
        _this.handleChange(activeOptions, { visible: false }, e);
        // set value to activeValue when select leaf option
        newState.value = activeValue;
        // add e.type judgement to prevent `onChange` being triggered by mouseEnter
      } else if (changeOnSelect && (e.type === 'click' || e.type === 'keydown')) {
        if (expandTrigger === 'hover') {
          _this.handleChange(activeOptions, { visible: false }, e);
        } else {
          _this.handleChange(activeOptions, { visible: true }, e);
        }
        // set value to activeValue on every select
        newState.value = activeValue;
      }
      newState.activeValue = activeValue;
      //  not change the value by keyboard
      if ('value' in _this.props || e.type === 'keydown' && e.keyCode !== _KeyCode2["default"].ENTER) {
        delete newState.value;
      }
      _this.setState(newState);
    };

    _this.handleKeyDown = function (e) {
      var children = _this.props.children;
      // https://github.com/ant-design/ant-design/issues/6717
      // Don't bind keyboard support when children specify the onKeyDown

      if (children && children.props.onKeyDown) {
        children.props.onKeyDown(e);
        return;
      }
      var activeValue = [].concat(_toConsumableArray(_this.state.activeValue));
      var currentLevel = activeValue.length - 1 < 0 ? 0 : activeValue.length - 1;
      var currentOptions = _this.getCurrentLevelOptions();
      var currentIndex = currentOptions.map(function (o) {
        return o.value;
      }).indexOf(activeValue[currentLevel]);
      if (e.keyCode !== _KeyCode2["default"].DOWN && e.keyCode !== _KeyCode2["default"].UP && e.keyCode !== _KeyCode2["default"].LEFT && e.keyCode !== _KeyCode2["default"].RIGHT && e.keyCode !== _KeyCode2["default"].ENTER && e.keyCode !== _KeyCode2["default"].BACKSPACE && e.keyCode !== _KeyCode2["default"].ESC) {
        return;
      }
      // Press any keys above to reopen menu
      if (!_this.state.popupVisible && e.keyCode !== _KeyCode2["default"].BACKSPACE && e.keyCode !== _KeyCode2["default"].ESC) {
        _this.setPopupVisible(true);
        return;
      }
      if (e.keyCode === _KeyCode2["default"].DOWN || e.keyCode === _KeyCode2["default"].UP) {
        var nextIndex = currentIndex;
        if (nextIndex !== -1) {
          if (e.keyCode === _KeyCode2["default"].DOWN) {
            nextIndex += 1;
            nextIndex = nextIndex >= currentOptions.length ? 0 : nextIndex;
          } else {
            nextIndex -= 1;
            nextIndex = nextIndex < 0 ? currentOptions.length - 1 : nextIndex;
          }
        } else {
          nextIndex = 0;
        }
        activeValue[currentLevel] = currentOptions[nextIndex].value;
      } else if (e.keyCode === _KeyCode2["default"].LEFT || e.keyCode === _KeyCode2["default"].BACKSPACE) {
        activeValue.splice(activeValue.length - 1, 1);
      } else if (e.keyCode === _KeyCode2["default"].RIGHT) {
        if (currentOptions[currentIndex] && currentOptions[currentIndex].children) {
          activeValue.push(currentOptions[currentIndex].children[0].value);
        }
      } else if (e.keyCode === _KeyCode2["default"].ESC) {
        _this.setPopupVisible(false);
        return;
      }
      if (!activeValue || activeValue.length === 0) {
        _this.setPopupVisible(false);
      }
      var activeOptions = _this.getActiveOptions(activeValue);
      var targetOption = activeOptions[activeOptions.length - 1];
      _this.handleMenuSelect(targetOption, activeOptions.length - 1, e);

      if (_this.props.onKeyDown) {
        _this.props.onKeyDown(e);
      }
    };

    var initialValue = [];
    if ('value' in props) {
      initialValue = props.value || [];
    } else if ('defaultValue' in props) {
      initialValue = props.defaultValue || [];
    }

    _this.state = {
      popupVisible: props.popupVisible,
      activeValue: initialValue,
      value: initialValue
    };
    return _this;
  }

  Cascader.prototype.componentWillReceiveProps = function componentWillReceiveProps(nextProps) {
    if ('value' in nextProps && !(0, _arrays2["default"])(this.props.value, nextProps.value)) {
      var newValues = {
        value: nextProps.value || [],
        activeValue: nextProps.value || []
      };
      // allow activeValue diff from value
      // https://github.com/ant-design/ant-design/issues/2767
      if ('loadData' in nextProps) {
        delete newValues.activeValue;
      }
      this.setState(newValues);
    }
    if ('popupVisible' in nextProps) {
      this.setState({
        popupVisible: nextProps.popupVisible
      });
    }
  };

  Cascader.prototype.getPopupDOMNode = function getPopupDOMNode() {
    return this.refs.trigger.getPopupDomNode();
  };

  Cascader.prototype.getCurrentLevelOptions = function getCurrentLevelOptions() {
    var options = this.props.options;
    var _state$activeValue = this.state.activeValue,
        activeValue = _state$activeValue === undefined ? [] : _state$activeValue;

    var result = (0, _arrayTreeFilter2["default"])(options, function (o, level) {
      return o.value === activeValue[level];
    });
    if (result[result.length - 2]) {
      return result[result.length - 2].children;
    }
    return [].concat(_toConsumableArray(options)).filter(function (o) {
      return !o.disabled;
    });
  };

  Cascader.prototype.getActiveOptions = function getActiveOptions(activeValue) {
    return (0, _arrayTreeFilter2["default"])(this.props.options, function (o, level) {
      return o.value === activeValue[level];
    });
  };

  Cascader.prototype.render = function render() {
    var _props = this.props,
        prefixCls = _props.prefixCls,
        transitionName = _props.transitionName,
        popupClassName = _props.popupClassName,
        options = _props.options,
        disabled = _props.disabled,
        builtinPlacements = _props.builtinPlacements,
        popupPlacement = _props.popupPlacement,
        children = _props.children,
        restProps = _objectWithoutProperties(_props, ['prefixCls', 'transitionName', 'popupClassName', 'options', 'disabled', 'builtinPlacements', 'popupPlacement', 'children']);
    // Did not show popup when there is no options


    var menus = _react2["default"].createElement('div', null);
    var emptyMenuClassName = '';
    if (options && options.length > 0) {
      menus = _react2["default"].createElement(_Menus2["default"], _extends({}, this.props, {
        value: this.state.value,
        activeValue: this.state.activeValue,
        onSelect: this.handleMenuSelect,
        visible: this.state.popupVisible
      }));
    } else {
      emptyMenuClassName = ' ' + prefixCls + '-menus-empty';
    }
    return _react2["default"].createElement(
      _rcTrigger2["default"],
      _extends({
        ref: 'trigger'
      }, restProps, {
        options: options,
        disabled: disabled,
        popupPlacement: popupPlacement,
        builtinPlacements: builtinPlacements,
        popupTransitionName: transitionName,
        action: disabled ? [] : ['click'],
        popupVisible: disabled ? false : this.state.popupVisible,
        onPopupVisibleChange: this.handlePopupVisibleChange,
        prefixCls: prefixCls + '-menus',
        popupClassName: popupClassName + emptyMenuClassName,
        popup: menus
      }),
      (0, _react.cloneElement)(children, {
        onKeyDown: this.handleKeyDown,
        tabIndex: disabled ? undefined : 0
      })
    );
  };

  return Cascader;
}(_react.Component);

Cascader.defaultProps = {
  options: [],
  onChange: function onChange() {},
  onPopupVisibleChange: function onPopupVisibleChange() {},

  disabled: false,
  transitionName: '',
  prefixCls: 'rc-cascader',
  popupClassName: '',
  popupPlacement: 'bottomLeft',
  builtinPlacements: BUILT_IN_PLACEMENTS,
  expandTrigger: 'click'
};

Cascader.propTypes = {
  value: _propTypes2["default"].array,
  defaultValue: _propTypes2["default"].array,
  options: _propTypes2["default"].array.isRequired,
  onChange: _propTypes2["default"].func,
  onPopupVisibleChange: _propTypes2["default"].func,
  popupVisible: _propTypes2["default"].bool,
  disabled: _propTypes2["default"].bool,
  transitionName: _propTypes2["default"].string,
  popupClassName: _propTypes2["default"].string,
  popupPlacement: _propTypes2["default"].string,
  prefixCls: _propTypes2["default"].string,
  dropdownMenuColumnStyle: _propTypes2["default"].object,
  builtinPlacements: _propTypes2["default"].object,
  loadData: _propTypes2["default"].func,
  changeOnSelect: _propTypes2["default"].bool,
  children: _propTypes2["default"].node,
  onKeyDown: _propTypes2["default"].func,
  expandTrigger: _propTypes2["default"].string
};

exports["default"] = Cascader;
module.exports = exports['default'];

/***/ }),

/***/ 835:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
  value: true
});

var _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };

var _react = __webpack_require__(0);

var _react2 = _interopRequireDefault(_react);

var _propTypes = __webpack_require__(2);

var _propTypes2 = _interopRequireDefault(_propTypes);

var _arrayTreeFilter = __webpack_require__(154);

var _arrayTreeFilter2 = _interopRequireDefault(_arrayTreeFilter);

var _reactDom = __webpack_require__(11);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

function _defaults(obj, defaults) { var keys = Object.getOwnPropertyNames(defaults); for (var i = 0; i < keys.length; i++) { var key = keys[i]; var value = Object.getOwnPropertyDescriptor(defaults, key); if (value && value.configurable && obj[key] === undefined) { Object.defineProperty(obj, key, value); } } return obj; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : _defaults(subClass, superClass); }

var Menus = function (_React$Component) {
  _inherits(Menus, _React$Component);

  function Menus() {
    _classCallCheck(this, Menus);

    return _possibleConstructorReturn(this, _React$Component.apply(this, arguments));
  }

  Menus.prototype.componentDidMount = function componentDidMount() {
    this.scrollActiveItemToView();
  };

  Menus.prototype.componentDidUpdate = function componentDidUpdate(prevProps) {
    if (!prevProps.visible && this.props.visible) {
      this.scrollActiveItemToView();
    }
  };

  Menus.prototype.getOption = function getOption(option, menuIndex) {
    var _props = this.props,
        prefixCls = _props.prefixCls,
        expandTrigger = _props.expandTrigger;

    var onSelect = this.props.onSelect.bind(this, option, menuIndex);
    var expandProps = {
      onClick: onSelect
    };
    var menuItemCls = prefixCls + '-menu-item';
    var hasChildren = option.children && option.children.length > 0;
    if (hasChildren || option.isLeaf === false) {
      menuItemCls += ' ' + prefixCls + '-menu-item-expand';
    }
    if (expandTrigger === 'hover' && hasChildren) {
      expandProps = {
        onMouseEnter: this.delayOnSelect.bind(this, onSelect),
        onMouseLeave: this.delayOnSelect.bind(this),
        onClick: onSelect
      };
    }
    if (this.isActiveOption(option, menuIndex)) {
      menuItemCls += ' ' + prefixCls + '-menu-item-active';
      expandProps.ref = 'activeItem' + menuIndex;
    }
    if (option.disabled) {
      menuItemCls += ' ' + prefixCls + '-menu-item-disabled';
    }
    if (option.loading) {
      menuItemCls += ' ' + prefixCls + '-menu-item-loading';
    }
    var title = '';
    if (option.title) {
      title = option.title;
    } else if (typeof option.label === 'string') {
      title = option.label;
    }
    return _react2["default"].createElement(
      'li',
      _extends({
        key: option.value,
        className: menuItemCls,
        title: title
      }, expandProps),
      option.label
    );
  };

  Menus.prototype.getActiveOptions = function getActiveOptions(values) {
    var activeValue = values || this.props.activeValue;
    var options = this.props.options;
    return (0, _arrayTreeFilter2["default"])(options, function (o, level) {
      return o.value === activeValue[level];
    });
  };

  Menus.prototype.getShowOptions = function getShowOptions() {
    var options = this.props.options;

    var result = this.getActiveOptions().map(function (activeOption) {
      return activeOption.children;
    }).filter(function (activeOption) {
      return !!activeOption;
    });
    result.unshift(options);
    return result;
  };

  Menus.prototype.delayOnSelect = function delayOnSelect(onSelect) {
    var _this2 = this;

    for (var _len = arguments.length, args = Array(_len > 1 ? _len - 1 : 0), _key = 1; _key < _len; _key++) {
      args[_key - 1] = arguments[_key];
    }

    if (this.delayTimer) {
      clearTimeout(this.delayTimer);
      this.delayTimer = null;
    }
    if (typeof onSelect === 'function') {
      this.delayTimer = setTimeout(function () {
        onSelect(args);
        _this2.delayTimer = null;
      }, 150);
    }
  };

  Menus.prototype.scrollActiveItemToView = function scrollActiveItemToView() {
    // scroll into view
    var optionsLength = this.getShowOptions().length;
    for (var i = 0; i < optionsLength; i++) {
      var itemComponent = this.refs['activeItem' + i];
      if (itemComponent) {
        var target = (0, _reactDom.findDOMNode)(itemComponent);
        target.parentNode.scrollTop = target.offsetTop;
      }
    }
  };

  Menus.prototype.isActiveOption = function isActiveOption(option, menuIndex) {
    var _props$activeValue = this.props.activeValue,
        activeValue = _props$activeValue === undefined ? [] : _props$activeValue;

    return activeValue[menuIndex] === option.value;
  };

  Menus.prototype.render = function render() {
    var _this3 = this;

    var _props2 = this.props,
        prefixCls = _props2.prefixCls,
        dropdownMenuColumnStyle = _props2.dropdownMenuColumnStyle;

    return _react2["default"].createElement(
      'div',
      null,
      this.getShowOptions().map(function (options, menuIndex) {
        return _react2["default"].createElement(
          'ul',
          { className: prefixCls + '-menu', key: menuIndex, style: dropdownMenuColumnStyle },
          options.map(function (option) {
            return _this3.getOption(option, menuIndex);
          })
        );
      })
    );
  };

  return Menus;
}(_react2["default"].Component);

Menus.defaultProps = {
  options: [],
  value: [],
  activeValue: [],
  onSelect: function onSelect() {},

  prefixCls: 'rc-cascader-menus',
  visible: false,
  expandTrigger: 'click'
};

Menus.propTypes = {
  value: _propTypes2["default"].array,
  activeValue: _propTypes2["default"].array,
  options: _propTypes2["default"].array.isRequired,
  prefixCls: _propTypes2["default"].string,
  expandTrigger: _propTypes2["default"].string,
  onSelect: _propTypes2["default"].func,
  visible: _propTypes2["default"].bool,
  dropdownMenuColumnStyle: _propTypes2["default"].object
};

exports["default"] = Menus;
module.exports = exports['default'];

/***/ }),

/***/ 836:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
  value: true
});

var _Cascader = __webpack_require__(834);

var _Cascader2 = _interopRequireDefault(_Cascader);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

exports["default"] = _Cascader2["default"]; // export this package's api

module.exports = exports['default'];

/***/ }),

/***/ 989:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
  value: true
});

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

var _react = __webpack_require__(0);

var _react2 = _interopRequireDefault(_react);

var _propTypes = __webpack_require__(2);

var _propTypes2 = _interopRequireDefault(_propTypes);

var _reactDom = __webpack_require__(11);

var _eventlistener = __webpack_require__(666);

var _lodash = __webpack_require__(691);

var _lodash2 = _interopRequireDefault(_lodash);

var _lodash3 = __webpack_require__(696);

var _lodash4 = _interopRequireDefault(_lodash3);

var _parentScroll = __webpack_require__(992);

var _parentScroll2 = _interopRequireDefault(_parentScroll);

var _inViewport = __webpack_require__(991);

var _inViewport2 = _interopRequireDefault(_inViewport);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var LazyLoad = function (_Component) {
  _inherits(LazyLoad, _Component);

  function LazyLoad(props) {
    _classCallCheck(this, LazyLoad);

    var _this = _possibleConstructorReturn(this, (LazyLoad.__proto__ || Object.getPrototypeOf(LazyLoad)).call(this, props));

    _this.lazyLoadHandler = _this.lazyLoadHandler.bind(_this);

    if (props.throttle > 0) {
      if (props.debounce) {
        _this.lazyLoadHandler = (0, _lodash2.default)(_this.lazyLoadHandler, props.throttle);
      } else {
        _this.lazyLoadHandler = (0, _lodash4.default)(_this.lazyLoadHandler, props.throttle);
      }
    }

    _this.state = { visible: false };
    return _this;
  }

  _createClass(LazyLoad, [{
    key: 'componentDidMount',
    value: function componentDidMount() {
      this._mounted = true;
      var eventNode = this.getEventNode();

      this.lazyLoadHandler();

      if (this.lazyLoadHandler.flush) {
        this.lazyLoadHandler.flush();
      }

      (0, _eventlistener.add)(window, 'resize', this.lazyLoadHandler);
      (0, _eventlistener.add)(eventNode, 'scroll', this.lazyLoadHandler);
    }
  }, {
    key: 'componentWillReceiveProps',
    value: function componentWillReceiveProps() {
      if (!this.state.visible) {
        this.lazyLoadHandler();
      }
    }
  }, {
    key: 'shouldComponentUpdate',
    value: function shouldComponentUpdate(_nextProps, nextState) {
      return nextState.visible;
    }
  }, {
    key: 'componentWillUnmount',
    value: function componentWillUnmount() {
      this._mounted = false;
      if (this.lazyLoadHandler.cancel) {
        this.lazyLoadHandler.cancel();
      }

      this.detachListeners();
    }
  }, {
    key: 'getEventNode',
    value: function getEventNode() {
      return (0, _parentScroll2.default)((0, _reactDom.findDOMNode)(this));
    }
  }, {
    key: 'getOffset',
    value: function getOffset() {
      var _props = this.props,
          offset = _props.offset,
          offsetVertical = _props.offsetVertical,
          offsetHorizontal = _props.offsetHorizontal,
          offsetTop = _props.offsetTop,
          offsetBottom = _props.offsetBottom,
          offsetLeft = _props.offsetLeft,
          offsetRight = _props.offsetRight,
          threshold = _props.threshold;


      var _offsetAll = threshold || offset;
      var _offsetVertical = offsetVertical || _offsetAll;
      var _offsetHorizontal = offsetHorizontal || _offsetAll;

      return {
        top: offsetTop || _offsetVertical,
        bottom: offsetBottom || _offsetVertical,
        left: offsetLeft || _offsetHorizontal,
        right: offsetRight || _offsetHorizontal
      };
    }
  }, {
    key: 'lazyLoadHandler',
    value: function lazyLoadHandler() {
      if (!this._mounted) {
        return;
      }
      var offset = this.getOffset();
      var node = (0, _reactDom.findDOMNode)(this);
      var eventNode = this.getEventNode();

      if ((0, _inViewport2.default)(node, eventNode, offset)) {
        var onContentVisible = this.props.onContentVisible;


        this.setState({ visible: true }, function () {
          if (onContentVisible) {
            onContentVisible();
          }
        });
        this.detachListeners();
      }
    }
  }, {
    key: 'detachListeners',
    value: function detachListeners() {
      var eventNode = this.getEventNode();

      (0, _eventlistener.remove)(window, 'resize', this.lazyLoadHandler);
      (0, _eventlistener.remove)(eventNode, 'scroll', this.lazyLoadHandler);
    }
  }, {
    key: 'render',
    value: function render() {
      var _props2 = this.props,
          children = _props2.children,
          className = _props2.className,
          height = _props2.height,
          width = _props2.width;
      var visible = this.state.visible;


      var elStyles = { height: height, width: width };
      var elClasses = 'LazyLoad' + (visible ? ' is-visible' : '') + (className ? ' ' + className : '');

      return _react2.default.createElement(this.props.elementType, {
        className: elClasses,
        style: elStyles
      }, visible && _react.Children.only(children));
    }
  }]);

  return LazyLoad;
}(_react.Component);

exports.default = LazyLoad;


LazyLoad.propTypes = {
  children: _propTypes2.default.node.isRequired,
  className: _propTypes2.default.string,
  debounce: _propTypes2.default.bool,
  elementType: _propTypes2.default.string,
  height: _propTypes2.default.oneOfType([_propTypes2.default.string, _propTypes2.default.number]),
  offset: _propTypes2.default.number,
  offsetBottom: _propTypes2.default.number,
  offsetHorizontal: _propTypes2.default.number,
  offsetLeft: _propTypes2.default.number,
  offsetRight: _propTypes2.default.number,
  offsetTop: _propTypes2.default.number,
  offsetVertical: _propTypes2.default.number,
  threshold: _propTypes2.default.number,
  throttle: _propTypes2.default.number,
  width: _propTypes2.default.oneOfType([_propTypes2.default.string, _propTypes2.default.number]),
  onContentVisible: _propTypes2.default.func
};

LazyLoad.defaultProps = {
  elementType: 'div',
  debounce: true,
  offset: 0,
  offsetBottom: 0,
  offsetHorizontal: 0,
  offsetLeft: 0,
  offsetRight: 0,
  offsetTop: 0,
  offsetVertical: 0,
  throttle: 250
};

/***/ }),

/***/ 990:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = getElementPosition;
/*
* Finds element's position relative to the whole document,
* rather than to the viewport as it is the case with .getBoundingClientRect().
*/
function getElementPosition(element) {
  var rect = element.getBoundingClientRect();

  return {
    top: rect.top + window.pageYOffset,
    left: rect.left + window.pageXOffset
  };
}

/***/ }),

/***/ 991:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = inViewport;

var _getElementPosition = __webpack_require__(990);

var _getElementPosition2 = _interopRequireDefault(_getElementPosition);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var isHidden = function isHidden(element) {
  return element.offsetParent === null;
};

function inViewport(element, container, customOffset) {
  if (isHidden(element)) {
    return false;
  }

  var top = void 0;
  var bottom = void 0;
  var left = void 0;
  var right = void 0;

  if (typeof container === 'undefined' || container === window) {
    top = window.pageYOffset;
    left = window.pageXOffset;
    bottom = top + window.innerHeight;
    right = left + window.innerWidth;
  } else {
    var containerPosition = (0, _getElementPosition2.default)(container);

    top = containerPosition.top;
    left = containerPosition.left;
    bottom = top + container.offsetHeight;
    right = left + container.offsetWidth;
  }

  var elementPosition = (0, _getElementPosition2.default)(element);

  return top <= elementPosition.top + element.offsetHeight + customOffset.top && bottom >= elementPosition.top - customOffset.bottom && left <= elementPosition.left + element.offsetWidth + customOffset.left && right >= elementPosition.left - customOffset.right;
}

/***/ }),

/***/ 992:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
  value: true
});
var style = function style(element, prop) {
  return typeof getComputedStyle !== 'undefined' ? getComputedStyle(element, null).getPropertyValue(prop) : element.style[prop];
};

var overflow = function overflow(element) {
  return style(element, 'overflow') + style(element, 'overflow-y') + style(element, 'overflow-x');
};

var scrollParent = function scrollParent(element) {
  if (!(element instanceof HTMLElement)) {
    return window;
  }

  var parent = element;

  while (parent) {
    if (parent === document.body || parent === document.documentElement) {
      break;
    }

    if (!parent.parentNode) {
      break;
    }

    if (/(scroll|auto)/.test(overflow(parent))) {
      return parent;
    }

    parent = parent.parentNode;
  }

  return window;
};

exports.default = scrollParent;

/***/ })

},[601]);