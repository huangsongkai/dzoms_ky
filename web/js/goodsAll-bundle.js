webpackJsonp([4],{

/***/ 111:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


__webpack_require__(18);

/***/ }),

/***/ 148:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(module, $) {

Object.defineProperty(exports, "__esModule", {
    value: true
});

var _select = __webpack_require__(46);

var _select2 = _interopRequireDefault(_select);

var _index = __webpack_require__(22);

var _index2 = _interopRequireDefault(_index);

var _index3 = __webpack_require__(20);

var _index4 = _interopRequireDefault(_index3);

var _react2 = __webpack_require__(0);

var _react3 = _interopRequireDefault(_react2);

var _index5 = __webpack_require__(21);

var _index6 = _interopRequireDefault(_index5);

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

__webpack_require__(52);

var _reactDom = __webpack_require__(11);

var _reactDom2 = _interopRequireDefault(_reactDom);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var _components = {
    UtilSelect: {
        displayName: 'UtilSelect'
    }
};

var _UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2 = (0, _index6.default)({
    filename: '/Users/song/Downloads/pigeonhole/newProject/components/util/Select.js',
    components: _components,
    locals: [module],
    imports: [_react3.default]
});

var _UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2 = (0, _index4.default)({
    filename: '/Users/song/Downloads/pigeonhole/newProject/components/util/Select.js',
    components: _components,
    locals: [],
    imports: [_react3.default, _index2.default]
});

function _wrapComponent(id) {
    return function (Component) {
        return _UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2(_UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2(Component, id), id);
    };
} /*
    组件功能：下拉选择框
  */


var UtilSelect = _wrapComponent('UtilSelect')(function (_React$Component) {
    _inherits(UtilSelect, _React$Component);

    function UtilSelect(props) {
        _classCallCheck(this, UtilSelect);

        var _this = _possibleConstructorReturn(this, (UtilSelect.__proto__ || Object.getPrototypeOf(UtilSelect)).call(this, props));

        _this.state = {
            employeeJobNumber: []
        };
        return _this;
    }

    _createClass(UtilSelect, [{
        key: 'componentDidMount',
        value: function componentDidMount() {
            var self = this;
            $.ajax({
                type: "get",
                url: "/employeeJobNumber",
                dataType: 'json',
                contentType: 'application/json',
                success: function success(data) {
                    console.log(data.data);
                    var employeeJobNumber = [];
                    if (data.status > 0) {
                        data.data.map(function (obj) {
                            employeeJobNumber.push(obj.employeeId);
                        });
                        self.setState({
                            employeeJobNumber: employeeJobNumber
                        });
                    }
                },
                error: function error(data) {
                    alert("失败");
                }
            });
        }
    }, {
        key: 'onemployeeIdChange',
        value: function onemployeeIdChange(value) {
            //console.log('员工id:',value);
        }
    }, {
        key: 'genselectRows',
        value: function genselectRows() {
            var self = this;
            var selectRows = self.state.employeeJobNumber.map(function (item) {
                return _react3.default.createElement(
                    Option,
                    { value: item },
                    item
                );
            });
            return selectRows;
        }
    }, {
        key: 'render',
        value: function render() {
            return _react3.default.createElement(
                _select2.default,
                {
                    showSearch: true,
                    style: { width: '100%' },
                    placeholder: '\u8BF7\u8F93\u5165\u5458\u5DE5\u5DE5\u53F7',
                    optionFilterProp: 'children',
                    onChange: this.onemployeeIdChange.bind(this),
                    filterOption: function filterOption(input, option) {
                        return option.props.value.toLowerCase().indexOf(input.toLowerCase()) >= 0;
                    }
                },
                this.genselectRows()
            );
        }
    }]);

    return UtilSelect;
}(_react3.default.Component));

exports.default = UtilSelect;
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(17)(module), __webpack_require__(15)))

/***/ }),

/***/ 462:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(module, $) {

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _table = __webpack_require__(29);

var _table2 = _interopRequireDefault(_table);

var _modal = __webpack_require__(41);

var _modal2 = _interopRequireDefault(_modal);

var _index = __webpack_require__(22);

var _index2 = _interopRequireDefault(_index);

var _index3 = __webpack_require__(20);

var _index4 = _interopRequireDefault(_index3);

var _react2 = __webpack_require__(0);

var _react3 = _interopRequireDefault(_react2);

var _index5 = __webpack_require__(21);

var _index6 = _interopRequireDefault(_index5);

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

__webpack_require__(30);

__webpack_require__(42);

var _reactDom = __webpack_require__(11);

var _reactDom2 = _interopRequireDefault(_reactDom);

var _Sorter = __webpack_require__(32);

var _Sorter2 = _interopRequireDefault(_Sorter);

var _Filters = __webpack_require__(37);

var _Filters2 = _interopRequireDefault(_Filters);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var _components = {
  GoodsIssueHisInfo: {
    displayName: 'GoodsIssueHisInfo'
  }
};

var _UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2 = (0, _index6.default)({
  filename: '/Users/song/Downloads/pigeonhole/newProject/components/goods/goodsIssueHisInfo.js',
  components: _components,
  locals: [module],
  imports: [_react3.default]
});

var _UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2 = (0, _index4.default)({
  filename: '/Users/song/Downloads/pigeonhole/newProject/components/goods/goodsIssueHisInfo.js',
  components: _components,
  locals: [],
  imports: [_react3.default, _index2.default]
});

function _wrapComponent(id) {
  return function (Component) {
    return _UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2(_UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2(Component, id), id);
  };
}

var GoodsIssueHisInfo = _wrapComponent('GoodsIssueHisInfo')(function (_React$Component) {
  _inherits(GoodsIssueHisInfo, _React$Component);

  function GoodsIssueHisInfo(props) {
    _classCallCheck(this, GoodsIssueHisInfo);

    var _this = _possibleConstructorReturn(this, (GoodsIssueHisInfo.__proto__ || Object.getPrototypeOf(GoodsIssueHisInfo)).call(this, props));

    _this.state = {
      recData: [] //从后台接收到的数据
    };
    return _this;
  }

  _createClass(GoodsIssueHisInfo, [{
    key: 'componentDidMount',
    value: async function componentDidMount() {
      console.log(this.props.goodsIssueHisInfoUrl);
      $.ajax({
        url: this.props.goodsIssueHisInfoUrl,
        type: "get",
        dataType: 'json',
        contentType: 'application/json',
        success: function (data) {
          if (data.status > 0) {
            console.log("aaaa");
            console.log(data);
            var data = data.data;
            for (var i in data) {
              data[i]["key"] = data[i].itemId;
            }
            this.setState({
              recData: data
            });
          } else {
            recData: "";
          }
        }.bind(this),
        error: function error(data) {
          _modal2.default.error({
            title: '错误信息',
            content: data.message
          });
        }
      });
    }
  }, {
    key: 'render',
    value: function render() {
      var filterData = new _Filters2.default().filter(this.state.recData);
      var columns = [{
        title: '姓名',
        dataIndex: 'personName',
        key: 'personName',
        filters: filterData.personName,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.personName, b.personName);
        },
        onFilter: function onFilter(value, record) {
          return record.personName.indexOf(value) === 0;
        }
      }, {
        title: '物品名称',
        dataIndex: 'itemName',
        key: 'itemName',
        filters: filterData.itemName,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.itemName, b.itemName);
        },
        onFilter: function onFilter(value, record) {
          return record.itemName.indexOf(value) === 0;
        }
      }, {
        title: '身份证号码',
        dataIndex: 'idNumber',
        key: 'idNumber',
        filters: filterData.idNumber,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.idNumber, b.idNumber);
        },
        onFilter: function onFilter(value, record) {
          return record.idNumber.indexOf(value) === 0;
        }
      }, {
        title: '车牌号',
        dataIndex: 'carId',
        key: 'carId',
        filters: filterData.carId,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.carId, b.carId);
        },
        onFilter: function onFilter(value, record) {
          return record.carId.indexOf(value) === 0;
        }
      }, {
        title: '领取数量',
        dataIndex: 'count',
        key: 'count',
        filters: filterData.count,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.count, b.count);
        },
        onFilter: function onFilter(value, record) {
          return record.count.indexOf(value) === 0;
        }
      }];
      return _react3.default.createElement(
        'div',
        null,
        _react3.default.createElement(_table2.default, { key: this.key++, pagination: false, columns: columns, dataSource: this.state.recData })
      );
    }
  }]);

  return GoodsIssueHisInfo;
}(_react3.default.Component));

