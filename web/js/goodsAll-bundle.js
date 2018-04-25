webpackJsonp([3],{

/***/ 101:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
  value: true
});

var _form = __webpack_require__(29);

var _form2 = _interopRequireDefault(_form);

var _row = __webpack_require__(83);

var _row2 = _interopRequireDefault(_row);

var _button = __webpack_require__(21);

var _button2 = _interopRequireDefault(_button);

var _col = __webpack_require__(81);

var _col2 = _interopRequireDefault(_col);

var _datePicker = __webpack_require__(36);

var _datePicker2 = _interopRequireDefault(_datePicker);

var _select = __webpack_require__(38);

var _select2 = _interopRequireDefault(_select);

var _input = __webpack_require__(28);

var _input2 = _interopRequireDefault(_input);

var _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };

__webpack_require__(30);

__webpack_require__(84);

__webpack_require__(25);

__webpack_require__(82);

__webpack_require__(37);

__webpack_require__(39);

__webpack_require__(26);

var _react = __webpack_require__(0);

var _react2 = _interopRequireDefault(_react);

var _propTypes = __webpack_require__(2);

var _propTypes2 = _interopRequireDefault(_propTypes);

var _moment = __webpack_require__(1);

var _moment2 = _interopRequireDefault(_moment);

var _FilterItem = __webpack_require__(120);

var _queryString = __webpack_require__(92);

var _queryString2 = _interopRequireDefault(_queryString);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var InputGroup = _input2.default.Group;
var Option = _select2.default.Option;
var Search = _input2.default.Search;
var pageSize = 20;
var RangePicker = _datePicker2.default.RangePicker;

var ColProps = {
  xs: 24,
  sm: 12,
  style: {
    marginBottom: 16
  }
};
var SearchBar = function SearchBar(_ref) {
  var options = _ref.options,
      downloadUrl = _ref.downloadUrl,
      _ref$form = _ref.form,
      getFieldDecorator = _ref$form.getFieldDecorator,
      getFieldsValue = _ref$form.getFieldsValue,
      setFieldsValue = _ref$form.setFieldsValue;

  var query = _queryString2.default.parse(window.location.search) || '';
  options = options || [{ field: 'id', alias: '身份证' }, { field: 'name', alias: '名称' }];
  var queryField = "";
  for (var i in options) {
    if (typeof query[options[i].field] != "undefined") queryField = options[i].field;
  }
  var handleFields = function handleFields(fields) {
    var createTime = fields.createTime,
        field = fields.field,
        value = fields.value;

    if (createTime && createTime.length) {
      fields.createTime = [createTime[0].format('YYYY-MM-DD'), createTime[1].format('YYYY-MM-DD')];
    }
    return fields;
  };

  var handleSubmit = function handleSubmit() {
    var fields = getFieldsValue();
    fields = handleFields(fields);
    search(fields);
  };

  var download = function download() {
    window.open(downloadUrl + window.location.search);
  };

  var search = function search(fields) {
    var params = getParams(fields);
    window.location = window.location.pathname + "?" + _queryString2.default.stringify(params);
  };

  var getParams = function getParams(fields) {
    var params = {};
    for (var _i in query) {
      params[_i] = query[_i];
    }
    for (var i in options) {
      delete params[options[i].field];
    }
    if (typeof fields['field'] != 'undefined') params[fields['field']] = fields['value'];
    delete fields['field'];
    delete fields['value'];
    params = _extends({}, params, { page: 1 }, fields, { pageSize: pageSize });
    return params;
  };

  var handleReset = function handleReset() {
    var fields = getFieldsValue();
    console.log(fields);
    for (var item in fields) {
      if ({}.hasOwnProperty.call(fields, item)) {
        if (fields[item] instanceof Array) {
          fields[item] = [];
        } else {
          fields[item] = undefined;
        }
      }
    }
    setFieldsValue(fields);
    handleSubmit();
  };

  var handleChange = function handleChange(key) {
    return function (values) {
      /*let fields = getFieldsValue()
      fields[key] = values
      fields = handleFields(fields)*/

      console.log(key);
    };
  };
  return _react2.default.createElement(
    _row2.default,
    { gutter: 24 },
    _react2.default.createElement(
      _col2.default,
      _extends({}, ColProps, { xl: { span: 8 }, md: { span: 8 } }),
      _react2.default.createElement(
        'div',
        { style: { display: 'flex', justifyContent: 'space-between', flexWrap: 'wrap' } },
        getFieldDecorator('field', { initialValue: queryField || options[0].field || '' })(_react2.default.createElement(
          _select2.default,
          { style: { width: '30%' }, size: 'large', placeholder: '\u9009\u62E9\u67E5\u8BE2\u5C5E\u6027' },
          options.map(function (item) {
            return _react2.default.createElement(
              Option,
              { key: item.field, value: item.field },
              item.alias
            );
          })
        )),
        getFieldDecorator('value', { initialValue: query[queryField] || '' })(_react2.default.createElement(Search, { placeholder: '\u641C\u7D22', style: { width: '70%', height: 28 }, size: 'large', onSearch: handleSubmit }))
      )
    ),
    _react2.default.createElement(
      _col2.default,
      _extends({}, ColProps, { xl: { span: 6 }, md: { span: 8 }, sm: { span: 12 } }),
      _react2.default.createElement(
        'div',
        { style: { justifyContent: 'space-between', flexWrap: 'wrap' } },
        getFieldDecorator('createTime', { initialValue: query['createTime'] && query['createTime'].map(function (i) {
            return (0, _moment2.default)(i);
          }) || '' })(_react2.default.createElement(RangePicker, { style: { width: '100%' }, size: 'large', onChange: handleChange('createTime') }))
      )
    ),
    _react2.default.createElement(
      _col2.default,
      { xl: { span: 4 }, md: { span: 4 } },
      _react2.default.createElement(
        _button2.default,
        { size: 'large', type: 'primary', style: { marginRight: 10 }, onClick: handleSubmit },
        '\u67E5\u8BE2'
      ),
      _react2.default.createElement(
        _button2.default,
        { size: 'large', onClick: handleReset, style: { marginRight: 10 } },
        '\u6E05\u7A7A'
      ),
      _react2.default.createElement(_button2.default, { type: 'primary', shape: 'circle', icon: 'download', onClick: download })
    )
  );
};
SearchBar.propTypes = {
  // onAdd: PropTypes.func,
  // isMotion: PropTypes.bool,
  // switchIsMotion: PropTypes.func,
  // form: PropTypes.object,
  // filter: PropTypes.object,
  // onFilterChange: PropTypes.func,
};

exports.default = _form2.default.create()(SearchBar);

/***/ }),

/***/ 120:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
  value: true
});

var _react = __webpack_require__(0);

var _react2 = _interopRequireDefault(_react);

var _propTypes = __webpack_require__(2);

var _propTypes2 = _interopRequireDefault(_propTypes);

var _FilterItem = __webpack_require__(235);

var _FilterItem2 = _interopRequireDefault(_FilterItem);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var FilterItem = function FilterItem(_ref) {
  var _ref$label = _ref.label,
      label = _ref$label === undefined ? '' : _ref$label,
      children = _ref.children;

  var labelArray = label.split('');
  return _react2.default.createElement(
    'div',
    { className: _FilterItem2.default.filterItem },
    labelArray.length > 0 ? _react2.default.createElement(
      'div',
      { className: _FilterItem2.default.labelWrap },
      labelArray.map(function (item, index) {
        return _react2.default.createElement(
          'span',
          { className: 'labelText', key: index },
          item
        );
      })
    ) : '',
    _react2.default.createElement(
      'div',
      { className: _FilterItem2.default.item },
      children
    )
  );
};

FilterItem.propTypes = {
  label: _propTypes2.default.string,
  children: _propTypes2.default.element.isRequired
};

exports.default = FilterItem;

/***/ }),

