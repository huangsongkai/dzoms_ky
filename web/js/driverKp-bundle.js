webpackJsonp([5],{

/***/ 443:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(module, $) {

var _css = __webpack_require__(31);

var _table = __webpack_require__(30);

var _table2 = _interopRequireDefault(_table);

var _css2 = __webpack_require__(37);

var _datePicker = __webpack_require__(36);

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

var _Sorter = __webpack_require__(44);

var _Sorter2 = _interopRequireDefault(_Sorter);

__webpack_require__(98);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var _components = {
  CarTable: {
    displayName: 'CarTable'
  }
};

var _DReactNewProjectNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2 = (0, _index6.default)({
  filename: 'D:/react/newProject/components/car/CarTable.js',
  components: _components,
  locals: [module],
  imports: [_react3.default]
});

var _DReactNewProjectNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2 = (0, _index4.default)({
  filename: 'D:/react/newProject/components/car/CarTable.js',
  components: _components,
  locals: [],
  imports: [_react3.default, _index2.default]
});

function _wrapComponent(id) {
  return function (Component) {
    return _DReactNewProjectNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2(_DReactNewProjectNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2(Component, id), id);
  };
}

var MonthPicker = _datePicker2.default.MonthPicker,
    RangePicker = _datePicker2.default.RangePicker;

// moment.locale('zh-cn');
var _sorter = new _Sorter2.default();
var columns = [{
  title: '序号',
  dataIndex: 'index',
  render: function render(value, record, index) {
    return React.createElement(
      'span',
      null,
      ++index
    );
  }
}, {
  title: '分公司',
  dataIndex: 'dept',
  filters: [{ text: '一部', value: '一部' }, { text: '二部', value: '二部' }, { text: '三部', value: '三部' }],
  filterMultiple: false,
  onFilter: function onFilter(value, record) {
    return record.dept.indexOf(value) === 0;
  },
  sorter: function sorter(a, b) {
    return _sorter.sortFgs(a.dept, b.dept);
  }
}, {
  title: '车牌号',
  dataIndex: 'licenseNum',
  sorter: function sorter(a, b) {
    return _sorter.sort(a.licenseNum, b.licenseNum);
  }
}, {
  title: '合同到期时间',
  dataIndex: 'contractEndDate',
  sorter: function sorter(a, b) {
    return _sorter.sort(a.contractEndDate, b.contractEndDate);
  }
}, {
  title: '合同状态',
  dataIndex: 'state'
}, {
  title: '驾驶员',
  dataIndex: 'name',
  sorter: function sorter(a, b) {
    return _sorter.sort(a.name, b.name);
  }
}, {
  title: '电话',
  dataIndex: 'phone',
  sorter: function sorter(a, b) {
    return _sorter.sort(a.phone, b.phone);
  }
}, {
  title: '操作',
  render: function render(i) {
    return React.createElement(
      'div',
      null,
      React.createElement(
        'a',
        { href: "/DZOMS/vehicle/CreateApproval/vehicle_approval01.jsp?oldLicenseNum=" + i.licenseNum },
        '\u66F4\u65B0'
      ),
      '\xA0\xA0\xA0',
      React.createElement(
        'a',
        { href: "/DZOMS/vehicle/AbandonApproval/vehicle_abandon01.jsp?licenseNum=" + i.licenseNum },
        '\u5E9F\u4E1A'
      )
    );
  }
}];
var data = [];

function onChange(pagination, filters, sorter) {
  console.log('params', pagination, filters, sorter);
}

var CarTable = _wrapComponent('CarTable')(function (_React$Component) {
  _inherits(CarTable, _React$Component);

  function CarTable(props) {
    _classCallCheck(this, CarTable);

    var _this = _possibleConstructorReturn(this, (CarTable.__proto__ || Object.getPrototypeOf(CarTable)).call(this, props));

    _this.state = {
      data: [],
      loading: true
    };
    return _this;
  }

  _createClass(CarTable, [{
    key: 'componentDidMount',
    value: function componentDidMount() {
      var self = this;
      $.get("/DZOMS/ky/car/list", function (data) {
        self.setState({
          data: data.data,
          loading: false
        });
      });
    }
  }, {
    key: 'monthChange',
    value: function monthChange(date, dateString) {
      var self = this;
      self.setState({
        loading: true
      });
      $.get("/DZOMS/ky/driverKp/dtoList/" + dateString, function (data) {
        self.setState({
          data: data.data,
          loading: false
        });
      });
    }
  }, {
    key: 'render',
    value: function render() {
      return React.createElement(
        'div',
        null,
        React.createElement(
          'div',
          { style: { font: 'bold', fontSize: '18px', textAlign: 'center' } },
          '\u5E93\u505C\u8F66\u7BA1\u7406'
        ),
        React.createElement(_table2.default, { style: { textAlign: 'center' }, size: 'middle', columns: columns, dataSource: this.state.data, pagination: false, loading: this.state.loading,
          onChange: onChange })
      );
    }
  }]);

  return CarTable;
}(React.Component));

if (document.getElementById("CarTable")) ReactDOM.render(React.createElement(CarTable, null), document.getElementById("CarTable"));
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(16)(module), __webpack_require__(17)))

/***/ }),