if (document.getElementById("goodsIssueHisInfo")) _reactDom2.default.render(_react3.default.createElement(GoodsIssueHisInfo, pageUrls), document.getElementById("goodsIssueHisInfo"));
exports.default = GoodsIssueHisInfo;
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(17)(module), __webpack_require__(15)))

/***/ }),

/***/ 463:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(module, $) {

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _form = __webpack_require__(33);

var _form2 = _interopRequireDefault(_form);

var _table = __webpack_require__(29);

var _table2 = _interopRequireDefault(_table);

var _modal = __webpack_require__(41);

var _modal2 = _interopRequireDefault(_modal);

var _input = __webpack_require__(35);

var _input2 = _interopRequireDefault(_input);

var _button = __webpack_require__(23);

var _button2 = _interopRequireDefault(_button);

var _datePicker = __webpack_require__(39);

var _datePicker2 = _interopRequireDefault(_datePicker);

var _index = __webpack_require__(22);

var _index2 = _interopRequireDefault(_index);

var _index3 = __webpack_require__(20);

var _index4 = _interopRequireDefault(_index3);

var _react2 = __webpack_require__(0);

var _react3 = _interopRequireDefault(_react2);

var _index5 = __webpack_require__(21);

var _index6 = _interopRequireDefault(_index5);

var _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

__webpack_require__(34);

__webpack_require__(30);

__webpack_require__(42);

__webpack_require__(27);

__webpack_require__(26);

__webpack_require__(40);

var _reactDom = __webpack_require__(11);

var _reactDom2 = _interopRequireDefault(_reactDom);

var _Sorter = __webpack_require__(32);

var _Sorter2 = _interopRequireDefault(_Sorter);

var _Filters = __webpack_require__(37);

var _Filters2 = _interopRequireDefault(_Filters);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var _components = {
  AppModal: {
    displayName: 'AppModal'
  },
  GoodsManagement: {
    displayName: 'GoodsManagement'
  }
};

var _UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2 = (0, _index6.default)({
  filename: '/Users/song/Downloads/pigeonhole/newProject/components/goods/goodsManagement.js',
  components: _components,
  locals: [module],
  imports: [_react3.default]
});

var _UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2 = (0, _index4.default)({
  filename: '/Users/song/Downloads/pigeonhole/newProject/components/goods/goodsManagement.js',
  components: _components,
  locals: [],
  imports: [_react3.default, _index2.default]
});

function _wrapComponent(id) {
  return function (Component) {
    return _UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2(_UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2(Component, id), id);
  };
}

var FormItem = _form2.default.Item;
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
    return _this;
  }

  _createClass(AppModal, [{
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
      console.log(type, id);
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
          //console.log(i)
          var updateData = this.props.form.setFields({
            itemName: {
              value: recData[i].itemName
            },
            itemUnit: {
              value: recData[i].itemUnit
            },
            itemType: {
              value: recData[i].itemType
            },
            itemRemarks: {
              value: recData[i].itemRemarks
            }
          });
        }
      }

      this.setState({
        visible: true,
        type: "put"
      });
      //const {getFieldsValue} =this.props.form;
      //console.log(getFieldsValue()); //可以获取到修改之后的对象
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
            url: that.props.goodsUrl,
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
                  content: data.message
                });
              }
            },
            error: function error(data) {
              alert("请求失败");
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
          //测试添加
          // recData.splice(0,0,tableData); //添到数组最前面的位置
          // this.props.transferMsg(recData);   
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
      //后台处理  
      var self = this;
      $.ajax({
        type: type,
        url: self.props.goodsUrl,
        data: JSON.stringify(tableData),
        dataType: 'json',
        contentType: 'application/json',
        success: function success(data) {
          if (data.status > 0) {
            self.props.form.resetFields();
            //console.log("aaaa");
            if (type == "put") {
              //给tableData加id
              for (var i in id) {
                tableData["id"] = id[i];
              }
              //把tableData
              for (var i in recData) {
                if (tableData.id == recData[i].id) {
                  Object.assign(recData[i], tableData);
                }
              }
              self.props.transferMsg(recData);
              _modal2.default.success({
                title: '提示信息',
                content: data.message
              });
            } else if (type == "post") {
              tableData["id"] = data.data.id;
              tableData["key"] = data.data.id;
              //给tableData加itemState
              if (data.data.itemState == "1") {
                tableData["itemState"] = "运营部商品";
              } else if (data.data.itemState == "2") {
                tableData["itemState"] = "办公室商品";
              }
              recData.splice(0, 0, tableData); //添到数组最前面的位置
              self.props.transferMsg(recData);
              _modal2.default.success({
                title: '提示信息',
                content: data.message
              });
            }
          } else {
            console.log(data);
            if (type == "put") {
              _modal2.default.error({
                title: '错误信息',
                content: data.message
              });
            } else if (type == "post") {
              _modal2.default.error({
                title: '错误信息',
                content: data.message
              });
            }
          }
        },
        error: function error(data) {
          alert("请求失败");
        }
      });
    }
  }, {
    key: 'handleCancel',
    value: function handleCancel() {
      this.setState({ visible: false });
    }
  }, {
    key: 'render',
    value: function render() {
      //console.log(this.state.newKey)
      //console.log(this.props.url);
      var key = this.state.newKey;
      var formItemLayout = {
        labelCol: { span: 4 },
        wrapperCol: { span: 12 }
      };
      var getFieldDecorator = this.props.form.getFieldDecorator;

      var br = "<br>";
      return _react3.default.createElement(
        'div',
        null,
        _react3.default.createElement(
          _button2.default,
          { type: 'primary', onClick: this.showAddModal.bind(this, "post") },
          '\u6DFB\u52A0\u7269\u54C1'
        ),
        _react3.default.createElement(
          _button2.default,
          { style: { marginLeft: 15 }, type: 'primary', onClick: this.showUpdateModal.bind(this, "put", this.props.rows) },
          '\u4FEE\u6539\u7269\u54C1'
        ),
        _react3.default.createElement(
          _button2.default,
          { style: { marginLeft: 15 }, type: 'primary', onClick: this.delete.bind(this, this.props.rows) },
          '\u5220\u9664\u7269\u54C1'
        ),
        _react3.default.createElement(
          _modal2.default,
          {
            visible: this.state.visible,
            title: '\u6DFB\u52A0\u7269\u54C1\u4FE1\u606F',
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
              _extends({
                label: '\u7269\u54C1\u540D'
              }, formItemLayout),
              getFieldDecorator('itemName', {
                rules: [{ required: true, message: '该字段不能为空!' }]
              })(_react3.default.createElement(_input2.default, null))
            ),
            _react3.default.createElement(
              FormItem,
              _extends({
                label: '\u5355\u4F4D'
              }, formItemLayout),
              getFieldDecorator('itemUnit', {
                rules: [{ required: true, message: '该字段不能为空!' }]
              })(_react3.default.createElement(_input2.default, null))
            ),
            _react3.default.createElement(
              FormItem,
              _extends({
                label: '\u578B\u53F7'
              }, formItemLayout),
              getFieldDecorator('itemType', {
                rules: [{ required: true, message: '该字段不能为空!' }]
              })(_react3.default.createElement(_input2.default, null))
            ),
            _react3.default.createElement(
              FormItem,
              _extends({
                label: '\u5907\u6CE8'
              }, formItemLayout),
              getFieldDecorator('itemRemarks', {
                rules: [{ required: true, message: '该字段不能为空!' }]
              })(_react3.default.createElement(_input2.default, { type: 'textarea' }))
            )
          )
        )
      );
    }
  }]);

  return AppModal;
}(_react3.default.Component));