/***/ 121:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(module, $) {

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _select = __webpack_require__(38);

var _select2 = _interopRequireDefault(_select);

var _input = __webpack_require__(28);

var _input2 = _interopRequireDefault(_input);

var _autoComplete = __webpack_require__(148);

var _autoComplete2 = _interopRequireDefault(_autoComplete);

var _index = __webpack_require__(20);

var _index2 = _interopRequireDefault(_index);

var _index3 = __webpack_require__(18);

var _index4 = _interopRequireDefault(_index3);

var _react2 = __webpack_require__(0);

var _react3 = _interopRequireDefault(_react2);

var _index5 = __webpack_require__(19);

var _index6 = _interopRequireDefault(_index5);

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

__webpack_require__(39);

__webpack_require__(26);

__webpack_require__(149);

var _reactDom = __webpack_require__(11);

var _reactDom2 = _interopRequireDefault(_reactDom);

var _SelectInfo = __webpack_require__(70);

var _SelectInfo2 = _interopRequireDefault(_SelectInfo);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var _components = {
  Cph: {
    displayName: 'Cph'
  }
};

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2 = (0, _index6.default)({
  filename: '/Users/huang/work/dzoms_react/components/util/cph.js',
  components: _components,
  locals: [module],
  imports: [_react3.default]
});

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2 = (0, _index4.default)({
  filename: '/Users/huang/work/dzoms_react/components/util/cph.js',
  components: _components,
  locals: [],
  imports: [_react3.default, _index2.default]
});

function _wrapComponent(id) {
  return function (Component) {
    return _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2(_UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2(Component, id), id);
  };
} /*
    组件功能：车牌号的组件
    引用时：<CarNumber {...pageUrls} errorMessage={this.errorMessage.bind(this)}  objCph={this.objCph.bind(this)} />
            函数：
            objCph(objCph){
                this.setState({objCph:objCph});
            }
            errorMessage(errorMessage){
                this.setState({errorMessage:errorMessage});
            }
  */


var AutoCompleteOption = _autoComplete2.default.Option;

var InputGroup = _input2.default.Group;
var Option = _select2.default.Option;

var Cph = _wrapComponent('Cph')(function (_React$Component) {
  _inherits(Cph, _React$Component);

  function Cph(props) {
    _classCallCheck(this, Cph);

    var _this = _possibleConstructorReturn(this, (Cph.__proto__ || Object.getPrototypeOf(Cph)).call(this, props));

    _this.state = {
      recData: [], //后台请求回来的车牌号数组
      district: '黑A',
      number: ''
    };
    return _this;
  }

  _createClass(Cph, [{
    key: 'componentDidMount',
    value: function componentDidMount() {
      /*var self=this;
      $.ajax({
            type:"get",
            url: self.props.chepaihao,
            data: JSON.stringify(self.cphPrefix),
            dataType: 'json',
            contentType : 'application/json',
            success: function(data){ 
                self.setState({
                    recData:data
                });                            
            },
            error: function(data){
               alert("失败");
            }
      }); */
    }
  }, {
    key: 'districtChange',
    value: function districtChange(value) {
      this.setState({ district: value });
    }
  }, {
    key: 'numberChange',
    value: function numberChange(value) {
      /*this.setState({
        dataSource: !value || value.indexOf('@') >= 0 ? [] : [
          `${value}@gmail.com`,
          `${value}@163.com`,
          `${value}@qq.com`,
        ],
      });*/
      var self = this;
      var wholeNumber = self.state.district + value;
      var param = { number: wholeNumber };
      $.ajax({
        type: "get",
        url: self.props.chepaihao,
        data: param,
        dataType: 'json',
        contentType: 'application/json',
        success: function success(data) {
          var data2 = data.data.map(function (i) {
            if (i.indexOf('黑') > -1) return i.substring(2);
            return i;
          });
          self.setState({
            dataSource: data2
          });
        },
        error: function error(data) {
          alert("失败");
        }
      });
      if (this.props.onChange) {
        this.props.onChange(wholeNumber);
      }
    }
  }, {
    key: 'selectInfoErrorMessage',
    value: function selectInfoErrorMessage(errorMessage) {
      this.setState({
        errorMessage: errorMessage
      });
      this.props.errorMessage(errorMessage);
    }
  }, {
    key: 'handleChange',
    value: function handleChange(value) {
      this.setState({
        dataSource: !value || value.indexOf('@') >= 0 ? [] : [value + '@gmail.com', value + '@163.com', value + '@qq.com']
      });
    }
  }, {
    key: 'render',
    value: function render() {
      return _react3.default.createElement(
        InputGroup,
        { compact: true, style: { margin: 5, height: 40, width: 350, overflow: 'hidden' } },
        _react3.default.createElement(
          _select2.default,
          { defaultValue: '\u9ED1A', onChange: this.districtChange.bind(this) },
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
        _react3.default.createElement(_autoComplete2.default, {
          dataSource: this.state.dataSource,
          style: { width: 200 },
          onChange: this.numberChange.bind(this),
          value: this.props.value && this.props.value.substring(2)
        })
      );
    }
  }]);

  return Cph;
}(_react3.default.Component));

exports.default = Cph;
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(14)(module), __webpack_require__(16)))

/***/ }),

/***/ 147:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
    value: true
});

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

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var InputElement = function (_React$Component) {
    (0, _inherits3['default'])(InputElement, _React$Component);

    function InputElement() {
        (0, _classCallCheck3['default'])(this, InputElement);

        var _this = (0, _possibleConstructorReturn3['default'])(this, (InputElement.__proto__ || Object.getPrototypeOf(InputElement)).apply(this, arguments));

        _this.focus = function () {
            _this.ele.focus ? _this.ele.focus() : (0, _reactDom.findDOMNode)(_this.ele).focus();
        };
        _this.blur = function () {
            _this.ele.blur ? _this.ele.blur() : (0, _reactDom.findDOMNode)(_this.ele).blur();
        };
        _this.saveRef = function (ele) {
            _this.ele = ele;
            var childRef = _this.props.children.ref;
            if (typeof childRef === 'function') {
                childRef(ele);
            }
        };
        return _this;
    }

    (0, _createClass3['default'])(InputElement, [{
        key: 'render',
        value: function render() {
            return _react2['default'].cloneElement(this.props.children, (0, _extends3['default'])({}, this.props, { ref: this.saveRef }), null);
        }
    }]);
    return InputElement;
}(_react2['default'].Component);

exports['default'] = InputElement;
module.exports = exports['default'];

/***/ }),

/***/ 148:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
    value: true
});

var _typeof2 = __webpack_require__(45);

var _typeof3 = _interopRequireDefault(_typeof2);

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

var _rcSelect = __webpack_require__(212);

var _classnames = __webpack_require__(9);

var _classnames2 = _interopRequireDefault(_classnames);

var _select = __webpack_require__(38);

var _select2 = _interopRequireDefault(_select);

var _input = __webpack_require__(28);

var _input2 = _interopRequireDefault(_input);

var _InputElement = __webpack_require__(147);

var _InputElement2 = _interopRequireDefault(_InputElement);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

function isSelectOptionOrSelectOptGroup(child) {
    return child && child.type && (child.type.isSelectOption || child.type.isSelectOptGroup);
}

var AutoComplete = function (_React$Component) {
    (0, _inherits3['default'])(AutoComplete, _React$Component);

    function AutoComplete() {
        (0, _classCallCheck3['default'])(this, AutoComplete);

        var _this = (0, _possibleConstructorReturn3['default'])(this, (AutoComplete.__proto__ || Object.getPrototypeOf(AutoComplete)).apply(this, arguments));

        _this.getInputElement = function () {
            var children = _this.props.children;

            var element = children && _react2['default'].isValidElement(children) && children.type !== _rcSelect.Option ? _react2['default'].Children.only(_this.props.children) : _react2['default'].createElement(_input2['default'], null);
            var elementProps = (0, _extends3['default'])({}, element.props);
            // https://github.com/ant-design/ant-design/pull/7742
            delete elementProps.children;
            return _react2['default'].createElement(
                _InputElement2['default'],
                elementProps,
                element
            );
        };
        return _this;
    }

    (0, _createClass3['default'])(AutoComplete, [{
        key: 'render',
        value: function render() {
            var _classNames;

            var _props = this.props,
                size = _props.size,
                _props$className = _props.className,
                className = _props$className === undefined ? '' : _props$className,
                notFoundContent = _props.notFoundContent,
                prefixCls = _props.prefixCls,
                optionLabelProp = _props.optionLabelProp,
                dataSource = _props.dataSource,
                children = _props.children;

            var cls = (0, _classnames2['default'])((_classNames = {}, (0, _defineProperty3['default'])(_classNames, prefixCls + '-lg', size === 'large'), (0, _defineProperty3['default'])(_classNames, prefixCls + '-sm', size === 'small'), (0, _defineProperty3['default'])(_classNames, className, !!className), (0, _defineProperty3['default'])(_classNames, prefixCls + '-show-search', true), (0, _defineProperty3['default'])(_classNames, prefixCls + '-auto-complete', true), _classNames));
            var options = void 0;
            var childArray = _react2['default'].Children.toArray(children);
            if (childArray.length && isSelectOptionOrSelectOptGroup(childArray[0])) {
                options = children;
            } else {
                options = dataSource ? dataSource.map(function (item) {
                    if (_react2['default'].isValidElement(item)) {
                        return item;
                    }
                    switch (typeof item === 'undefined' ? 'undefined' : (0, _typeof3['default'])(item)) {
                        case 'string':
                            return _react2['default'].createElement(
                                _rcSelect.Option,
                                { key: item },
                                item
                            );
                        case 'object':
                            return _react2['default'].createElement(
                                _rcSelect.Option,
                                { key: item.value },
                                item.text
                            );
                        default:
                            throw new Error('AutoComplete[dataSource] only supports type `string[] | Object[]`.');
                    }
                }) : [];
            }
            return _react2['default'].createElement(
                _select2['default'],
                (0, _extends3['default'])({}, this.props, { className: cls, mode: 'combobox', optionLabelProp: optionLabelProp, getInputElement: this.getInputElement, notFoundContent: notFoundContent }),
                options
            );
        }
    }]);
    return AutoComplete;
}(_react2['default'].Component);