/***/ 444:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(module, $) {

var _css = __webpack_require__(31);

var _table = __webpack_require__(30);

var _table2 = _interopRequireDefault(_table);

var _css2 = __webpack_require__(49);

var _select = __webpack_require__(43);

var _select2 = _interopRequireDefault(_select);

var _index = __webpack_require__(21);

var _index2 = _interopRequireDefault(_index);

var _index3 = __webpack_require__(19);

var _index4 = _interopRequireDefault(_index3);

var _react2 = __webpack_require__(0);

var _react3 = _interopRequireDefault(_react2);

var _index5 = __webpack_require__(20);

var _index6 = _interopRequireDefault(_index5);

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

var _Sorter = __webpack_require__(44);

var _Sorter2 = _interopRequireDefault(_Sorter);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var _components = {
  JiaShiYuanBaiFenTable: {
    displayName: 'JiaShiYuanBaiFenTable'
  }
};

var _DReactNewProjectNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2 = (0, _index6.default)({
  filename: 'D:/react/newProject/components/driverKp/DriverKpTable.js',
  components: _components,
  locals: [module],
  imports: [_react3.default]
});

var _DReactNewProjectNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2 = (0, _index4.default)({
  filename: 'D:/react/newProject/components/driverKp/DriverKpTable.js',
  components: _components,
  locals: [],
  imports: [_react3.default, _index2.default]
});

function _wrapComponent(id) {
  return function (Component) {
    return _DReactNewProjectNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2(_DReactNewProjectNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2(Component, id), id);
  };
}

// const { MonthPicker, RangePicker } = DatePicker;
// import 'moment/locale/zh-cn';
// moment.locale('zh-cn');
var _sorter = new _Sorter2.default();
var date = new Date();
var year = date.getFullYear();
var years = [year, year - 1, year - 2, year - 3, year - 4];

var calc = function calc(col, total, ratio) {
  var isOwner = arguments.length > 3 && arguments[3] !== undefined ? arguments[3] : -1;

  if (isOwner == 0) {
    return 0;
  }
  var score = 0;
  if (col == '0') {
    return 0;
  } else {
    score = parseInt(col) * ratio;
  }
  score = score > total ? total : score;
  return score;
};
var columns = [{
  title: '序号',
  dataIndex: 'index',
  render: function render(value, record, index) {
    return React.createElement(
      'span',
      null,
      ++index
    );
  },
  width: 80,
  //sorter: (a, b) => sorter.sortFgs(a.fgs, b.fgs),
  fixed: 'left'
}, {
  title: '公司',
  dataIndex: 'fgs',
  filters: [{ text: '一部', value: '一部' }, { text: '二部', value: '二部' }, { text: '三部', value: '三部' }],
  width: 80,
  filterMultiple: false,
  onFilter: function onFilter(value, record) {
    return record.fgs.indexOf(value) === 0;
  },
  sorter: function sorter(a, b) {
    return _sorter.sortFgs(a.fgs, b.fgs);
  },
  fixed: 'left'
}, {
  title: '姓名',
  width: 80,
  dataIndex: 'xm',
  // filters: [
  // { text: '黄嵩凯', value: '黄嵩凯' },
  //   { text: '姜雪威', value: '姜雪威' }],
  // onFilter: (value, record) => record.xm.indexOf(value) === 0,
  sorter: function sorter(a, b) {
    return _sorter.sort(a.xm, b.xm);
  },
  fixed: 'left'
}, {
  title: '车主',
  dataIndex: 'isOwner',
  render: function render(text) {
    return text == 1 ? React.createElement(
      'span',
      null,
      '\u662F'
    ) : React.createElement(
      'span',
      null,
      '\u5426'
    );
  },
  fixed: 'left',
  width: 80
}, {
  title: '主副驾',
  dataIndex: 'zfj',
  sorter: function sorter(a, b) {
    return _sorter.sort(a.zfj, b.zfj);
  },
  width: 80
}, {
  title: '参与评选',
  dataIndex: 'isNew',
  render: function render(text) {
    return text == 0 ? React.createElement(
      'span',
      null,
      '\u662F'
    ) : React.createElement(
      'span',
      null,
      '\u5426'
    );
  },
  sorter: function sorter(a, b) {
    return _sorter.sort(a.isNew, b.isNew);
  },
  width: 80
}, {
  title: '车牌号',
  dataIndex: 'cph',
  // filters: [
  // { text: '一公司', value: '一公司' },
  //   { text: '二公司', value: '二公司' }],
  // onFilter: (value, record) => record.name.indexOf(value) === 0,
  sorter: function sorter(a, b) {
    return _sorter.sort(a.cph, b.cph);
  },
  width: 100
}, {
  title: '租金迟交',
  dataIndex: 'zj',
  sorter: function sorter(a, b) {
    return _sorter.sort(a.zj, b.zj);
  },
  width: 80
}, {
  title: '小分',
  width: 80,
  sorter: function sorter(a, b) {
    return _sorter.sort(a.zj_score, b.zj_score);
  },
  dataIndex: 'zj_score'
}, {
  title: '法律诉讼',
  dataIndex: 'law',
  sorter: function sorter(a, b) {
    return _sorter.sort(a.law, b.law);
  },
  width: 80
}, {
  title: '小分',
  width: 80,
  render: function render() {
    return 0;
  }
}, {
  title: '保险迟交',
  dataIndex: 'insurance',
  sorter: function sorter(a, b) {
    return _sorter.sort(a.insurance, b.insurance);
  },
  width: 80
}, {
  title: '小分',
  width: 80,
  render: function render() {
    return 0;
  }
}, {
  title: '投诉',
  dataIndex: 'ts',
  sorter: function sorter(a, b) {
    return _sorter.sort(a.ts, b.ts);
  },
  width: 80
}, {
  title: '小分',
  dataIndex: 'ts_score',
  sorter: function sorter(a, b) {
    return _sorter.sort(a.ts_score, b.ts_score);
  },
  width: 80
}, {
  title: '事故',
  dataIndex: 'sg',
  sorter: function sorter(a, b) {
    return _sorter.sort(a.sg, b.sg);
  },
  width: 80
}, {
  title: '小分',
  dataIndex: 'sg_score',
  sorter: function sorter(a, b) {
    return _sorter.sort(a.sg_score, b.sg_score);
  },
  width: 80
}, {
  title: '电子违章',
  dataIndex: 'wz',
  sorter: function sorter(a, b) {
    return _sorter.sort(a.wz, b.wz);
  },
  width: 80
}, {
  title: '小分',
  width: 80,
  sorter: function sorter(a, b) {
    return _sorter.sort(a.wz_score, b.wz_score);
  },
  dataIndex: 'wz_score'
}, {
  title: '路检',
  dataIndex: 'lj',
  sorter: function sorter(a, b) {
    return _sorter.sort(a.lj, b.lj);
  },
  width: 80
}, {
  title: '小分',
  width: 80,
  sorter: function sorter(a, b) {
    return a.lj_score - b.lj_score;
  },
  dataIndex: 'lj_score'
}, {
  title: '例会缺席',
  dataIndex: 'lh',
  sorter: function sorter(a, b) {
    return _sorter.sort(a.lh, b.lh);
  },
  width: 80
}, {
  title: '小分',
  width: 80,
  sorter: function sorter(a, b) {
    return _sorter.sort(a.lh_score, b.lh_score);
  },
  dataIndex: 'lh_score'
}, {
  title: '减分总评',
  dataIndex: 'score',
  sorter: function sorter(a, b) {
    return _sorter.sort(a.score, b.score);
  },
  render: function render(text, record, index) {
    return record.isNew == 0 ? React.createElement(
      'div',
      { style: { backgroundColor: '#00FFCC' } },
      record.score
    ) : React.createElement(
      'div',
      { style: { backgroundColor: 'grey' } },
      record.score
    );
  },
  width: 80
}, {
  title: '参加活动',
  dataIndex: 'hd',
  sorter: function sorter(a, b) {
    return _sorter.sort(a.hd, b.hd);
  },
  width: 80
}, {
  title: '小分',
  width: 80,
  dataIndex: 'hd_score'
}, {
  title: '媒体表扬',
  dataIndex: 'mt',
  sorter: function sorter(a, b) {
    return _sorter.sort(a.mt, b.mt);
  },
  width: 80
}, {
  title: '小分',
  width: 80,
  dataIndex: 'mt_score'
}, {
  title: '乘客表彰',
  dataIndex: 'by',
  sorter: function sorter(a, b) {
    return _sorter.sort(a.by, b.by);
  },
  width: 80
}, {
  title: '小分',
  width: 80,
  dataIndex: 'by_score'
}, {
  title: '二维码',
  dataIndex: 'pay',
  sorter: function sorter(a, b) {
    return _sorter.sort(a.by, b.by);
  },
  render: function render(text, record) {
    return text || 0;
  },
  width: 80
}, {
  title: '小分',
  width: 80,
  dataIndex: 'pay_score',
  render: function render(text, record) {
    return 0;
  }
}, {
  title: '加分总评',
  dataIndex: 'score2',
  // sorter: (a, b) => sorter.sort(a.by, b.by),
  render: function render(text, record, index) {
    return record.isNew == 0 ? React.createElement(
      'div',
      { style: { backgroundColor: 'red' } },
      record.score2 || 0
    ) : React.createElement(
      'div',
      { style: { backgroundColor: 'grey' } },
      record.score2 || 0
    );
  },
  width: 80
}];
var data = [];

function onChange(pagination, filters, sorter) {
  console.log('params', pagination, filters, sorter);
}

var JiaShiYuanBaiFenTable = _wrapComponent('JiaShiYuanBaiFenTable')(function (_React$Component) {
  _inherits(JiaShiYuanBaiFenTable, _React$Component);

  function JiaShiYuanBaiFenTable(props) {
    _classCallCheck(this, JiaShiYuanBaiFenTable);

    var _this = _possibleConstructorReturn(this, (JiaShiYuanBaiFenTable.__proto__ || Object.getPrototypeOf(JiaShiYuanBaiFenTable)).call(this, props));

    _this.state = {
      data: [],
      loading: true
    };
    return _this;
  }

  _createClass(JiaShiYuanBaiFenTable, [{
    key: 'componentDidMount',
    value: function componentDidMount() {
      var self = this;
      $.get("/DZOMS/ky/driverKp/dtoList/" + years[1], function (data) {
        var records = data.data;
        for (var i in records) {
          var record = records[i];
          record['zj_score'] = calc(record.zj, 20, 5, record.isOwner);
          record['ts_score'] = calc(record.ts, 20, 5);
          record['sg_score'] = calc(record.sg, 30, 5, record.isOwner);
          record['wz_score'] = calc(record.wz, 20, 5, record.isOwner);
          record['lj_score'] = calc(record.lj, 20, 5, record.isOwner);
          record['lh_score'] = calc(record.lh, 10, 2);
          record['score'] = 100 - record['zj_score'] - record['ts_score'] - record['sg_score'] - record['wz_score'] - record['lj_score'] - record['lh_score'];
          record['hd_score'] = calc(record.hd, 5, 2);
          record['mt_score'] = calc(record.mt, 10, 5);
          record['by_score'] = calc(record.by, 5, 2);
          record['score2'] = record['hd_score'] + record['mt_score'] + record['by_score'];
        }
        self.setState({
          data: records,
          loading: false
        });
      });
    }
  }, {
    key: 'handleChange',
    value: function handleChange(dateString) {
      var self = this;
      self.setState({
        loading: true
      });
      $.get("/DZOMS/ky/driverKp/dtoList/" + dateString, function (data) {
        var records = data.data;
        console.log(data.data);
        for (var i in records) {
          var record = records[i];
          record['zj_score'] = calc(record.zj, 20, 5, record.isOwner);
          record['ts_score'] = calc(record.ts, 20, 5);
          record['sg_score'] = calc(record.sg, 30, 5, record.isOwner);
          record['wz_score'] = calc(record.wz, 20, 5, record.isOwner);
          record['lj_score'] = calc(record.lj, 20, 5, record.isOwner);
          record['lh_score'] = calc(record.lj, 10, 2);
          record['score'] = 100 - record['zj_score'] - record['ts_score'] - record['sg_score'] - record['wz_score'] - record['lj_score'] - record['lh_score'];
          record['hd_score'] = calc(record.hd, 5, 2);
          record['mt_score'] = calc(record.mt, 10, 5);
          record['by_score'] = calc(record.by, 5, 2);
          record['score2'] = record['hd_score'] + record['mt_score'] + record['by_score'];
        }
        self.setState({
          data: records,
          loading: false
        });
      });
    }
  }, {
    key: 'render',
    value: function render() {
      return React.createElement(
        'div',
        null,
        React.createElement(
          'div',
          { style: { font: 'bold', fontSize: '18px', textAlign: 'center' } },
          '\u9A7E\u9A76\u5458\u767E\u5206\u8003\u6838'
        ),
        React.createElement(
          _select2.default,
          {
            style: { width: 200 },
            placeholder: '\u9009\u62E9\u5E74\u4EFD',
            defaultValue: years[1],
            onChange: this.handleChange.bind(this)
          },
          React.createElement(
            Option,
            { value: years[0] },
            years[0]
          ),
          React.createElement(
            Option,
            { value: years[1] },
            years[1]
          ),
          React.createElement(
            Option,
            { value: years[2] },
            years[2]
          ),
          React.createElement(
            Option,
            { value: years[3] },
            years[3]
          ),
          React.createElement(
            Option,
            { value: years[4] },
            years[4]
          )
        ),
        React.createElement(_table2.default, { style: { textAlign: 'center' }, scroll: { x: 2800, y: 800 }, size: 'middle', columns: columns, dataSource: this.state.data, pagination: false, loading: this.state.loading,
          onChange: onChange })
      );
    }
  }]);

  return JiaShiYuanBaiFenTable;
}(React.Component));

if (document.getElementById("root")) ReactDOM.render(React.createElement(JiaShiYuanBaiFenTable, null), document.getElementById("root"));
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(16)(module), __webpack_require__(17)))

/***/ }),

/***/ 549:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


__webpack_require__(444);
__webpack_require__(443);

/***/ })

},[549]);