var GoodsManagement = _wrapComponent('GoodsManagement')(function (_React$Component2) {
  _inherits(GoodsManagement, _React$Component2);

  function GoodsManagement(props) {
    _classCallCheck(this, GoodsManagement);

    var _this3 = _possibleConstructorReturn(this, (GoodsManagement.__proto__ || Object.getPrototypeOf(GoodsManagement)).call(this, props));

    _this3.state = {
      selectedRowKeys: [], // Check here to configure the default column
      loading: false,
      recData: [], //从后台接收到的数据
      newKey: 0
    };
    _this3.key = 0;
    return _this3;
  }

  _createClass(GoodsManagement, [{
    key: 'componentDidMount',
    value: function componentDidMount() {
      $.ajax({
        url: this.props.goodsUrl,
        type: "get",
        dataType: 'json',
        contentType: 'application/json',
        success: function (data) {
          if (data.status > 0) {
            var data = data.data;
            console.log(data);
            for (var i = 0; i < data.length; i++) {
              data[i]["key"] = data[i].id;
              var itemState = [];
              for (var j in data[i].itemState) {
                //console.log(data[i].itemState[j]);
                if (data[i].itemState[j] == "1") {
                  data[i].itemState = "运营部商品";
                } else if (data[i].itemState[j] == 2) {
                  data[i].itemState = "办公室商品";
                }
              }
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
      console.log(recData);
      this.setState({
        recData: recData,
        selectedRowKeys: []
      });
    }
  }, {
    key: 'onSelectChange',
    value: function onSelectChange(selectedRowKeys) {
      //console.log('selectedRowKeys changed: ', selectedRowKeys);
      // this.setState({selectedRowKeys});
      // console.log(selectedRowKeys);
      this.setState({ selectedRowKeys: selectedRowKeys });
      console.log(selectedRowKeys);
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
    key: 'render',
    value: function render() {
      var _this4 = this;

      var filterData = new _Filters2.default().filter(this.state.recData);
      var columns = [{
        title: '物品名',
        dataIndex: 'itemName',
        key: 'itemName',
        filters: filterData.itemName,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.itemName, b.itemName);
        },
        onFilter: function onFilter(value, record) {
          return record.itemName.indexOf(value) === 0;
        }
      }, {
        title: '单位',
        dataIndex: 'itemUnit',
        key: 'itemUnit',
        filters: filterData.itemUnit,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.itemUnit, b.itemUnit);
        },
        onFilter: function onFilter(value, record) {
          return record.itemUnit.indexOf(value) === 0;
        }
      }, {
        title: '型号',
        dataIndex: 'itemType',
        key: 'itemType',
        filters: filterData.itemType,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.itemType, b.itemType);
        },
        onFilter: function onFilter(value, record) {
          return record.itemType.indexOf(value) === 0;
        }
      }, {
        title: '备注',
        dataIndex: 'itemRemarks',
        key: 'itemRemarks',
        filters: filterData.itemRemarks,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.itemRemarks, b.itemRemarks);
        },
        onFilter: function onFilter(value, record) {
          return record.itemRemarks.indexOf(value) === 0;
        }
      }, {
        title: '状态',
        dataIndex: 'itemState',
        key: 'itemState',
        filters: filterData.itemState,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.itemState, b.itemState);
        },
        onFilter: function onFilter(value, record) {
          return record.itemState.indexOf(value) === 0;
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
        null,
        _react3.default.createElement(
          'div',
          { style: { marginBottom: 16 } },
          _react3.default.createElement(WrappedApp, _extends({}, pageUrls, { visible: this.state.visible, rows: this.state.selectedRowKeys,
            recData: this.state.recData, transferMsg: function transferMsg(recData) {
              return _this4.transferMsg(recData);
            } })),
          _react3.default.createElement(
            'span',
            { style: { marginLeft: 8 } },
            hasSelected ? 'Selected ' + selectedRowKeys.length + ' items' : ''
          )
        ),
        _react3.default.createElement(_table2.default, { key: this.key++, pagination: false, rowSelection: rowSelection, columns: columns, onChange: this.onChange.bind(this), dataSource: this.state.recData })
      );
    }
  }]);

  return GoodsManagement;
}(_react3.default.Component));

var WrappedApp = _form2.default.create()(AppModal);
if (document.getElementById("goodsManagement")) _reactDom2.default.render(_react3.default.createElement(GoodsManagement, pageUrls), document.getElementById("goodsManagement"));
exports.default = GoodsManagement;
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(17)(module), __webpack_require__(15)))

/***/ }),