exports['default'] = AutoComplete;

AutoComplete.Option = _rcSelect.Option;
AutoComplete.OptGroup = _rcSelect.OptGroup;
AutoComplete.defaultProps = {
    prefixCls: 'ant-select',
    transitionName: 'slide-up',
    optionLabelProp: 'children',
    choiceTransitionName: 'zoom',
    showSearch: false,
    filterOption: false
};
module.exports = exports['default'];

/***/ }),

/***/ 149:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


__webpack_require__(24);

__webpack_require__(236);

__webpack_require__(39);

/***/ }),

/***/ 155:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(module, $) {

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _select = __webpack_require__(38);

var _select2 = _interopRequireDefault(_select);

var _index = __webpack_require__(20);

var _index2 = _interopRequireDefault(_index);

var _index3 = __webpack_require__(18);

var _index4 = _interopRequireDefault(_index3);

var _react2 = __webpack_require__(0);

var _react3 = _interopRequireDefault(_react2);

var _index5 = __webpack_require__(19);

var _index6 = _interopRequireDefault(_index5);

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

__webpack_require__(39);

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

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2 = (0, _index6.default)({
  filename: '/Users/huang/work/dzoms_react/components/util/Select.js',
  components: _components,
  locals: [module],
  imports: [_react3.default]
});

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2 = (0, _index4.default)({
  filename: '/Users/huang/work/dzoms_react/components/util/Select.js',
  components: _components,
  locals: [],
  imports: [_react3.default, _index2.default]
});

function _wrapComponent(id) {
  return function (Component) {
    return _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2(_UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2(Component, id), id);
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
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(14)(module), __webpack_require__(16)))

/***/ }),

/***/ 197:
/***/ (function(module, exports, __webpack_require__) {

"use strict";

var token = '%[a-f0-9]{2}';
var singleMatcher = new RegExp(token, 'gi');
var multiMatcher = new RegExp('(' + token + ')+', 'gi');

function decodeComponents(components, split) {
	try {
		// Try to decode the entire string first
		return decodeURIComponent(components.join(''));
	} catch (err) {
		// Do nothing
	}

	if (components.length === 1) {
		return components;
	}

	split = split || 1;

	// Split the array in 2 parts
	var left = components.slice(0, split);
	var right = components.slice(split);

	return Array.prototype.concat.call([], decodeComponents(left), decodeComponents(right));
}

function decode(input) {
	try {
		return decodeURIComponent(input);
	} catch (err) {
		var tokens = input.match(singleMatcher);

		for (var i = 1; i < tokens.length; i++) {
			input = decodeComponents(tokens, i).join('');

			tokens = input.match(singleMatcher);
		}

		return input;
	}
}

function customDecodeURIComponent(input) {
	// Keep track of all the replacements and prefill the map with the `BOM`
	var replaceMap = {
		'%FE%FF': '\uFFFD\uFFFD',
		'%FF%FE': '\uFFFD\uFFFD'
	};

	var match = multiMatcher.exec(input);
	while (match) {
		try {
			// Decode as big chunks as possible
			replaceMap[match[0]] = decodeURIComponent(match[0]);
		} catch (err) {
			var result = decode(match[0]);

			if (result !== match[0]) {
				replaceMap[match[0]] = result;
			}
		}

		match = multiMatcher.exec(input);
	}

	// Add `%C2` at the end of the map to make sure it does not replace the combinator before everything else
	replaceMap['%C2'] = '\uFFFD';

	var entries = Object.keys(replaceMap);

	for (var i = 0; i < entries.length; i++) {
		// Replace all decoded components
		var key = entries[i];
		input = input.replace(new RegExp(key, 'g'), replaceMap[key]);
	}

	return input;
}

module.exports = function (encodedURI) {
	if (typeof encodedURI !== 'string') {
		throw new TypeError('Expected `encodedURI` to be of type `string`, got `' + typeof encodedURI + '`');
	}

	try {
		encodedURI = encodedURI.replace(/\+/g, ' ');

		// Try the built in decoder first
		return decodeURIComponent(encodedURI);
	} catch (err) {
		// Fallback to a more advanced decoder
		return customDecodeURIComponent(encodedURI);
	}
};


/***/ }),

/***/ 234:
/***/ (function(module, exports, __webpack_require__) {

"use strict";

module.exports = str => encodeURIComponent(str).replace(/[!'()*]/g, x => `%${x.charCodeAt(0).toString(16).toUpperCase()}`);


/***/ }),

/***/ 235:
/***/ (function(module, exports, __webpack_require__) {

// style-loader: Adds some css to the DOM by adding a <style> tag

// load the styles
var content = __webpack_require__(75);
if(typeof content === 'string') content = [[module.i, content, '']];
// add the styles to the DOM
var update = __webpack_require__(23)(content, {});
if(content.locals) module.exports = content.locals;
// Hot Module Replacement
if(true) {
	// When the styles change, update the <style> tags
	if(!content.locals) {
		module.hot.accept(75, function() {
			var newContent = __webpack_require__(75);
			if(typeof newContent === 'string') newContent = [[module.i, newContent, '']];
			update(newContent);
		});
	}
	// When the module is disposed, remove the <style> tags
	module.hot.dispose(function() { update(); });
}

/***/ }),

/***/ 236:
/***/ (function(module, exports, __webpack_require__) {

// style-loader: Adds some css to the DOM by adding a <style> tag

// load the styles
var content = __webpack_require__(76);
if(typeof content === 'string') content = [[module.i, content, '']];
// add the styles to the DOM
var update = __webpack_require__(23)(content, {});
if(content.locals) module.exports = content.locals;
// Hot Module Replacement
if(true) {
	// When the styles change, update the <style> tags
	if(!content.locals) {
		module.hot.accept(76, function() {
			var newContent = __webpack_require__(76);
			if(typeof newContent === 'string') newContent = [[module.i, newContent, '']];
			update(newContent);
		});
	}
	// When the module is disposed, remove the <style> tags
	module.hot.dispose(function() { update(); });
}

/***/ }),

/***/ 481:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(module, $) {

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _table = __webpack_require__(31);

var _table2 = _interopRequireDefault(_table);

var _input = __webpack_require__(28);

var _input2 = _interopRequireDefault(_input);

var _button = __webpack_require__(21);

var _button2 = _interopRequireDefault(_button);

var _modal = __webpack_require__(43);

var _modal2 = _interopRequireDefault(_modal);

var _datePicker = __webpack_require__(36);

var _datePicker2 = _interopRequireDefault(_datePicker);

var _form = __webpack_require__(29);

var _form2 = _interopRequireDefault(_form);

var _index = __webpack_require__(20);

var _index2 = _interopRequireDefault(_index);

var _index3 = __webpack_require__(18);

var _index4 = _interopRequireDefault(_index3);

var _react2 = __webpack_require__(0);

var _react3 = _interopRequireDefault(_react2);

var _index5 = __webpack_require__(19);

var _index6 = _interopRequireDefault(_index5);

var _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

__webpack_require__(32);

__webpack_require__(26);

__webpack_require__(25);

__webpack_require__(44);

__webpack_require__(37);

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
  GoodsManagement: {
    displayName: 'GoodsManagement'
  }
};

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2 = (0, _index6.default)({
  filename: '/Users/huang/work/dzoms_react/components/goods/goodsManagement.js',
  components: _components,
  locals: [module],
  imports: [_react3.default]
});

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2 = (0, _index4.default)({
  filename: '/Users/huang/work/dzoms_react/components/goods/goodsManagement.js',
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
        /* labelCol: { span: 4 },
         wrapperCol: { span: 12 },*/
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
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(14)(module), __webpack_require__(16)))

/***/ }),