/***/ 464:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(module, $) {

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _table = __webpack_require__(29);

var _table2 = _interopRequireDefault(_table);

var _button = __webpack_require__(23);

var _button2 = _interopRequireDefault(_button);

var _inputNumber = __webpack_require__(50);

var _inputNumber2 = _interopRequireDefault(_inputNumber);

var _modal = __webpack_require__(41);

var _modal2 = _interopRequireDefault(_modal);

var _datePicker = __webpack_require__(39);

var _datePicker2 = _interopRequireDefault(_datePicker);

var _form = __webpack_require__(33);

var _form2 = _interopRequireDefault(_form);

var _index = __webpack_require__(22);

var _index2 = _interopRequireDefault(_index);

var _index3 = __webpack_require__(20);

var _index4 = _interopRequireDefault(_index3);

var _react2 = __webpack_require__(0);

var _react3 = _interopRequireDefault(_react2);

var _index5 = __webpack_require__(21);

var _index6 = _interopRequireDefault(_index5);

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

__webpack_require__(30);

__webpack_require__(26);

__webpack_require__(51);

__webpack_require__(42);

__webpack_require__(40);

__webpack_require__(34);

var _reactDom = __webpack_require__(11);

var _reactDom2 = _interopRequireDefault(_reactDom);

var _Sorter = __webpack_require__(32);

var _Sorter2 = _interopRequireDefault(_Sorter);

var _Filters = __webpack_require__(37);

var _Filters2 = _interopRequireDefault(_Filters);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var _components = {
  Goods: {
    displayName: 'Goods'
  }
};

var _UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2 = (0, _index6.default)({
  filename: '/Users/song/Downloads/pigeonhole/newProject/components/goods/officeIssue.js',
  components: _components,
  locals: [module],
  imports: [_react3.default]
});

var _UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2 = (0, _index4.default)({
  filename: '/Users/song/Downloads/pigeonhole/newProject/components/goods/officeIssue.js',
  components: _components,
  locals: [],
  imports: [_react3.default, _index2.default]
});

function _wrapComponent(id) {
  return function (Component) {
    return _UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2(_UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2(Component, id), id);
  };
}

var FormItem = _form2.default.Item;
var MonthPicker = _datePicker2.default.MonthPicker,
    RangePicker = _datePicker2.default.RangePicker;

var dateFormat = 'YYYY/MM/DD';
var monthFormat = 'YYYY/MM';

var Goods = _wrapComponent('Goods')(function (_React$Component) {
  _inherits(Goods, _React$Component);

  function Goods(props) {
    _classCallCheck(this, Goods);

    var _this = _possibleConstructorReturn(this, (Goods.__proto__ || Object.getPrototypeOf(Goods)).call(this, props));

    _this.state = {
      recData: [] //从后台接收到的数据
    };
    _this.key = 0;
    _this.itemId = "";
    _this.num = "";
    return _this;
  }

  _createClass(Goods, [{
    key: 'componentDidMount',
    value: async function componentDidMount() {
      var self = this;
      $.ajax({
        //url:"/goodsList",
        url: this.props.goodsInfoUrl,
        type: "get",
        dataType: 'json',
        contentType: 'application/json',
        success: function (data) {
          if (data) {
            var data = data.data;
            for (var i in data) {
              data[i]["key"] = data[i].itemId;
            }
            self.setState({
              recData: data
            });
          } else {
            recData: "";
          }
        }.bind(self),
        error: function error() {
          alert("请求失败");
        }
      });
    }
  }, {
    key: 'action',
    value: function action(index) {
      console.log(this.itemId);
      console.log(this.num);
      if (this.num > 0) {
        window.location.href = this.props.jumpUrl + "?itemId=" + this.itemId + "&num=" + this.num;
      } else {
        _modal2.default.error({
          title: '错误信息',
          content: '采购数量必须大于0'
        });
      }
    }
  }, {
    key: 'onScoreChange',
    value: function onScoreChange(index, value) {
      //console.log(this.state.recData);
      console.log(index, value);
      var itemId = this.state.recData[index].itemId;
      this.itemId = itemId;
      this.num = value;
    }
  }, {
    key: 'render',
    value: function render() {
      var _this2 = this;

      var filterData = new _Filters2.default().filter(this.state.recData);
      var columns = [{
        title: '名称',
        dataIndex: 'itemName',
        key: 'itemName',
        filters: filterData.itemName,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.itemName, b.itemName);
        },
        onFilter: function onFilter(value, record) {
          return record.itemName.indexOf(value) === 0;
        }
      }, {
        title: '型号',
        dataIndex: 'itemType',
        key: 'itemType',
        filters: filterData.itemType,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.itemType, b.itemType);
        },
        onFilter: function onFilter(value, record) {
          return record.itemType.indexOf(value) === 0;
        }
      }, {
        title: '库存',
        dataIndex: 'itemTotalNum',
        key: 'itemTotalNum',
        filters: filterData.itemTotalNum,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.itemTotalNum, b.itemTotalNum);
        },
        onFilter: function onFilter(value, record) {
          return record.itemTotalNum.indexOf(value) === 0;
        }
      }, {
        title: '单价',
        dataIndex: 'itemPurchasingPrice',
        key: 'itemPurchasingPrice',
        filters: filterData.itemPurchasingPrice,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.itemPurchasingPrice, b.itemPurchasingPrice);
        },
        onFilter: function onFilter(value, record) {
          return record.itemPurchasingPrice.indexOf(value) === 0;
        }
      }, {
        title: '领用数量',
        dataIndex: 'num',
        key: 'num',
        render: function render(text, record, index) {
          return _react3.default.createElement(_inputNumber2.default, { min: 1, max: 10, defaultValue: 0, onChange: _this2.onScoreChange.bind(_this2, index) });
        }
      }, {
        title: '操作',
        render: function render(text, record, index) {
          return _react3.default.createElement(
            _button2.default,
            { onClick: _this2.action.bind(_this2, index) },
            '\u9886\u7528'
          );
        }
      }];
      return _react3.default.createElement(
        'div',
        null,
        _react3.default.createElement(_table2.default, { key: this.key++, pagination: false, columns: columns, dataSource: this.state.recData })
      );
    }
  }]);

  return Goods;
}(_react3.default.Component));

if (document.getElementById("officeIssue")) _reactDom2.default.render(_react3.default.createElement(Goods, pageUrls), document.getElementById("officeIssue"));
exports.default = Goods;
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(17)(module), __webpack_require__(15)))

/***/ }),

/***/ 465:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(module, $) {

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _table = __webpack_require__(29);

var _table2 = _interopRequireDefault(_table);

var _button = __webpack_require__(23);

var _button2 = _interopRequireDefault(_button);

var _inputNumber = __webpack_require__(50);

var _inputNumber2 = _interopRequireDefault(_inputNumber);

var _modal = __webpack_require__(41);

var _modal2 = _interopRequireDefault(_modal);

var _input = __webpack_require__(35);

var _input2 = _interopRequireDefault(_input);

var _datePicker = __webpack_require__(39);

var _datePicker2 = _interopRequireDefault(_datePicker);

var _form = __webpack_require__(33);

var _form2 = _interopRequireDefault(_form);

var _index = __webpack_require__(22);

var _index2 = _interopRequireDefault(_index);

var _index3 = __webpack_require__(20);

var _index4 = _interopRequireDefault(_index3);

var _react2 = __webpack_require__(0);

var _react3 = _interopRequireDefault(_react2);

var _index5 = __webpack_require__(21);

var _index6 = _interopRequireDefault(_index5);

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

__webpack_require__(30);

__webpack_require__(26);

__webpack_require__(51);

__webpack_require__(42);

__webpack_require__(27);

__webpack_require__(40);

__webpack_require__(34);

var _reactDom = __webpack_require__(11);

var _reactDom2 = _interopRequireDefault(_reactDom);

var _Sorter = __webpack_require__(32);

var _Sorter2 = _interopRequireDefault(_Sorter);

var _Filters = __webpack_require__(37);

var _Filters2 = _interopRequireDefault(_Filters);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var _components = {
  OfficePurchase: {
    displayName: 'OfficePurchase'
  }
};

var _UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2 = (0, _index6.default)({
  filename: '/Users/song/Downloads/pigeonhole/newProject/components/goods/officePurchase.js',
  components: _components,
  locals: [module],
  imports: [_react3.default]
});

var _UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2 = (0, _index4.default)({
  filename: '/Users/song/Downloads/pigeonhole/newProject/components/goods/officePurchase.js',
  components: _components,
  locals: [],
  imports: [_react3.default, _index2.default]
});

function _wrapComponent(id) {
  return function (Component) {
    return _UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2(_UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2(Component, id), id);
  };
}

var FormItem = _form2.default.Item;
var MonthPicker = _datePicker2.default.MonthPicker,
    RangePicker = _datePicker2.default.RangePicker;
var TextArea = _input2.default.TextArea;

var dateFormat = 'YYYY/MM/DD';
var monthFormat = 'YYYY/MM';

var OfficePurchase = _wrapComponent('OfficePurchase')(function (_React$Component) {
  _inherits(OfficePurchase, _React$Component);

  function OfficePurchase(props) {
    _classCallCheck(this, OfficePurchase);

    var _this = _possibleConstructorReturn(this, (OfficePurchase.__proto__ || Object.getPrototypeOf(OfficePurchase)).call(this, props));

    _this.state = {
      recData: [] //从后台接收到的数据
    };
    _this.key = 0;
    _this.itemId = "";
    _this.num = "";
    _this.result = { itemId: "", num: "", remark: "" };
    return _this;
  }

  _createClass(OfficePurchase, [{
    key: 'componentDidMount',
    value: async function componentDidMount() {
      var self = this;
      $.ajax({
        //url:"/goodsList",
        url: this.props.goodsInfoUrl,
        type: "get",
        dataType: 'json',
        contentType: 'application/json',
        success: function (data) {
          if (data) {
            var data = data.data;
            for (var i in data) {
              data[i]["key"] = data[i].itemId;
            }
            self.setState({
              recData: data
            });
          } else {
            recData: "";
          }
        }.bind(self),
        error: function error() {
          alert("请求失败");
        }
      });
    }
  }, {
    key: 'action',
    value: function action(index) {
      if (this.result.num > 0) {
        $.ajax({
          //url:"/goodsList",
          url: this.props.goodsInfoUrl,
          type: "post",
          dataType: 'json',
          data: JSON.stringify(this.result),
          contentType: 'application/json',
          success: function (data) {
            if (data.data.status > 0) {
              // window.location.href=this.props.jumpUrl
            } else {
              _modal2.default.error({
                title: '错误信息',
                content: '入库失败'
              });
            }
          }.bind(self),
          error: function error() {
            alert("请求失败");
          }
        });
      } else {
        _modal2.default.error({
          title: '错误信息',
          content: '采购数量必须大于0'
        });
      }
    }
  }, {
    key: 'onScoreChange',
    value: function onScoreChange(index, value) {
      //console.log(this.state.recData);
      // console.log(index,value)
      // var itemId=this.state.recData[index].itemId;
      // this.itemId=itemId;
      // this.num=value;
      this.result.itemId = this.state.recData[index].itemId;
      this.result.num = value;
    }
  }, {
    key: 'onRemarkChange',
    value: function onRemarkChange(index, value) {
      var remark;
      if (typeof value == 'string' && value.constructor == String) {
        remark = value;
      } else {
        remark = value.target.value;
      }
      // console.log(index,remark) //传输数据方式待确认 拼接？ajax？
      this.result.remark = remark;
    }
  }, {
    key: 'render',
    value: function render() {
      var _this2 = this;

      var filterData = new _Filters2.default().filter(this.state.recData);
      var columns = [{
        title: '名称',
        dataIndex: 'itemName',
        key: 'itemName',
        filters: filterData.itemName,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.itemName, b.itemName);
        },
        onFilter: function onFilter(value, record) {
          return record.itemName.indexOf(value) === 0;
        }
      }, {
        title: '型号',
        dataIndex: 'itemType',
        key: 'itemType',
        filters: filterData.itemType,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.itemType, b.itemType);
        },
        onFilter: function onFilter(value, record) {
          return record.itemType.indexOf(value) === 0;
        }
      }, {
        title: '库存',
        dataIndex: 'itemTotalNum',
        key: 'itemTotalNum',
        filters: filterData.itemTotalNum,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.itemTotalNum, b.itemTotalNum);
        },
        onFilter: function onFilter(value, record) {
          return record.itemTotalNum.indexOf(value) === 0;
        }
      }, {
        title: '单价',
        dataIndex: 'itemPurchasingPrice',
        key: 'itemPurchasingPrice',
        filters: filterData.itemPurchasingPrice,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.itemPurchasingPrice, b.itemPurchasingPrice);
        },
        onFilter: function onFilter(value, record) {
          return record.itemPurchasingPrice.indexOf(value) === 0;
        }
      }, {
        title: '采购数量',
        dataIndex: 'num',
        key: 'num',
        render: function render(text, record, index) {
          return _react3.default.createElement(_inputNumber2.default, { min: 1, max: 10, defaultValue: 0, onChange: _this2.onScoreChange.bind(_this2, index) });
        }
      }, {
        title: '备注',
        dataIndex: 'remark',
        key: 'remark',
        render: function render(text, record, index) {
          return _react3.default.createElement(TextArea, { autosize: { minRows: 1 }, onChange: _this2.onRemarkChange.bind(_this2, index) });
        }
      }, {
        title: '入库',
        render: function render(text, record, index) {
          return _react3.default.createElement(
            _button2.default,
            { onClick: _this2.action.bind(_this2, index) },
            '\u5165\u5E93'
          );
        }
      }];
      return _react3.default.createElement(
        'div',
        null,
        _react3.default.createElement(_table2.default, { bordered: true, key: this.key++, pagination: false, columns: columns, dataSource: this.state.recData })
      );
    }
  }]);

  return OfficePurchase;
}(_react3.default.Component));

if (document.getElementById("officePurchase")) _reactDom2.default.render(_react3.default.createElement(OfficePurchase, pageUrls), document.getElementById("officePurchase"));
exports.default = OfficePurchase;
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(17)(module), __webpack_require__(15)))

/***/ }),