/***/ 482:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(module, $) {

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _table = __webpack_require__(31);

var _table2 = _interopRequireDefault(_table);

var _button = __webpack_require__(21);

var _button2 = _interopRequireDefault(_button);

var _regenerator = __webpack_require__(56);

var _regenerator2 = _interopRequireDefault(_regenerator);

var _modal = __webpack_require__(43);

var _modal2 = _interopRequireDefault(_modal);

var _index = __webpack_require__(20);

var _index2 = _interopRequireDefault(_index);

var _index3 = __webpack_require__(18);

var _index4 = _interopRequireDefault(_index3);

var _react2 = __webpack_require__(0);

var _react3 = _interopRequireDefault(_react2);

var _index5 = __webpack_require__(19);

var _index6 = _interopRequireDefault(_index5);

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

__webpack_require__(32);

__webpack_require__(25);

__webpack_require__(44);

var _reactDom = __webpack_require__(11);

var _reactDom2 = _interopRequireDefault(_reactDom);

var _Sorter = __webpack_require__(33);

var _Sorter2 = _interopRequireDefault(_Sorter);

var _Filters = __webpack_require__(40);

var _Filters2 = _interopRequireDefault(_Filters);

var _StringUtil = __webpack_require__(156);

var _StringUtil2 = _interopRequireDefault(_StringUtil);

var _SearchBar = __webpack_require__(101);

var _SearchBar2 = _interopRequireDefault(_SearchBar);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var _components = {
  OfficeHistory: {
    displayName: 'OfficeHistory'
  }
};

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2 = (0, _index6.default)({
  filename: '/Users/huang/work/dzoms_react/components/goods/officeHistory.js',
  components: _components,
  locals: [module],
  imports: [_react3.default]
});

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2 = (0, _index4.default)({
  filename: '/Users/huang/work/dzoms_react/components/goods/officeHistory.js',
  components: _components,
  locals: [],
  imports: [_react3.default, _index2.default]
});

function _wrapComponent(id) {
  return function (Component) {
    return _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2(_UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2(Component, id), id);
  };
}

var confirm = _modal2.default.confirm;

var OfficeHistory = _wrapComponent('OfficeHistory')(function (_React$Component) {
  _inherits(OfficeHistory, _React$Component);

  function OfficeHistory(props) {
    _classCallCheck(this, OfficeHistory);

    var _this = _possibleConstructorReturn(this, (OfficeHistory.__proto__ || Object.getPrototypeOf(OfficeHistory)).call(this, props));

    _this.state = {
      recData: [] //从后台接收到的数据
    };
    return _this;
  }

  _createClass(OfficeHistory, [{
    key: 'agree',
    value: function agree(id) {
      var self = this;
      var params = { id: id };
      confirm({
        title: '领用确认',
        content: '确定领用此物品么？',
        onOk: function onOk() {
          $.ajax({
            url: self.props.agreeUrl,
            type: "post",
            dataType: 'json',
            data: JSON.stringify(params),
            contentType: 'application/json',
            success: function (data) {
              if (data && data.status > 0) {
                self.fetchData();
              } else {
                _modal2.default.error({
                  title: '错误信息',
                  content: '领用失败'
                });
              }
            }.bind(self),
            error: function error() {
              _modal2.default.error({
                title: '错误信息',
                content: '系统不可用'
              });
            }
          });
        },
        onCancel: function onCancel() {
          console.log('Cancel');
        }
      });
    }
  }, {
    key: 'deny',
    value: function deny(id) {
      var self = this;
      var params = { id: id };
      confirm({
        title: '驳回确认',
        content: '确定领用此物品么？',
        onOk: function onOk() {
          $.ajax({
            //url:"/goodsList",
            url: self.props.denyUrl,
            type: "post",
            dataType: 'json',
            data: JSON.stringify(params),
            contentType: 'application/json',
            success: function success(data) {
              if (data && data.status > 0) {
                self.fetchData();
              } else {
                _modal2.default.error({
                  title: '错误信息',
                  content: '驳回失败'
                });
              }
            },
            error: function error() {
              _modal2.default.error({
                title: '错误信息',
                content: '系统不可用'
              });
            }
          });
        },
        onCancel: function onCancel() {
          console.log('Cancel');
        }
      });
    }
  }, {
    key: 'fetchData',
    value: function fetchData() {
      var params = '';
      if (window.location.search) params = window.location.search.substring(1);
      $.ajax({
        url: this.props.goodsIssueHisInfoUrl,
        type: "get",
        dataType: 'json',
        data: params,
        contentType: 'application/json',
        success: function (data) {
          if (data.status > 0) {
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
    key: 'componentDidMount',
    value: function () {
      var _ref = _asyncToGenerator( /*#__PURE__*/_regenerator2.default.mark(function _callee() {
        return _regenerator2.default.wrap(function _callee$(_context) {
          while (1) {
            switch (_context.prev = _context.next) {
              case 0:
                this.fetchData();

              case 1:
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
    key: 'render',
    value: function render() {
      var _this2 = this;

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
        },
        render: function render(text) {
          return _StringUtil2.default.safeGet(text);
        }
      }, {
        title: '部门',
        dataIndex: 'department',
        key: 'department',
        filters: filterData.department,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.department, b.department);
        },
        onFilter: function onFilter(value, record) {
          return record.department.indexOf(value) === 0;
        },
        render: function render(text) {
          return _StringUtil2.default.safeGet(text);
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
        },
        render: function render(text) {
          return _StringUtil2.default.safeGet(text);
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
        },
        render: function render(text) {
          return _StringUtil2.default.safeGet(text);
        }
      }, {
        title: '申请时间',
        dataIndex: 'applyTime',
        key: 'applyTime',
        filters: filterData.applyTime,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.applyTime, b.applyTime);
        },
        onFilter: function onFilter(value, record) {
          return record.applyTime.indexOf(value) === 0;
        },
        render: function render(text) {
          return _StringUtil2.default.safeGet(text);
        }
      }, {
        title: '操作',
        dataIndex: 'state',
        key: 'state',
        render: function render(text, record) {
          if (record.state == 1) return _react3.default.createElement(
            'span',
            null,
            '\u5DF2\u9886\u7528'
          );return _react3.default.createElement(
            'div',
            null,
            _react3.default.createElement(
              _button2.default,
              { onClick: _this2.agree.bind(_this2, record.id), type: 'primary', style: { marginRight: 10 } },
              '\u540C\u610F'
            ),
            _react3.default.createElement(
              _button2.default,
              { onClick: _this2.deny.bind(_this2, record.id) },
              '\u9A73\u56DE'
            )
          );
        }
      }, {
        title: '领用时间',
        dataIndex: 'time',
        key: 'time',
        filters: filterData.time,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.time, b.time);
        },
        onFilter: function onFilter(value, record) {
          return record.time.indexOf(value) === 0;
        },
        render: function render(text) {
          return _StringUtil2.default.safeGet(text);
        }
      }];
      return _react3.default.createElement(
        'div',
        null,
        _react3.default.createElement(_SearchBar2.default, { options: this.props.options || [{ field: 'personName', alias: '姓名' }, { field: 'department', alias: '部门' }], downloadUrl: this.props.downloadUrl }),
        _react3.default.createElement(_table2.default, { key: this.key++, pagination: false, columns: columns, dataSource: this.state.recData })
      );
    }
  }]);

  return OfficeHistory;
}(_react3.default.Component));

if (document.getElementById("officeHistory")) _reactDom2.default.render(_react3.default.createElement(OfficeHistory, pageUrls), document.getElementById("officeHistory"));
exports.default = OfficeHistory;
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(14)(module), __webpack_require__(16)))

/***/ }),

/***/ 483:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(module, $) {

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _table = __webpack_require__(31);

var _table2 = _interopRequireDefault(_table);

var _button = __webpack_require__(21);

var _button2 = _interopRequireDefault(_button);

var _inputNumber = __webpack_require__(51);

var _inputNumber2 = _interopRequireDefault(_inputNumber);

var _modal = __webpack_require__(43);

var _modal2 = _interopRequireDefault(_modal);

var _datePicker = __webpack_require__(36);

var _datePicker2 = _interopRequireDefault(_datePicker);

var _form = __webpack_require__(29);

var _form2 = _interopRequireDefault(_form);

var _index = __webpack_require__(20);

var _index2 = _interopRequireDefault(_index);

var _index3 = __webpack_require__(18);

var _index4 = _interopRequireDefault(_index3);

var _react2 = __webpack_require__(0);

var _react3 = _interopRequireDefault(_react2);

var _index5 = __webpack_require__(19);

var _index6 = _interopRequireDefault(_index5);

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

__webpack_require__(32);

__webpack_require__(25);

__webpack_require__(52);

__webpack_require__(44);

__webpack_require__(37);

__webpack_require__(30);

var _reactDom = __webpack_require__(11);

var _reactDom2 = _interopRequireDefault(_reactDom);

var _Sorter = __webpack_require__(33);

var _Sorter2 = _interopRequireDefault(_Sorter);

var _Filters = __webpack_require__(40);

var _Filters2 = _interopRequireDefault(_Filters);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _toConsumableArray(arr) { if (Array.isArray(arr)) { for (var i = 0, arr2 = Array(arr.length); i < arr.length; i++) { arr2[i] = arr[i]; } return arr2; } else { return Array.from(arr); } }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var _components = {
  Goods: {
    displayName: 'Goods'
  }
};

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2 = (0, _index6.default)({
  filename: '/Users/huang/work/dzoms_react/components/goods/officeIssue.js',
  components: _components,
  locals: [module],
  imports: [_react3.default]
});

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2 = (0, _index4.default)({
  filename: '/Users/huang/work/dzoms_react/components/goods/officeIssue.js',
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
    return _this;
  }

  _createClass(Goods, [{
    key: 'componentDidMount',
    value: function componentDidMount() {
      this.fetchData();
    }
  }, {
    key: 'fetchData',
    value: function fetchData() {
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
            console.log(data);
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
      var _state$recData$index = this.state.recData[index],
          itemId = _state$recData$index.itemId,
          num = _state$recData$index.num;

      if (!(num && num != 0)) {
        _modal2.default.error({
          title: '错误',
          content: "领用数量不能为0!",
          onOk: function onOk() {}
        });
        return;
      }
      var reqData = { num: num, itemId: itemId };
      var self = this;
      $.ajax({
        //url:"/goodsList",
        url: self.props.goodsIssueUrl,
        type: "post",
        dataType: 'json',
        data: JSON.stringify(reqData),
        contentType: 'application/json',
        success: function (data) {
          if (data && data.status > 0) {
            _modal2.default.info({
              title: '提示',
              content: _react3.default.createElement(
                'div',
                null,
                _react3.default.createElement(
                  'p',
                  null,
                  '\u9886\u7528\u6210\u529F\uFF01'
                )
              ),
              onOk: function onOk() {}
            });
            self.fetchData();
          } else {
            _modal2.default.error({
              title: '提示',
              content: _react3.default.createElement(
                'div',
                null,
                _react3.default.createElement(
                  'p',
                  null,
                  '\u9886\u7528\u5931\u8D25\uFF01'
                )
              ),
              onOk: function onOk() {}
            });
          }
        }.bind(self),
        error: function error() {
          _modal2.default.error({
            title: '提示',
            content: _react3.default.createElement(
              'div',
              null,
              _react3.default.createElement(
                'p',
                null,
                '\u7CFB\u7EDF\u6545\u969C\uFF0C\u9886\u7528\u5931\u8D25\uFF01'
              )
            ),
            onOk: function onOk() {}
          });
        }
      });
    }
  }, {
    key: 'onScoreChange',
    value: function onScoreChange(index, value) {
      //console.log(this.state.recData);
      console.log(index, value);
      var newData = [].concat(_toConsumableArray(this.state.recData));
      newData[index].num = value;
      this.setState({ recData: newData });
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
          return _react3.default.createElement(_inputNumber2.default, { min: 0, defaultValue: 0, onChange: _this2.onScoreChange.bind(_this2, index) });
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
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(14)(module), __webpack_require__(16)))

/***/ }),

/***/ 484:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(module, $) {

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _table = __webpack_require__(31);

var _table2 = _interopRequireDefault(_table);

var _button = __webpack_require__(21);

var _button2 = _interopRequireDefault(_button);

var _inputNumber = __webpack_require__(51);

var _inputNumber2 = _interopRequireDefault(_inputNumber);

var _modal = __webpack_require__(43);

var _modal2 = _interopRequireDefault(_modal);

var _regenerator = __webpack_require__(56);

var _regenerator2 = _interopRequireDefault(_regenerator);

var _input = __webpack_require__(28);

var _input2 = _interopRequireDefault(_input);

var _datePicker = __webpack_require__(36);

var _datePicker2 = _interopRequireDefault(_datePicker);

var _form = __webpack_require__(29);

var _form2 = _interopRequireDefault(_form);

var _index = __webpack_require__(20);

var _index2 = _interopRequireDefault(_index);

var _index3 = __webpack_require__(18);

var _index4 = _interopRequireDefault(_index3);

var _react2 = __webpack_require__(0);

var _react3 = _interopRequireDefault(_react2);

var _index5 = __webpack_require__(19);

var _index6 = _interopRequireDefault(_index5);

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

__webpack_require__(32);

__webpack_require__(25);

__webpack_require__(52);

__webpack_require__(44);

__webpack_require__(26);

__webpack_require__(37);

__webpack_require__(30);

var _reactDom = __webpack_require__(11);

var _reactDom2 = _interopRequireDefault(_reactDom);

var _Sorter = __webpack_require__(33);

var _Sorter2 = _interopRequireDefault(_Sorter);

var _Filters = __webpack_require__(40);

var _Filters2 = _interopRequireDefault(_Filters);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var _components = {
  OfficePurchase: {
    displayName: 'OfficePurchase'
  }
};

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2 = (0, _index6.default)({
  filename: '/Users/huang/work/dzoms_react/components/goods/officePurchase.js',
  components: _components,
  locals: [module],
  imports: [_react3.default]
});

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2 = (0, _index4.default)({
  filename: '/Users/huang/work/dzoms_react/components/goods/officePurchase.js',
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
    value: function () {
      var _ref = _asyncToGenerator( /*#__PURE__*/_regenerator2.default.mark(function _callee() {
        var self;
        return _regenerator2.default.wrap(function _callee$(_context) {
          while (1) {
            switch (_context.prev = _context.next) {
              case 0:
                self = this;

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

              case 2:
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
    key: 'action',
    value: function action(index) {
      var self = this;
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
              self.componentDidMount();
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
          return _react3.default.createElement(_inputNumber2.default, { min: 1, defaultValue: 0, onChange: _this2.onScoreChange.bind(_this2, index) });
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
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(14)(module), __webpack_require__(16)))

/***/ }),

/***/ 485:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(module, $) {

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _table = __webpack_require__(31);

var _table2 = _interopRequireDefault(_table);

var _regenerator = __webpack_require__(56);

var _regenerator2 = _interopRequireDefault(_regenerator);

var _modal = __webpack_require__(43);

var _modal2 = _interopRequireDefault(_modal);

var _index = __webpack_require__(20);

var _index2 = _interopRequireDefault(_index);

var _index3 = __webpack_require__(18);

var _index4 = _interopRequireDefault(_index3);

var _react2 = __webpack_require__(0);

var _react3 = _interopRequireDefault(_react2);

var _index5 = __webpack_require__(19);

var _index6 = _interopRequireDefault(_index5);

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

__webpack_require__(32);

__webpack_require__(44);

var _reactDom = __webpack_require__(11);

var _reactDom2 = _interopRequireDefault(_reactDom);

var _Sorter = __webpack_require__(33);

var _Sorter2 = _interopRequireDefault(_Sorter);

var _Filters = __webpack_require__(40);

var _Filters2 = _interopRequireDefault(_Filters);

var _SearchBar = __webpack_require__(101);

var _SearchBar2 = _interopRequireDefault(_SearchBar);

var _StringUtil = __webpack_require__(156);

var _StringUtil2 = _interopRequireDefault(_StringUtil);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var _components = {
  YunyingbuHistory: {
    displayName: 'YunyingbuHistory'
  }
};

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2 = (0, _index6.default)({
  filename: '/Users/huang/work/dzoms_react/components/goods/yunyingbuHistory.js',
  components: _components,
  locals: [module],
  imports: [_react3.default]
});

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2 = (0, _index4.default)({
  filename: '/Users/huang/work/dzoms_react/components/goods/yunyingbuHistory.js',
  components: _components,
  locals: [],
  imports: [_react3.default, _index2.default]
});

function _wrapComponent(id) {
  return function (Component) {
    return _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2(_UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2(Component, id), id);
  };
}

var YunyingbuHistory = _wrapComponent('YunyingbuHistory')(function (_React$Component) {
  _inherits(YunyingbuHistory, _React$Component);

  function YunyingbuHistory(props) {
    _classCallCheck(this, YunyingbuHistory);

    var _this = _possibleConstructorReturn(this, (YunyingbuHistory.__proto__ || Object.getPrototypeOf(YunyingbuHistory)).call(this, props));

    _this.state = {
      recData: [] //从后台接收到的数据
    };
    return _this;
  }

  _createClass(YunyingbuHistory, [{
    key: 'componentDidMount',
    value: function () {
      var _ref = _asyncToGenerator( /*#__PURE__*/_regenerator2.default.mark(function _callee() {
        var params;
        return _regenerator2.default.wrap(function _callee$(_context) {
          while (1) {
            switch (_context.prev = _context.next) {
              case 0:
                console.log(this.props.goodsIssueHisInfoUrl);
                params = '';

                if (window.location.search) params = window.location.search.substring(1);

                $.ajax({
                  url: this.props.goodsIssueHisInfoUrl,
                  type: "get",
                  dataType: 'json',
                  data: params,
                  contentType: 'application/json',
                  success: function (data) {
                    if (data.status > 0) {
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

              case 4:
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
        },
        render: function render(text) {
          return _StringUtil2.default.safeGet(text);
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
        },
        render: function render(text) {
          return _StringUtil2.default.safeGet(text);
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
        },
        render: function render(text) {
          return _StringUtil2.default.safeGet(text);
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
        },
        render: function render(text) {
          return _StringUtil2.default.safeGet(text);
        }
      }, {
        title: '领用时间',
        dataIndex: 'time',
        key: 'time',
        filters: filterData.time,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.time, b.time);
        },
        onFilter: function onFilter(value, record) {
          return record.time.indexOf(value) === 0;
        },
        render: function render(text) {
          return _StringUtil2.default.safeGet(text);
        }
      }];
      return _react3.default.createElement(
        'div',
        null,
        _react3.default.createElement(_SearchBar2.default, { options: this.props.options || [{ field: 'carNumber', alias: '车牌号' }, { field: 'idNumber', alias: '身份证' }, { field: 'personName', alias: '姓名' }, { field: 'itemName', alias: '物品名称' }], downloadUrl: this.props.downloadUrl }),
        _react3.default.createElement(_table2.default, { key: this.key++, pagination: false, columns: columns, dataSource: this.state.recData })
      );
    }
  }]);

  return YunyingbuHistory;
}(_react3.default.Component));

if (document.getElementById("yunyingbuHistory")) _reactDom2.default.render(_react3.default.createElement(YunyingbuHistory, pageUrls), document.getElementById("yunyingbuHistory"));
exports.default = YunyingbuHistory;
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(14)(module), __webpack_require__(16)))

/***/ }),

/***/ 486:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(module, $) {

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _inputNumber = __webpack_require__(51);

var _inputNumber2 = _interopRequireDefault(_inputNumber);

var _select = __webpack_require__(38);

var _select2 = _interopRequireDefault(_select);

var _table = __webpack_require__(31);

var _table2 = _interopRequireDefault(_table);

var _button = __webpack_require__(21);

var _button2 = _interopRequireDefault(_button);

var _regenerator = __webpack_require__(56);

var _regenerator2 = _interopRequireDefault(_regenerator);

var _modal = __webpack_require__(43);

var _modal2 = _interopRequireDefault(_modal);

var _datePicker = __webpack_require__(36);

var _datePicker2 = _interopRequireDefault(_datePicker);

var _input = __webpack_require__(28);

var _input2 = _interopRequireDefault(_input);

var _form = __webpack_require__(29);

var _form2 = _interopRequireDefault(_form);

var _index = __webpack_require__(20);

var _index2 = _interopRequireDefault(_index);

var _index3 = __webpack_require__(18);

var _index4 = _interopRequireDefault(_index3);

var _react2 = __webpack_require__(0);

var _react3 = _interopRequireDefault(_react2);

var _index5 = __webpack_require__(19);

var _index6 = _interopRequireDefault(_index5);

var _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

__webpack_require__(52);

__webpack_require__(39);

__webpack_require__(32);

__webpack_require__(25);

__webpack_require__(44);

__webpack_require__(37);

__webpack_require__(26);

__webpack_require__(30);

var _reactDom = __webpack_require__(11);

var _reactDom2 = _interopRequireDefault(_reactDom);

var _Sorter = __webpack_require__(33);

var _Sorter2 = _interopRequireDefault(_Sorter);

var _Filters = __webpack_require__(40);

var _Filters2 = _interopRequireDefault(_Filters);

var _SelectInfo = __webpack_require__(70);

var _SelectInfo2 = _interopRequireDefault(_SelectInfo);

var _Select2 = __webpack_require__(155);

var _Select3 = _interopRequireDefault(_Select2);

var _cph = __webpack_require__(121);

var _cph2 = _interopRequireDefault(_cph);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var _components = {
  YunyingbuIssue: {
    displayName: 'YunyingbuIssue'
  }
};

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2 = (0, _index6.default)({
  filename: '/Users/huang/work/dzoms_react/components/goods/yunyingbuIssue.js',
  components: _components,
  locals: [module],
  imports: [_react3.default]
});

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2 = (0, _index4.default)({
  filename: '/Users/huang/work/dzoms_react/components/goods/yunyingbuIssue.js',
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
      visible: false,
      cph: '',
      driversAndHistory: { drivers: [], history: [] }
    };
    _this.key = 0;
    _this.itemId = "";
    return _this;
  }

  _createClass(YunyingbuIssue, [{
    key: 'loadGoodsList',
    value: function loadGoodsList() {
      var self = this;
      self.setState({
        loading: true
      });
      $.ajax({
        url: self.props.goodsList,
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
              recData: data,
              loading: false
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
    key: 'componentDidMount',
    value: function () {
      var _ref = _asyncToGenerator( /*#__PURE__*/_regenerator2.default.mark(function _callee() {
        return _regenerator2.default.wrap(function _callee$(_context) {
          while (1) {
            switch (_context.prev = _context.next) {
              case 0:
                this.loadGoodsList();

              case 1:
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
    key: 'showAddModal',
    value: function showAddModal(index, value) {
      if (this.state.cph.length < 3) {
        _modal2.default.error({
          title: '错误',
          content: '请先填入待领用车牌号！'
        });
        return;
      }
      var itemId = this.state.recData[index].itemId;
      this.itemId = itemId;
      var self = this;
      $.get(this.props.driversAndHistory || "/driversAndHistory", { vehicle: this.state.cph, itemId: itemId }, function (data) {
        self.setState({
          visible: true,
          driversAndHistory: data
        });
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
      var result = {};
      var recData = this.props.recData;
      //if(this.state.errorMessage==""){
      this.props.form.validateFields(function (err, values) {
        if (!err) {
          // this.setState({ loading: false, visible: false });
          result = values;
          result["itemId"] = _this2.itemId;
          result.carNumber = _this2.state.cph;
          console.log(result);
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
                _modal2.default.success({
                  title: '提示信息',
                  content: '领用成功！'
                });
                self.setState({ loading: false, visible: false });
              } else {
                _modal2.default.error({
                  title: '错误信息',
                  content: data.message
                });
              }
              self.loadGoodsList();
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
            // loading: false,
            visible: true
          });
          return;
        }
      });
      // }else{
      // 	return;
      // }
      //刷新列表  
    }
  }, {
    key: 'onChange',
    value: function onChange(value) {}
  }, {
    key: 'selectInfoErrorMessage',
    value: function selectInfoErrorMessage(errorMessage) {
      this.setState({
        errorMessage: errorMessage
      });
    }
    /******************************/

  }, {
    key: 'cphChange',
    value: function cphChange(value) {
      this.setState({
        cph: value
      });
    }
  }, {
    key: 'driverChange',
    value: function driverChange(value) {
      var _props$form = this.props.form,
          getFieldDecorator = _props$form.getFieldDecorator,
          getFieldValue = _props$form.getFieldValue,
          setFieldsValue = _props$form.setFieldsValue;

      for (var i in this.state.driversAndHistory.drivers) {
        if (this.state.driversAndHistory.drivers[i].name == value) {
          console.log(this.state.driversAndHistory.drivers[i].id);
          setFieldsValue({ idNumber: this.state.driversAndHistory.drivers[i].id });
        }
      }
    }
  }, {
    key: 'render',
    value: function render() {
      var _this3 = this;

      var _props$form2 = this.props.form,
          getFieldDecorator = _props$form2.getFieldDecorator,
          getFieldValue = _props$form2.getFieldValue,
          setFieldsValue = _props$form2.setFieldsValue;

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
      var subColumns = [];
      if (this.state.driversAndHistory.history.length > 0) {
        var subFilter = new _Filters2.default().filter(this.state.driversAndHistory.history);
        subColumns = [{
          title: '名称',
          dataIndex: 'itemName',
          key: 'itemName',
          filters: subFilter.itemName,
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
          filters: subFilter.itemType,
          sorter: function sorter(a, b) {
            return new _Sorter2.default().sort(a.itemType, b.itemType);
          },
          onFilter: function onFilter(value, record) {
            return record.itemType.indexOf(value) === 0;
          }
        }, {
          title: '领用数量',
          dataIndex: 'number',
          key: 'number',
          filters: subFilter.itemTotalNum,
          sorter: function sorter(a, b) {
            return new _Sorter2.default().sort(a.itemTotalNum, b.itemTotalNum);
          },
          onFilter: function onFilter(value, record) {
            return record.itemTotalNum.indexOf(value) === 0;
          }
        }, {
          title: '领用人',
          dataIndex: 'driverName',
          key: 'driverName',
          filters: subFilter.driverName,
          sorter: function sorter(a, b) {
            return new _Sorter2.default().sort(a.driverName, b.driverName);
          },
          onFilter: function onFilter(value, record) {
            return record.driverName.indexOf(value) === 0;
          }
        }, {
          title: '领用时间',
          dataIndex: 'time',
          key: 'time',
          filters: subFilter.time,
          sorter: function sorter(a, b) {
            return new _Sorter2.default().sort(a.time, b.time);
          }
        }];
      }
      var formItemLayout = {
        /*labelCol: { span: 3 },
        wrapperCol: { span: 6 },*/
      };

      return _react3.default.createElement(
        'div',
        null,
        _react3.default.createElement(
          'div',
          null,
          _react3.default.createElement(
            'div',
            { style: { float: 'left', marginTop: 7, marginLeft: 10, marginRight: 0 } },
            '\u8BF7\u5148\u586B\u5165\u9886\u7528\u8F66\u724C\u53F7\uFF1A'
          ),
          _react3.default.createElement(
            'div',
            null,
            _react3.default.createElement(_cph2.default, { chepaihao: this.props.chepaihao, onChange: this.cphChange.bind(this) })
          )
        ),
        _react3.default.createElement(_table2.default, { key: 'yunyingbuIssue', size: 'default', columns: columns, pagination: false, dataSource: this.state.recData, loading: this.state.loading }),
        this.state.visible && _react3.default.createElement(
          _modal2.default,
          {
            width: 1000,
            title: '\u53D1\u653E\u4FE1\u606F [' + this.state.cph + ']',
            visible: true,
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
            { layout: 'inline', style: { marginBottom: 20 } },
            _react3.default.createElement(
              FormItem,
              _extends({
                label: '\u9886\u7528\u4EBA\uFF1A'
              }, formItemLayout),
              getFieldDecorator('recipient', {
                rules: [{ required: true, message: '该字段不能为空!' }]
              })(_react3.default.createElement(
                _select2.default,
                { style: { width: 200 }, onChange: this.driverChange.bind(this) },
                this.state.driversAndHistory.drivers.map(function (i) {
                  return _react3.default.createElement(
                    _select2.default.Option,
                    { value: i.name },
                    i.name
                  );
                })
              ))
            ),
            _react3.default.createElement(
              FormItem,
              _extends({
                label: '\u8EAB\u4EFD\u8BC1\uFF1A'
              }, formItemLayout),
              getFieldDecorator('idNumber', {
                rules: [{ required: true, message: '该字段不能为空!' }]
              })(_react3.default.createElement(_input2.default, null))
            ),
            _react3.default.createElement(
              FormItem,
              _extends({
                label: '\u6570\u91CF:'
              }, formItemLayout),
              getFieldDecorator('count', {
                rules: [{ required: true, message: '必须是数字!' }], initialValue: 1
              })(_react3.default.createElement(_inputNumber2.default, { min: 0, onChange: this.onChange.bind(this) }))
            )
          ),
          '\u8FD13\u4E2A\u6708\u9886\u7528\u8BB0\u5F55',
          this.state.driversAndHistory.history.length,
          '\u6761',
          _react3.default.createElement(_table2.default, { key: 'history', size: 'default', columns: subColumns, pagination: false, dataSource: this.state.driversAndHistory.history })
        )
      );
    }
  }]);

  return YunyingbuIssue;
}(_react3.default.Component));

var WrappedYunyingbuIssue = _form2.default.create()(YunyingbuIssue);
if (document.getElementById("yunyingbuIssue")) _reactDom2.default.render(_react3.default.createElement(WrappedYunyingbuIssue, pageUrls), document.getElementById("yunyingbuIssue"));
exports.default = YunyingbuIssue;
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(14)(module), __webpack_require__(16)))

/***/ }),

/***/ 487:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(module, $) {

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _table = __webpack_require__(31);

var _table2 = _interopRequireDefault(_table);

var _button = __webpack_require__(21);

var _button2 = _interopRequireDefault(_button);

var _inputNumber = __webpack_require__(51);

var _inputNumber2 = _interopRequireDefault(_inputNumber);

var _icon = __webpack_require__(42);

var _icon2 = _interopRequireDefault(_icon);

var _modal = __webpack_require__(43);

var _modal2 = _interopRequireDefault(_modal);

var _input = __webpack_require__(28);

var _input2 = _interopRequireDefault(_input);

var _datePicker = __webpack_require__(36);

var _datePicker2 = _interopRequireDefault(_datePicker);

var _form = __webpack_require__(29);

var _form2 = _interopRequireDefault(_form);

var _index = __webpack_require__(20);

var _index2 = _interopRequireDefault(_index);

var _index3 = __webpack_require__(18);

var _index4 = _interopRequireDefault(_index3);

var _react2 = __webpack_require__(0);

var _react3 = _interopRequireDefault(_react2);

var _index5 = __webpack_require__(19);

var _index6 = _interopRequireDefault(_index5);

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

__webpack_require__(32);

__webpack_require__(25);

__webpack_require__(52);

__webpack_require__(532);

__webpack_require__(44);

__webpack_require__(26);

__webpack_require__(37);

__webpack_require__(30);

var _reactDom = __webpack_require__(11);

var _reactDom2 = _interopRequireDefault(_reactDom);

var _Sorter = __webpack_require__(33);

var _Sorter2 = _interopRequireDefault(_Sorter);

var _Filters = __webpack_require__(40);

var _Filters2 = _interopRequireDefault(_Filters);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _toConsumableArray(arr) { if (Array.isArray(arr)) { for (var i = 0, arr2 = Array(arr.length); i < arr.length; i++) { arr2[i] = arr[i]; } return arr2; } else { return Array.from(arr); } }

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

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2 = (0, _index6.default)({
  filename: '/Users/huang/work/dzoms_react/components/goods/yunyingbuPurchase.js',
  components: _components,
  locals: [module],
  imports: [_react3.default]
});

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2 = (0, _index4.default)({
  filename: '/Users/huang/work/dzoms_react/components/goods/yunyingbuPurchase.js',
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
    return _this2;
  }

  _createClass(YunyingbuPurchase, [{
    key: 'componentDidMount',
    value: function componentDidMount() {
      this.fetchData();
    }
  }, {
    key: 'fetchData',
    value: function fetchData() {
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
            console.log(data);
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
      var _state$recData$index = this.state.recData[index],
          itemId = _state$recData$index.itemId,
          num = _state$recData$index.num,
          itemRemarks = _state$recData$index.itemRemarks;

      var reqData = { num: num, itemRemarks: itemRemarks, itemId: itemId };
      var self = this;
      $.ajax({
        //url:"/goodsList",
        url: self.props.goodsPurchaseUrl,
        type: "post",
        dataType: 'json',
        data: JSON.stringify(reqData),
        contentType: 'application/json',
        success: function (data) {
          if (data.status > 0) {
            _modal2.default.info({
              title: '提示',
              content: _react3.default.createElement(
                'div',
                null,
                _react3.default.createElement(
                  'p',
                  null,
                  '\u5165\u5E93\u6210\u529F\uFF01'
                )
              ),
              onOk: function onOk() {}
            });
            self.fetchData();
          } else {
            _modal2.default.info({
              title: '提示',
              content: _react3.default.createElement(
                'div',
                null,
                _react3.default.createElement(
                  'p',
                  null,
                  '\u5165\u5E93\u5931\u8D25\uFF01'
                )
              ),
              onOk: function onOk() {}
            });
          }
        }.bind(self),
        error: function error() {
          alert("请求失败");
        }
      });
    }
  }, {
    key: 'onScoreChange',
    value: function onScoreChange(index, value) {
      //console.log(this.state.recData);
      // console.log(index,value)
      var newData = [].concat(_toConsumableArray(this.state.recData));
      newData[index].num = value;
      this.setState({ recData: newData });
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
      var newData = [].concat(_toConsumableArray(this.state.recData));
      newData[index].itemRemarks = remark;
      this.setState({ recData: newData });
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

      console.log();
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
        }
        /*render: (text, record, index) => (
          <EditableCell
            recData={this.state.recData}
            {...pageUrls}
            value={text}
            index={index}
            onChange={this.onCellChange.bind(this,index)}
          />
        )*/
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
          return _react3.default.createElement(_inputNumber2.default, { min: 0, defaultValue: 0, onChange: _this3.onScoreChange.bind(_this3, index) });
        }
      }, {
        title: '备注',
        dataIndex: 'itemRemarks',
        key: 'itemRemarks',
        render: function render(text, record, index) {
          return _react3.default.createElement(TextArea, { autosize: { minRows: 1 }, defaultValue: text, onChange: _this3.onRemarkChange.bind(_this3, index) });
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
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(14)(module), __webpack_require__(16)))

/***/ }),

/***/ 532:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


__webpack_require__(24);

/***/ }),

/***/ 598:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


__webpack_require__(481);
__webpack_require__(483);
__webpack_require__(484);
__webpack_require__(482);
__webpack_require__(486);
__webpack_require__(487);
__webpack_require__(485);

/***/ }),

/***/ 75:
/***/ (function(module, exports, __webpack_require__) {

exports = module.exports = __webpack_require__(22)();
// imports


// module
exports.push([module.i, ".filterItem {\n  display: flex;\n  justify-content: space-between;\n\n  .labelWrap {\n    width: 64px;\n    line-height: 28px;\n    margin-right: 12px;\n    justify-content: space-between;\n    display: flex;\n    overflow: hidden;\n  }\n\n  .item {\n    flex: 1;\n  }\n}\n", ""]);

// exports


/***/ }),

/***/ 76:
/***/ (function(module, exports, __webpack_require__) {

exports = module.exports = __webpack_require__(22)();
// imports


// module
exports.push([module.i, "/* stylelint-disable at-rule-empty-line-before,at-rule-name-space-after,at-rule-no-unknown */\n/* stylelint-disable declaration-bang-space-before */\n/* stylelint-disable declaration-bang-space-before */\n.ant-select-auto-complete.ant-select .ant-select-selection {\n  border: 0;\n  box-shadow: none;\n}\n.ant-select-auto-complete.ant-select .ant-select-selection__rendered {\n  margin-left: 0;\n  margin-right: 0;\n  height: 100%;\n  line-height: 28px;\n}\n.ant-select-auto-complete.ant-select .ant-select-selection__placeholder {\n  margin-left: 8px;\n  margin-right: 8px;\n}\n.ant-select-auto-complete.ant-select .ant-select-selection--single {\n  height: auto;\n}\n.ant-select-auto-complete.ant-select .ant-select-search--inline {\n  position: static;\n  float: left;\n}\n.ant-select-auto-complete.ant-select-allow-clear .ant-select-selection:hover .ant-select-selection__rendered {\n  margin-right: 0 !important;\n}\n.ant-select-auto-complete.ant-select .ant-input {\n  background: transparent;\n  border-width: 1px;\n  line-height: 1.5;\n  height: 28px;\n}\n.ant-select-auto-complete.ant-select .ant-input:focus,\n.ant-select-auto-complete.ant-select .ant-input:hover {\n  border-color: #49a9ee;\n}\n.ant-select-auto-complete.ant-select-lg .ant-select-selection__rendered {\n  line-height: 32px;\n}\n.ant-select-auto-complete.ant-select-lg .ant-input {\n  padding-top: 6px;\n  padding-bottom: 6px;\n  height: 32px;\n}\n.ant-select-auto-complete.ant-select-sm .ant-select-selection__rendered {\n  line-height: 22px;\n}\n.ant-select-auto-complete.ant-select-sm .ant-input {\n  padding-top: 1px;\n  padding-bottom: 1px;\n  height: 22px;\n}\n", ""]);

// exports


/***/ }),

/***/ 92:
/***/ (function(module, exports, __webpack_require__) {

"use strict";

const strictUriEncode = __webpack_require__(234);
const decodeComponent = __webpack_require__(197);

function encoderForArrayFormat(options) {
	switch (options.arrayFormat) {
		case 'index':
			return (key, value, index) => {
				return value === null ? [
					encode(key, options),
					'[',
					index,
					']'
				].join('') : [
					encode(key, options),
					'[',
					encode(index, options),
					']=',
					encode(value, options)
				].join('');
			};
		case 'bracket':
			return (key, value) => {
				return value === null ? encode(key, options) : [
					encode(key, options),
					'[]=',
					encode(value, options)
				].join('');
			};
		default:
			return (key, value) => {
				return value === null ? encode(key, options) : [
					encode(key, options),
					'=',
					encode(value, options)
				].join('');
			};
	}
}

function parserForArrayFormat(options) {
	let result;

	switch (options.arrayFormat) {
		case 'index':
			return (key, value, accumulator) => {
				result = /\[(\d*)\]$/.exec(key);

				key = key.replace(/\[\d*\]$/, '');

				if (!result) {
					accumulator[key] = value;
					return;
				}

				if (accumulator[key] === undefined) {
					accumulator[key] = {};
				}

				accumulator[key][result[1]] = value;
			};
		case 'bracket':
			return (key, value, accumulator) => {
				result = /(\[\])$/.exec(key);
				key = key.replace(/\[\]$/, '');

				if (!result) {
					accumulator[key] = value;
					return;
				}

				if (accumulator[key] === undefined) {
					accumulator[key] = [value];
					return;
				}

				accumulator[key] = [].concat(accumulator[key], value);
			};
		default:
			return (key, value, accumulator) => {
				if (accumulator[key] === undefined) {
					accumulator[key] = value;
					return;
				}

				accumulator[key] = [].concat(accumulator[key], value);
			};
	}
}

function encode(value, options) {
	if (options.encode) {
		return options.strict ? strictUriEncode(value) : encodeURIComponent(value);
	}

	return value;
}

function keysSorter(input) {
	if (Array.isArray(input)) {
		return input.sort();
	}

	if (typeof input === 'object') {
		return keysSorter(Object.keys(input))
			.sort((a, b) => Number(a) - Number(b))
			.map(key => input[key]);
	}

	return input;
}

function extract(input) {
	const queryStart = input.indexOf('?');
	if (queryStart === -1) {
		return '';
	}
	return input.slice(queryStart + 1);
}

function parse(input, options) {
	options = Object.assign({arrayFormat: 'none'}, options);

	const formatter = parserForArrayFormat(options);

	// Create an object with no prototype
	const ret = Object.create(null);

	if (typeof input !== 'string') {
		return ret;
	}

	input = input.trim().replace(/^[?#&]/, '');

	if (!input) {
		return ret;
	}

	for (const param of input.split('&')) {
		let [key, value] = param.replace(/\+/g, ' ').split('=');

		// Missing `=` should be `null`:
		// http://w3.org/TR/2012/WD-url-20120524/#collect-url-parameters
		value = value === undefined ? null : decodeComponent(value);

		formatter(decodeComponent(key), value, ret);
	}

	return Object.keys(ret).sort().reduce((result, key) => {
		const value = ret[key];
		if (Boolean(value) && typeof value === 'object' && !Array.isArray(value)) {
			// Sort object keys, not values
			result[key] = keysSorter(value);
		} else {
			result[key] = value;
		}

		return result;
	}, Object.create(null));
}

exports.extract = extract;
exports.parse = parse;

exports.stringify = (obj, options) => {
	const defaults = {
		encode: true,
		strict: true,
		arrayFormat: 'none'
	};

	options = Object.assign(defaults, options);

	if (options.sort === false) {
		options.sort = () => {};
	}

	const formatter = encoderForArrayFormat(options);

	return obj ? Object.keys(obj).sort(options.sort).map(key => {
		const value = obj[key];

		if (value === undefined) {
			return '';
		}

		if (value === null) {
			return encode(key, options);
		}

		if (Array.isArray(value)) {
			const result = [];

			for (const value2 of value.slice()) {
				if (value2 === undefined) {
					continue;
				}

				result.push(formatter(key, value2, result.length));
			}

			return result.join('&');
		}

		return encode(key, options) + '=' + encode(value, options);
	}).filter(x => x.length > 0).join('&') : '';
};

exports.parseUrl = (input, options) => {
	return {
		url: input.split('?')[0] || '',
		query: parse(extract(input), options)
	};
};


/***/ })

},[598]);