/***/ 466:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(module, $) {

Object.defineProperty(exports, "__esModule", {
    value: true
});

var _form = __webpack_require__(33);

var _form2 = _interopRequireDefault(_form);

var _modal = __webpack_require__(41);

var _modal2 = _interopRequireDefault(_modal);

var _inputNumber = __webpack_require__(50);

var _inputNumber2 = _interopRequireDefault(_inputNumber);

var _input = __webpack_require__(35);

var _input2 = _interopRequireDefault(_input);

var _select = __webpack_require__(46);

var _select2 = _interopRequireDefault(_select);

var _button = __webpack_require__(23);

var _button2 = _interopRequireDefault(_button);

var _table = __webpack_require__(29);

var _table2 = _interopRequireDefault(_table);

var _datePicker = __webpack_require__(39);

var _datePicker2 = _interopRequireDefault(_datePicker);

var _index = __webpack_require__(22);

var _index2 = _interopRequireDefault(_index);

var _index3 = __webpack_require__(20);

var _index4 = _interopRequireDefault(_index3);

var _react2 = __webpack_require__(0);

var _react3 = _interopRequireDefault(_react2);

var _index5 = __webpack_require__(21);

var _index6 = _interopRequireDefault(_index5);

var _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

__webpack_require__(34);

__webpack_require__(42);

__webpack_require__(51);

__webpack_require__(27);

__webpack_require__(52);

__webpack_require__(26);

__webpack_require__(30);

__webpack_require__(40);

var _reactDom = __webpack_require__(11);

var _reactDom2 = _interopRequireDefault(_reactDom);

var _Sorter = __webpack_require__(32);

var _Sorter2 = _interopRequireDefault(_Sorter);

var _Filters = __webpack_require__(37);

var _Filters2 = _interopRequireDefault(_Filters);

var _SelectInfo = __webpack_require__(92);

var _SelectInfo2 = _interopRequireDefault(_SelectInfo);

var _Select2 = __webpack_require__(148);

var _Select3 = _interopRequireDefault(_Select2);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var _components = {
    YunyingbuIssue: {
        displayName: 'YunyingbuIssue'
    }
};

var _UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2 = (0, _index6.default)({
    filename: '/Users/song/Downloads/pigeonhole/newProject/components/goods/yunyingbuIssue.js',
    components: _components,
    locals: [module],
    imports: [_react3.default]
});

var _UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2 = (0, _index4.default)({
    filename: '/Users/song/Downloads/pigeonhole/newProject/components/goods/yunyingbuIssue.js',
    components: _components,
    locals: [],
    imports: [_react3.default, _index2.default]
});

function _wrapComponent(id) {
    return function (Component) {
        return _UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2(_UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2(Component, id), id);
    };
}

var FormItem = _form2.default.Item;
var InputGroup = _input2.default.Group;
var MonthPicker = _datePicker2.default.MonthPicker,
    RangePicker = _datePicker2.default.RangePicker;

var dateFormat = 'YYYY/MM/DD';
var monthFormat = 'YYYY/MM';

var YunyingbuIssue = _wrapComponent('YunyingbuIssue')(function (_React$Component) {
    _inherits(YunyingbuIssue, _React$Component);

    function YunyingbuIssue(props) {
        _classCallCheck(this, YunyingbuIssue);

        var _this = _possibleConstructorReturn(this, (YunyingbuIssue.__proto__ || Object.getPrototypeOf(YunyingbuIssue)).call(this, props));

        _this.state = {
            recData: [], //从后台接收到的数据
            recCph: [], //后台请求回来的车牌号数组
            visible: false
        };
        _this.CphValue = ""; //后面的车牌号
        _this.cphId = ""; //车牌号ID
        _this.cphPrefix = ""; //车牌号前缀
        _this.objCph = ""; //车牌号单独的对象
        _this.key = 0;
        _this.itemId = "";
        return _this;
    }

    _createClass(YunyingbuIssue, [{
        key: 'componentDidMount',
        value: async function componentDidMount() {
            var self = this;
            $.ajax({
                //url:"/goodsList",
                url: self.props.goodsInfoUrl,
                type: "get",
                dataType: 'json',
                contentType: 'application/json',
                success: function (data) {
                    if (data.status > 0) {
                        var data = data.data;
                        for (var i in data) {
                            data[i]["key"] = data[i].itemId;
                        }
                        self.setState({
                            recData: data
                        });
                    } else {
                        recData: "";
                    }
                }.bind(self),
                error: function error(data) {
                    _modal2.default.error({
                        title: data.message,
                        content: data.message
                    });
                }
            });
        }
    }, {
        key: 'showAddModal',
        value: function showAddModal(index, value) {
            // console.log(index,value);
            var itemId = this.state.recData[index].itemId;
            this.itemId = itemId;
            this.setState({
                visible: true
            });
        }
    }, {
        key: 'handleCancel',
        value: function handleCancel() {
            this.setState({ visible: false });
        }
    }, {
        key: 'addOrUpdate',
        value: function addOrUpdate() {
            var _this2 = this;

            //验证并储存表单数据
            //console.log(this.itemId);
            var result = {};
            var recData = this.props.recData;
            //if(this.state.errorMessage==""){
            this.props.form.validateFields(function (err, values) {
                if (!err) {
                    _this2.setState({ loading: false, visible: false });
                    result = values;
                    result["itemId"] = _this2.itemId;
                    result.carId = _this2.objCph;
                    var self = _this2;
                    $.ajax({
                        //url: this.props.submitUrl+"/"+result.recipient+"/"+result.idNumber+"/"+result.carId+"/"+result.count+"/"+result.itemId,
                        url: self.props.submitUrl,
                        type: "POST",
                        data: JSON.stringify(result),
                        dataType: 'json',
                        contentType: 'application/json',
                        success: function success(data) {
                            if (data.status > 0) {
                                self.props.form.resetFields();
                                //console.log($("#selectValue").val);
                                _modal2.default.success({
                                    title: '提示信息',
                                    content: '保存成功！'
                                });
                            } else {
                                _modal2.default.error({
                                    title: '错误信息',
                                    content: data.message
                                });
                            }
                        },
                        error: function error(data) {
                            _modal2.default.error({
                                title: '错误信息',
                                content: data.message
                            });
                        }
                    });
                } else {
                    _this2.setState({
                        loading: false,
                        visible: true
                    });
                    return;
                }
            });
            // }else{
            // 	return;
            // }
            console.log(result);
            //后台处理  
        }
        //车牌号

    }, {
        key: 'chepaihaoChange',
        value: function chepaihaoChange(value) {
            this.cphPrefix = value;
            var self = this;
            $.ajax({
                type: "get",
                //url:"/chepaihaoA",
                url: self.props.chepaihao,
                data: JSON.stringify(value),
                dataType: 'json',
                contentType: 'application/json',
                success: function success(data) {
                    self.setState({
                        recCph: data
                    });
                },
                error: function error(data) {
                    _modal2.default.error({
                        title: '错误信息',
                        content: data.message
                    });
                }
            });
        }
    }, {
        key: 'onChange',
        value: function onChange(value) {
            //console.log('changed', value);
        }
    }, {
        key: 'changecphValue',
        value: function changecphValue(CphValue) {
            this.CphValue = CphValue;
            this.objCph = this.cphPrefix + CphValue;
            //console.log(this.objCph);
        }
    }, {
        key: 'selectInfoErrorMessage',
        value: function selectInfoErrorMessage(errorMessage) {
            this.setState({
                errorMessage: errorMessage
            });
        }
        /******************************/

    }, {
        key: 'render',
        value: function render() {
            var _this3 = this;

            var filterData = new _Filters2.default().filter(this.state.recData);
            var columns = [{
                title: '名称',
                dataIndex: 'itemName',
                key: 'itemName',
                filters: filterData.itemName,
                sorter: function sorter(a, b) {
                    return new _Sorter2.default().sort(a.itemName, b.itemName);
                },
                onFilter: function onFilter(value, record) {
                    return record.itemName.indexOf(value) === 0;
                }
            }, {
                title: '型号',
                dataIndex: 'itemType',
                key: 'itemType',
                filters: filterData.itemType,
                sorter: function sorter(a, b) {
                    return new _Sorter2.default().sort(a.itemType, b.itemType);
                },
                onFilter: function onFilter(value, record) {
                    return record.itemType.indexOf(value) === 0;
                }
            }, {
                title: '库存',
                dataIndex: 'itemTotalNum',
                key: 'itemTotalNum',
                filters: filterData.itemTotalNum,
                sorter: function sorter(a, b) {
                    return new _Sorter2.default().sort(a.itemTotalNum, b.itemTotalNum);
                },
                onFilter: function onFilter(value, record) {
                    return record.itemTotalNum.indexOf(value) === 0;
                }
            }, {
                title: '单价',
                dataIndex: 'itemPurchasingPrice',
                key: 'itemPurchasingPrice',
                filters: filterData.itemPurchasingPrice,
                sorter: function sorter(a, b) {
                    return new _Sorter2.default().sort(a.itemPurchasingPrice, b.itemPurchasingPrice);
                },
                onFilter: function onFilter(value, record) {
                    return record.itemPurchasingPrice.indexOf(value) === 0;
                }
            }, {
                title: '领用',
                render: function render(text, record, index) {
                    return _react3.default.createElement(
                        _button2.default,
                        { onClick: _this3.showAddModal.bind(_this3, index) },
                        '\u9886\u7528'
                    );
                }
            }];
            var formItemLayout = {
                labelCol: { span: 8 },
                wrapperCol: { span: 16 }
            };
            var getFieldDecorator = this.props.form.getFieldDecorator;

            return _react3.default.createElement(
                'div',
                null,
                _react3.default.createElement(_table2.default, { key: this.key++, columns: columns, pagination: false, dataSource: this.state.recData }),
                _react3.default.createElement(
                    _modal2.default,
                    {
                        style: { width: '100%' },
                        visible: this.state.visible,
                        title: '\u53D1\u653E\u4FE1\u606F',
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
                            _extends({
                                label: '\u8F66\u724C\u53F7\uFF1A'
                            }, formItemLayout),
                            getFieldDecorator('carId', {
                                rules: [{ required: true, message: '提示：' }]
                            })(_react3.default.createElement(
                                'div',
                                null,
                                _react3.default.createElement(
                                    InputGroup,
                                    { compact: true, style: { width: '100%' } },
                                    _react3.default.createElement(
                                        _select2.default,
                                        { style: { width: '30%' }, placeholder: '\u5F52\u5C5E\u5730', onChange: this.chepaihaoChange.bind(this) },
                                        _react3.default.createElement(
                                            Option,
                                            { value: '\u9ED1A' },
                                            '\u9ED1A'
                                        ),
                                        _react3.default.createElement(
                                            Option,
                                            { value: '\u9ED1B' },
                                            '\u9ED1B'
                                        ),
                                        _react3.default.createElement(
                                            Option,
                                            { value: '\u9ED1C' },
                                            '\u9ED1C'
                                        ),
                                        _react3.default.createElement(
                                            Option,
                                            { value: '\u9ED1D' },
                                            '\u9ED1D'
                                        ),
                                        _react3.default.createElement(
                                            Option,
                                            { value: '\u9ED1E' },
                                            '\u9ED1E'
                                        ),
                                        _react3.default.createElement(
                                            Option,
                                            { value: '\u9ED1F' },
                                            '\u9ED1F'
                                        ),
                                        _react3.default.createElement(
                                            Option,
                                            { value: '\u9ED1G' },
                                            '\u9ED1G'
                                        ),
                                        _react3.default.createElement(
                                            Option,
                                            { value: '\u9ED1H' },
                                            '\u9ED1H'
                                        ),
                                        _react3.default.createElement(
                                            Option,
                                            { value: '\u9ED1J' },
                                            '\u9ED1J'
                                        ),
                                        _react3.default.createElement(
                                            Option,
                                            { value: '\u9ED1K' },
                                            '\u9ED1K'
                                        ),
                                        _react3.default.createElement(
                                            Option,
                                            { value: '\u9ED1L' },
                                            '\u9ED1L'
                                        ),
                                        _react3.default.createElement(
                                            Option,
                                            { value: '\u9ED1M' },
                                            '\u9ED1M'
                                        ),
                                        _react3.default.createElement(
                                            Option,
                                            { value: '\u9ED1N' },
                                            '\u9ED1N'
                                        ),
                                        _react3.default.createElement(
                                            Option,
                                            { value: '\u9ED1P' },
                                            '\u9ED1P'
                                        ),
                                        _react3.default.createElement(
                                            Option,
                                            { value: '\u9ED1R' },
                                            '\u9ED1R'
                                        )
                                    ),
                                    _react3.default.createElement(_SelectInfo2.default, _extends({ selectInfoErrorMessage: this.selectInfoErrorMessage.bind(this), id: 'selectValue', changecphValue: this.changecphValue.bind(this), style: { width: '50%', display: 'inlineBlock' }, recCph: this.state.recCph }, this.props))
                                )
                            ))
                        ),
                        _react3.default.createElement(
                            FormItem,
                            _extends({
                                label: '\u9886\u7528\u4EBA\uFF1A'
                            }, formItemLayout),
                            getFieldDecorator('recipient', {
                                rules: [{ required: true, message: '该字段不能为空!' }]
                            })(_react3.default.createElement(_input2.default, null))
                        ),
                        _react3.default.createElement(
                            FormItem,
                            _extends({
                                label: '\u8EAB\u4EFD\u8BC1\u53F7\u7801\uFF1A'
                            }, formItemLayout),
                            getFieldDecorator('idNumber', {
                                rules: [{ required: true, message: '该字段不能为空!' }]
                            })(_react3.default.createElement(_input2.default, null))
                        ),
                        _react3.default.createElement(
                            FormItem,
                            _extends({
                                label: '\u6570\u91CF'
                            }, formItemLayout),
                            getFieldDecorator('count', {
                                rules: [{ required: true, message: '必须是数字!' }]
                            })(_react3.default.createElement(_inputNumber2.default, { min: 0, max: 100, defaultValue: 1, onChange: this.onChange.bind(this) }))
                        )
                    )
                )
            );
        }
    }]);

    return YunyingbuIssue;
}(_react3.default.Component));

var WrappedYunyingbuIssue = _form2.default.create()(YunyingbuIssue);
if (document.getElementById("yunyingbuIssue")) _reactDom2.default.render(_react3.default.createElement(WrappedYunyingbuIssue, pageUrls), document.getElementById("yunyingbuIssue"));
exports.default = YunyingbuIssue;
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(17)(module), __webpack_require__(15)))

/***/ }),

/***/ 467:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(module, $) {

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _form = __webpack_require__(33);

var _form2 = _interopRequireDefault(_form);

var _table = __webpack_require__(29);

var _table2 = _interopRequireDefault(_table);

var _button = __webpack_require__(23);

var _button2 = _interopRequireDefault(_button);

var _inputNumber = __webpack_require__(50);

var _inputNumber2 = _interopRequireDefault(_inputNumber);

var _modal = __webpack_require__(41);

var _modal2 = _interopRequireDefault(_modal);

var _icon = __webpack_require__(36);

var _icon2 = _interopRequireDefault(_icon);

var _input = __webpack_require__(35);

var _input2 = _interopRequireDefault(_input);

var _datePicker = __webpack_require__(39);

var _datePicker2 = _interopRequireDefault(_datePicker);

var _index = __webpack_require__(22);

var _index2 = _interopRequireDefault(_index);

var _index3 = __webpack_require__(20);

var _index4 = _interopRequireDefault(_index3);

var _react2 = __webpack_require__(0);

var _react3 = _interopRequireDefault(_react2);

var _index5 = __webpack_require__(21);

var _index6 = _interopRequireDefault(_index5);

var _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

__webpack_require__(34);

__webpack_require__(30);

__webpack_require__(26);

__webpack_require__(51);

__webpack_require__(42);

__webpack_require__(111);

__webpack_require__(27);

__webpack_require__(40);

var _reactDom = __webpack_require__(11);

var _reactDom2 = _interopRequireDefault(_reactDom);

var _Sorter = __webpack_require__(32);

var _Sorter2 = _interopRequireDefault(_Sorter);

var _Filters = __webpack_require__(37);

var _Filters2 = _interopRequireDefault(_Filters);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var _components = {
  EditableCell: {
    displayName: 'EditableCell'
  },
  YunyingbuPurchase: {
    displayName: 'YunyingbuPurchase'
  }
};

var _UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2 = (0, _index6.default)({
  filename: '/Users/song/Downloads/pigeonhole/newProject/components/goods/yunyingbuPurchase.js',
  components: _components,
  locals: [module],
  imports: [_react3.default]
});

var _UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2 = (0, _index4.default)({
  filename: '/Users/song/Downloads/pigeonhole/newProject/components/goods/yunyingbuPurchase.js',
  components: _components,
  locals: [],
  imports: [_react3.default, _index2.default]
});

function _wrapComponent(id) {
  return function (Component) {
    return _UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2(_UsersSongDownloadsPigeonholeNewProjectNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2(Component, id), id);
  };
}

var FormItem = _form2.default.Item;
var MonthPicker = _datePicker2.default.MonthPicker,
    RangePicker = _datePicker2.default.RangePicker;
var TextArea = _input2.default.TextArea;

var dateFormat = 'YYYY/MM/DD';
var monthFormat = 'YYYY/MM';

var EditableCell = _wrapComponent('EditableCell')(function (_React$Component) {
  _inherits(EditableCell, _React$Component);

  function EditableCell(props) {
    _classCallCheck(this, EditableCell);

    var _this = _possibleConstructorReturn(this, (EditableCell.__proto__ || Object.getPrototypeOf(EditableCell)).call(this, props));

    _this.state = {
      value: _this.props.value,
      editable: false
    };
    _this.value = "";
    return _this;
  }

  _createClass(EditableCell, [{
    key: 'handleChange',
    value: function handleChange(e) {
      var value = e.target.value;
      this.setState({ value: value });
      this.value = value;
    }
  }, {
    key: 'check',
    value: function check(e) {
      var updateStorageObj = {};
      updateStorageObj[this.props.recData[this.props.index].itemId] = this.value;
      $.ajax({
        url: this.props.updateStorageUrl,
        type: "POST",
        dataType: 'json',
        data: JSON.stringify(updateStorageObj),
        contentType: 'application/json',
        success: function (data) {
          if (data.status > 0) {
            this.setState({ editable: false });
            if (this.props.onChange) {
              this.props.onChange(this.state.value);
            }
          } else {
            _modal2.default.error({
              title: '错误信息',
              content: data.message
            });
          }
        }.bind(this),
        error: function error() {
          alert("请求失败");
        }
      });
    }
  }, {
    key: 'edit',
    value: function edit() {
      this.setState({ editable: true });
    }
  }, {
    key: 'render',
    value: function render() {
      var _state = this.state,
          value = _state.value,
          editable = _state.editable;

      return _react3.default.createElement(
        'div',
        { className: 'editable-cell' },
        editable ? _react3.default.createElement(
          'div',
          { className: 'editable-cell-input-wrapper' },
          _react3.default.createElement(_input2.default, {
            value: value,
            onChange: this.handleChange.bind(this),
            onPressEnter: this.check.bind(this)
          }),
          _react3.default.createElement(_icon2.default, {
            type: 'check',
            className: 'editable-cell-icon-check',
            onClick: this.check.bind(this)
          })
        ) : _react3.default.createElement(
          'div',
          { className: 'editable-cell-text-wrapper' },
          value || ' ',
          _react3.default.createElement(_icon2.default, {
            type: 'edit',
            className: 'editable-cell-icon',
            onClick: this.edit.bind(this)
          })
        )
      );
    }
  }]);

  return EditableCell;
}(_react3.default.Component));

var YunyingbuPurchase = _wrapComponent('YunyingbuPurchase')(function (_React$Component2) {
  _inherits(YunyingbuPurchase, _React$Component2);

  function YunyingbuPurchase(props) {
    _classCallCheck(this, YunyingbuPurchase);

    var _this2 = _possibleConstructorReturn(this, (YunyingbuPurchase.__proto__ || Object.getPrototypeOf(YunyingbuPurchase)).call(this, props));

    _this2.state = {
      recData: [], //从后台接收到的数据
      updateStorageIndex: ""
    };
    _this2.key = 0;
    _this2.itemId = "";
    _this2.num = "";
    return _this2;
  }

  _createClass(YunyingbuPurchase, [{
    key: 'componentDidMount',
    value: function componentDidMount() {
      var self = this;
      $.ajax({
        //url:"/goodsList",
        url: self.props.goodsInfoUrl,
        type: "get",
        dataType: 'json',
        contentType: 'application/json',
        success: function (data) {
          if (data) {
            var data = data.data;
            for (var i in data) {
              data[i]["key"] = data[i].itemId;
            }
            self.setState({
              recData: data
            });
          } else {
            recData: "";
          }
        }.bind(self),
        error: function error() {
          alert("请求失败");
        }
      });
    }
  }, {
    key: 'action',
    value: function action(index) {
      //console.log(this.itemId);
      //console.log(this.num);
      if (this.num > 0) {
        window.location.href = this.props.jumpUrl + "?itemId=" + this.itemId + "&num=" + this.num;
      } else {
        _modal2.default.error({
          title: '错误信息',
          content: '采购数量必须大于0'
        });
      }
    }
  }, {
    key: 'onScoreChange',
    value: function onScoreChange(index, value) {
      //console.log(this.state.recData);
      // console.log(index,value)
      var itemId = this.state.recData[index].itemId;
      this.itemId = itemId;
      this.num = value;
    }
  }, {
    key: 'onRemarkChange',
    value: function onRemarkChange(index, value) {
      var remark;
      if (typeof value == 'string' && value.constructor == String) {
        remark = value;
      } else {
        remark = value.target.value;
      }
      console.log(index, remark); //传输数据方式待确认 拼接？ajax？
    }
    //可编辑框 onchange

  }, {
    key: 'onCellChange',
    value: function onCellChange(index, value) {
      //console.log(index,value);
      //库存改完值之后更新页面
      var recData = this.state.recData;
      recData[index].itemTotalNum = value;
      this.setState({
        recData: recData
      });
    }
  }, {
    key: 'render',
    value: function render() {
      var _this3 = this;

      var filterData = new _Filters2.default().filter(this.state.recData);
      var columns = [{
        title: '名称',
        dataIndex: 'itemName',
        key: 'itemName',
        filters: filterData.itemName,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.itemName, b.itemName);
        },
        onFilter: function onFilter(value, record) {
          return record.itemName.indexOf(value) === 0;
        }
      }, {
        title: '型号',
        dataIndex: 'itemType',
        key: 'itemType',
        filters: filterData.itemType,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.itemType, b.itemType);
        },
        onFilter: function onFilter(value, record) {
          return record.itemType.indexOf(value) === 0;
        }
      }, {
        title: '库存',
        dataIndex: 'itemTotalNum',
        key: 'itemTotalNum',
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.itemTotalNum, b.itemTotalNum);
        },
        render: function render(text, record, index) {
          return _react3.default.createElement(EditableCell, _extends({
            recData: _this3.state.recData
          }, pageUrls, {
            value: text,
            index: index,
            onChange: _this3.onCellChange.bind(_this3, index)
          }));
        }
      }, {
        title: '单价',
        dataIndex: 'itemPurchasingPrice',
        key: 'itemPurchasingPrice',
        filters: filterData.itemPurchasingPrice,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.itemPurchasingPrice, b.itemPurchasingPrice);
        },
        onFilter: function onFilter(value, record) {
          return record.itemPurchasingPrice.indexOf(value) === 0;
        }
      }, {
        title: '采购数量',
        dataIndex: 'num',
        key: 'num',
        render: function render(text, record, index) {
          return _react3.default.createElement(_inputNumber2.default, { min: 1, max: 10, defaultValue: 0, onChange: _this3.onScoreChange.bind(_this3, index) });
        }
      }, {
        title: '备注',
        dataIndex: 'remark',
        key: 'remark',
        render: function render(text, record, index) {
          return _react3.default.createElement(TextArea, { autosize: { minRows: 1 }, onChange: _this3.onRemarkChange.bind(_this3, index) });
        }
      }, {
        title: '采购',
        render: function render(text, record, index) {
          return _react3.default.createElement(
            _button2.default,
            { onClick: _this3.action.bind(_this3, index) },
            '\u5165\u5E93'
          );
        }
      }];
      return _react3.default.createElement(
        'div',
        null,
        _react3.default.createElement(_table2.default, { bordered: true, key: this.key++, columns: columns, pagination: false, dataSource: this.state.recData })
      );
    }
  }]);

  return YunyingbuPurchase;
}(_react3.default.Component));

var WrappedYunyingbuPurchase = _form2.default.create()(YunyingbuPurchase);
if (document.getElementById("yunyingbuPurchase")) _reactDom2.default.render(_react3.default.createElement(WrappedYunyingbuPurchase, pageUrls), document.getElementById("yunyingbuPurchase"));
exports.default = YunyingbuPurchase;
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(17)(module), __webpack_require__(15)))

/***/ }),

/***/ 571:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


__webpack_require__(463);
__webpack_require__(464);
__webpack_require__(465);
__webpack_require__(466);
__webpack_require__(467);
__webpack_require__(462);

/***/ })

},[571]);