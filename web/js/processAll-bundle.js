webpackJsonp([4],{

/***/ 1021:
/***/ (function(module, exports, __webpack_require__) {

// style-loader: Adds some css to the DOM by adding a <style> tag

// load the styles
var content = __webpack_require__(175);
if(typeof content === 'string') content = [[module.i, content, '']];
// add the styles to the DOM
var update = __webpack_require__(26)(content, {});
if(content.locals) module.exports = content.locals;
// Hot Module Replacement
if(true) {
	// When the styles change, update the <style> tags
	if(!content.locals) {
		module.hot.accept(175, function() {
			var newContent = __webpack_require__(175);
			if(typeof newContent === 'string') newContent = [[module.i, newContent, '']];
			update(newContent);
		});
	}
	// When the module is disposed, remove the <style> tags
	module.hot.dispose(function() { update(); });
}

/***/ }),

/***/ 175:
/***/ (function(module, exports, __webpack_require__) {

exports = module.exports = __webpack_require__(24)();
// imports


// module
exports.push([module.i, "/* stylelint-disable at-rule-empty-line-before,at-rule-name-space-after,at-rule-no-unknown */\n/* stylelint-disable declaration-bang-space-before */\n/* stylelint-disable declaration-bang-space-before */\n.ant-collapse {\n  background-color: #f7f7f7;\n  border-radius: 4px;\n  border: 1px solid #d9d9d9;\n  border-bottom: 0;\n}\n.ant-collapse > .ant-collapse-item {\n  border-bottom: 1px solid #d9d9d9;\n}\n.ant-collapse > .ant-collapse-item:last-child,\n.ant-collapse > .ant-collapse-item:last-child > .ant-collapse-header {\n  border-radius: 0 0 4px 4px;\n}\n.ant-collapse > .ant-collapse-item > .ant-collapse-header {\n  line-height: 22px;\n  padding: 8px 0 8px 32px;\n  color: rgba(0, 0, 0, 0.85);\n  cursor: pointer;\n  position: relative;\n  transition: all .3s;\n}\n.ant-collapse > .ant-collapse-item > .ant-collapse-header .arrow {\n  font-size: 12px;\n  font-size: 9px \\9;\n  -ms-transform: scale(0.75) rotate(0);\n      transform: scale(0.75) rotate(0);\n  /* IE6-IE8 */\n  -ms-filter: \"progid:DXImageTransform.Microsoft.Matrix(sizingMethod='auto expand', M11=1, M12=0, M21=0, M22=1)\";\n  zoom: 1;\n  font-style: normal;\n  vertical-align: baseline;\n  text-align: center;\n  text-transform: none;\n  line-height: 1;\n  text-rendering: optimizeLegibility;\n  -webkit-font-smoothing: antialiased;\n  -moz-osx-font-smoothing: grayscale;\n  position: absolute;\n  color: rgba(0, 0, 0, 0.43);\n  display: inline-block;\n  font-weight: bold;\n  line-height: 40px;\n  vertical-align: top;\n  transition: transform 0.24s;\n  top: 0;\n  left: 16px;\n}\n:root .ant-collapse > .ant-collapse-item > .ant-collapse-header .arrow {\n  -webkit-filter: none;\n          filter: none;\n}\n:root .ant-collapse > .ant-collapse-item > .ant-collapse-header .arrow {\n  font-size: 12px;\n}\n.ant-collapse > .ant-collapse-item > .ant-collapse-header .arrow:before {\n  display: block;\n  font-family: \"anticon\" !important;\n}\n.ant-collapse > .ant-collapse-item > .ant-collapse-header .arrow:before {\n  content: \"\\E61F\";\n}\n.ant-collapse-anim-active {\n  transition: height 0.2s cubic-bezier(0.215, 0.61, 0.355, 1);\n}\n.ant-collapse-content {\n  overflow: hidden;\n  color: rgba(0, 0, 0, 0.65);\n  padding: 0 16px;\n  background-color: #fff;\n}\n.ant-collapse-content > .ant-collapse-content-box {\n  padding-top: 16px;\n  padding-bottom: 16px;\n}\n.ant-collapse-content-inactive {\n  display: none;\n}\n.ant-collapse-item:last-child > .ant-collapse-content {\n  border-radius: 0 0 4px 4px;\n}\n.ant-collapse > .ant-collapse-item > .ant-collapse-header[aria-expanded=\"true\"] .arrow {\n  display: inline-block;\n  font-size: 12px;\n  font-size: 9px \\9;\n  -ms-transform: scale(0.75) rotate(90deg);\n      transform: scale(0.75) rotate(90deg);\n  /* IE6-IE8 */\n  -ms-filter: \"progid:DXImageTransform.Microsoft.Matrix(sizingMethod='auto expand', M11=0.00000000000000006123, M12=-1, M21=1, M22=0.00000000000000006123)\";\n  zoom: 1;\n}\n:root .ant-collapse > .ant-collapse-item > .ant-collapse-header[aria-expanded=\"true\"] .arrow {\n  -webkit-filter: none;\n          filter: none;\n}\n:root .ant-collapse > .ant-collapse-item > .ant-collapse-header[aria-expanded=\"true\"] .arrow {\n  font-size: 12px;\n}\n.ant-collapse-borderless {\n  background-color: #fff;\n  border: 0;\n}\n.ant-collapse-borderless > .ant-collapse-item:last-child,\n.ant-collapse-borderless > .ant-collapse-item:last-child .ant-collapse-header {\n  border-radius: 0;\n}\n.ant-collapse-borderless > .ant-collapse-item-active {\n  border: 0;\n}\n.ant-collapse-borderless > .ant-collapse-item > .ant-collapse-content {\n  background-color: transparent;\n  border-top: 1px solid #d9d9d9;\n}\n.ant-collapse-borderless > .ant-collapse-item > .ant-collapse-header {\n  transition: all .3s;\n}\n.ant-collapse-borderless > .ant-collapse-item > .ant-collapse-header:hover {\n  background-color: #f7f7f7;\n}\n.ant-collapse .ant-collapse-item-disabled > .ant-collapse-header,\n.ant-collapse .ant-collapse-item-disabled > .ant-collapse-header > .arrow {\n  cursor: not-allowed;\n  color: rgba(0, 0, 0, 0.25);\n  background-color: #f7f7f7;\n}\n.ant-collapse > .ant-collapse-item:not(.ant-collapse-item-disabled) > .ant-collapse-header:active {\n  background-color: #eee;\n}\n", ""]);

// exports


/***/ }),

/***/ 233:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(module, $) {

Object.defineProperty(exports, "__esModule", {
    value: true
});

var _regenerator = __webpack_require__(56);

var _regenerator2 = _interopRequireDefault(_regenerator);

var _button = __webpack_require__(18);

var _button2 = _interopRequireDefault(_button);

var _inputNumber = __webpack_require__(51);

var _inputNumber2 = _interopRequireDefault(_inputNumber);

var _col = __webpack_require__(79);

var _col2 = _interopRequireDefault(_col);

var _modal = __webpack_require__(42);

var _modal2 = _interopRequireDefault(_modal);

var _form = __webpack_require__(33);

var _form2 = _interopRequireDefault(_form);

var _select = __webpack_require__(41);

var _select2 = _interopRequireDefault(_select);

var _input = __webpack_require__(28);

var _input2 = _interopRequireDefault(_input);

var _collapse = __webpack_require__(239);

var _collapse2 = _interopRequireDefault(_collapse);

var _radio = __webpack_require__(96);

var _radio2 = _interopRequireDefault(_radio);

var _index = __webpack_require__(21);

var _index2 = _interopRequireDefault(_index);

var _index3 = __webpack_require__(19);

var _index4 = _interopRequireDefault(_index3);

var _react2 = __webpack_require__(0);

var _react3 = _interopRequireDefault(_react2);

var _index5 = __webpack_require__(20);

var _index6 = _interopRequireDefault(_index5);

var _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };

var _typeof = typeof Symbol === "function" && typeof Symbol.iterator === "symbol" ? function (obj) { return typeof obj; } : function (obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; };

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

__webpack_require__(23);

__webpack_require__(52);

__webpack_require__(80);

__webpack_require__(43);

__webpack_require__(34);

__webpack_require__(44);

__webpack_require__(27);

__webpack_require__(240);

__webpack_require__(116);

var _reactDom = __webpack_require__(11);

var _reactDom2 = _interopRequireDefault(_reactDom);

var _SelectInfo = __webpack_require__(81);

var _SelectInfo2 = _interopRequireDefault(_SelectInfo);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var _components = {
    TaskCollapse: {
        displayName: 'TaskCollapse'
    },
    TaskDetails: {
        displayName: 'TaskDetails'
    }
};

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2 = (0, _index6.default)({
    filename: '/Users/huang/work/dzoms_react/components/process/taskDetails.js',
    components: _components,
    locals: [module],
    imports: [_react3.default]
});

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2 = (0, _index4.default)({
    filename: '/Users/huang/work/dzoms_react/components/process/taskDetails.js',
    components: _components,
    locals: [],
    imports: [_react3.default, _index2.default]
});

function _wrapComponent(id) {
    return function (Component) {
        return _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2(_UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2(Component, id), id);
    };
}

var RadioGroup = _radio2.default.Group;
var RadioButton = _radio2.default.Button;
var Panel = _collapse2.default.Panel;
var InputGroup = _input2.default.Group;
var Option = _select2.default.Option;
var FormItem = _form2.default.Item;

var TaskCollapse = _wrapComponent('TaskCollapse')(function (_Component) {
    _inherits(TaskCollapse, _Component);

    function TaskCollapse(props) {
        _classCallCheck(this, TaskCollapse);

        //console.log(this.props)
        var _this = _possibleConstructorReturn(this, (TaskCollapse.__proto__ || Object.getPrototypeOf(TaskCollapse)).call(this, props));

        _this.state = {
            result: {},
            error: {},
            help: {},
            recCph: [], //后台请求回来的车牌号数组
            confirmLoading: false,
            visible: false,
            imgVisible: false,
            errorMessage: "",
            message: ""
        };
        _this.CphValue = ""; //后面的车牌号
        _this.cphId = ""; //车牌号ID
        _this.cphPrefix = ""; //车牌号前缀
        _this.objCph = {}; //车牌号单独的对象
        return _this;
    }

    _createClass(TaskCollapse, [{
        key: 'callback',
        value: function callback(key) {
            //console.log(key);
        }
    }, {
        key: 'changecphValue',
        value: function changecphValue(CphValue) {
            this.CphValue = CphValue;
            var cph = this.cphPrefix + CphValue;
            this.objCph[this.cphId] = cph;
        }
    }, {
        key: 'selectInfoErrorMessage',
        value: function selectInfoErrorMessage(errorMessage) {
            this.setState({
                errorMessage: errorMessage
            });
        }
    }, {
        key: 'onChange',
        value: function onChange(id, e) {
            //console.log(id);
            var result = this.state.result;
            if ((typeof e === 'undefined' ? 'undefined' : _typeof(e)) == "object" || typeof e == "proxy") result[id] = e.target.value;else result[id] = e;
            this.setState({
                result: result
            });
            //console.log(result);
        }
    }, {
        key: 'chepaihaoChange',
        value: function chepaihaoChange(id, value) {
            // console.log(id,value);
            // console.log(this.CphValue);
            this.cphId = id;
            this.cphPrefix = value;
            var self = this;
            $.ajax({
                type: "get",
                url: self.props.chepaihaoUrl,
                dataType: 'json',
                contentType: 'application/json',
                success: function success(data) {
                    self.setState({
                        recCph: data
                    });
                },
                error: function error(data) {
                    alert("失败");
                }
            });
        }
    }, {
        key: 'formSubmit',
        value: function formSubmit() {
            var _this2 = this;

            var key = window.location.pathname.substring(window.location.pathname.lastIndexOf("/") + 1);
            this.props.form.validateFields(function (err, values) {
                if (_this2.state.errorMessage == "" || _this2.state.errorMessage == null) {
                    var self = _this2;
                    if (!err) {
                        var result = Object.assign(_this2.state.result, _this2.objCph);
                        console.log(result);
                        $.ajax({
                            type: "POST",
                            url: self.props.submitTasksUrl + key,
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
                    } else {
                        return;
                    }
                } else {
                    return;
                }
            });
        }
    }, {
        key: 'showModal',
        value: function showModal() {
            this.setState({
                visible: true
            });
        }
    }, {
        key: 'handleOk',
        value: function handleOk() {
            var _this3 = this;

            this.props.form.validateFields(function (err, values) {
                var flag = false;
                if (values.reason) {
                    //这里要自己手写验证，formItem嵌套formItem点同意的时候也会验证这个属性，会导致同意不通过
                    _this3.setState({
                        message: ""
                    });
                    flag = true;
                } else {
                    _this3.setState({
                        message: "请输入理由在提交"
                    });
                }
                values["taskId"] = window.location.pathname.substring(window.location.pathname.lastIndexOf("/") + 1);
                if (flag) {
                    var self = _this3;
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
        value: function handleCancel() {
            this.setState({
                visible: false
            });
        }
    }, {
        key: 'genPanels',
        value: function genPanels() {
            var conStyle = {
                textAlign: "right",
                height: "28px",
                lineHeight: "28px"
            };
            var inputGroup;
            var self = this;
            var getFieldDecorator = self.props.form.getFieldDecorator;

            var formItemLayout = {
                labelCol: { span: 4 },
                wrapperCol: { span: 20 }
            };
            var panels = self.props.data.map(function (col, index) {
                //如果有localVariables属性的
                if (col.variables) {
                    inputGroup = col.variables.map(function (i) {
                        return _react3.default.createElement(
                            'div',
                            null,
                            _react3.default.createElement(
                                InputGroup,
                                { style: conStyle },
                                _react3.default.createElement(
                                    _col2.default,
                                    { span: '4' },
                                    _react3.default.createElement(
                                        'span',
                                        null,
                                        i.name
                                    )
                                ),
                                _react3.default.createElement(
                                    _col2.default,
                                    { span: '16' },
                                    _react3.default.createElement(_input2.default, { defaultValue: i.value, disabled: true })
                                )
                            ),
                            _react3.default.createElement('br', null)
                        );
                    });
                    return _react3.default.createElement(
                        Panel,
                        { header: col.name, key: self.props.data.length - index },
                        _react3.default.createElement(
                            'div',
                            null,
                            _react3.default.createElement(
                                InputGroup,
                                { style: conStyle },
                                _react3.default.createElement(
                                    _col2.default,
                                    { span: '4' },
                                    _react3.default.createElement(
                                        'span',
                                        null,
                                        '\u4EFB\u52A1\u540D\u79F0\uFF1A'
                                    )
                                ),
                                _react3.default.createElement(
                                    _col2.default,
                                    { span: '16' },
                                    _react3.default.createElement(_input2.default, { defaultValue: col.name, disabled: true })
                                )
                            ),
                            _react3.default.createElement('br', null),
                            _react3.default.createElement(
                                InputGroup,
                                { style: conStyle },
                                _react3.default.createElement(
                                    _col2.default,
                                    { span: '4' },
                                    _react3.default.createElement(
                                        'span',
                                        null,
                                        '\u5904\u7406\u4EBA\uFF1A'
                                    )
                                ),
                                _react3.default.createElement(
                                    _col2.default,
                                    { span: '16' },
                                    _react3.default.createElement(_input2.default, { defaultValue: col.assignee, disabled: true })
                                )
                            ),
                            _react3.default.createElement('br', null),
                            _react3.default.createElement(
                                InputGroup,
                                { style: conStyle },
                                _react3.default.createElement(
                                    _col2.default,
                                    { span: '4' },
                                    _react3.default.createElement(
                                        'span',
                                        null,
                                        '\u5904\u7406\u65F6\u95F4\uFF1A'
                                    )
                                ),
                                _react3.default.createElement(
                                    _col2.default,
                                    { span: '16' },
                                    _react3.default.createElement(_input2.default, { defaultValue: col.time || col.endTime || col.startTime, disabled: true })
                                )
                            ),
                            _react3.default.createElement('br', null)
                        ),
                        inputGroup
                    );
                }
                //如果有formProperties属性的 
                else if (col.formProperties) {
                        inputGroup = col.formProperties.map(function (i) {
                            //console.log(i);
                            var spanR;
                            var typeOfInput = i.type;
                            //判断类型的
                            switch (typeOfInput) {
                                case "chepaihao":
                                    spanR = _react3.default.createElement(
                                        FormItem,
                                        _extends({
                                            label: i.name
                                        }, formItemLayout),
                                        getFieldDecorator(i.name, {
                                            rules: [{ required: true, message: '该字段不能为空!' }]
                                        })(_react3.default.createElement(
                                            'div',
                                            null,
                                            _react3.default.createElement(
                                                InputGroup,
                                                { compact: true, style: { width: '100%' } },
                                                _react3.default.createElement(
                                                    _select2.default,
                                                    { style: { width: '15%' }, placeholder: '\u8F66\u724C\u5F52\u5C5E\u5730', onChange: self.chepaihaoChange.bind(self, i.id) },
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
                                                _react3.default.createElement(_SelectInfo2.default, _extends({ selectInfoErrorMessage: this.selectInfoErrorMessage.bind(this), changecphValue: self.changecphValue.bind(self), style: { width: '50%', display: 'inlineBlock' } }, pageUrls, { recCph: self.state.recCph }, self.props))
                                            )
                                        ))
                                    );
                                    break;
                                case "boolean":
                                    spanR = _react3.default.createElement(
                                        FormItem,
                                        _extends({
                                            label: i.name
                                        }, formItemLayout),
                                        getFieldDecorator(i.name, {
                                            rules: [{ required: true, message: '该字段不能为空!' }]
                                        })(_react3.default.createElement(
                                            RadioGroup,
                                            { style: { width: '100%' }, onChange: self.onChange.bind(self, i.id) },
                                            _react3.default.createElement(
                                                RadioButton,
                                                { value: '\u662F' },
                                                '\u662F'
                                            ),
                                            _react3.default.createElement(
                                                RadioButton,
                                                { value: '\u5426' },
                                                '\u5426'
                                            )
                                        ))
                                    );
                                    break;
                                case "number":
                                    spanR = _react3.default.createElement(
                                        FormItem,
                                        _extends({
                                            label: i.name
                                        }, formItemLayout),
                                        getFieldDecorator(i.name, {
                                            rules: [{ required: true, message: '该字段不能为空!' }]
                                        })(_react3.default.createElement(_inputNumber2.default, { style: { width: '100%' }, min: 0, max: 100, onChange: self.onChange.bind(self, i.id) }))
                                    );
                                    break;
                                case "select":
                                    spanR = _react3.default.createElement(
                                        FormItem,
                                        _extends({
                                            label: i.name
                                        }, formItemLayout),
                                        getFieldDecorator(i.name, {
                                            rules: [{ required: true, message: '该字段不能为空!' }]
                                        })(_react3.default.createElement(
                                            _select2.default,
                                            {
                                                showSearch: true,
                                                style: { width: '100%' },
                                                placeholder: 'Select a person',
                                                optionFilterProp: 'children',
                                                onChange: self.onChange.bind(self, i.id),
                                                filterOption: function filterOption(input, option) {
                                                    return option.props.value.toLowerCase().indexOf(input.toLowerCase()) >= 0;
                                                }
                                            },
                                            _react3.default.createElement(
                                                Option,
                                                { value: 'jack' },
                                                'Jack'
                                            ),
                                            _react3.default.createElement(
                                                Option,
                                                { value: 'lucy' },
                                                'Lucy'
                                            ),
                                            _react3.default.createElement(
                                                Option,
                                                { value: 'tom' },
                                                'Tom'
                                            )
                                        ))
                                    );
                                    break;
                                default:
                                    spanR = _react3.default.createElement(
                                        FormItem,
                                        _extends({
                                            label: i.name
                                        }, formItemLayout),
                                        getFieldDecorator(i.name, {
                                            rules: [{ required: true, message: '该字段不能为空!' }]
                                        })(_react3.default.createElement(_input2.default, { onChange: self.onChange.bind(self, i.id) }))
                                    );
                            }
                            return spanR;
                        });
                        return _react3.default.createElement(
                            Panel,
                            { header: col.name, key: self.props.data.length - index },
                            _react3.default.createElement(
                                _form2.default,
                                null,
                                inputGroup,
                                _react3.default.createElement(
                                    FormItem,
                                    {
                                        wrapperCol: { span: 8, offset: 4 }
                                    },
                                    _react3.default.createElement(
                                        _button2.default,
                                        { type: 'danger', style: { marginLeft: 5, width: 100 }, onClick: self.showModal.bind(self) },
                                        '\u9000\u56DE'
                                    ),
                                    _react3.default.createElement(
                                        _button2.default,
                                        { type: 'primary', style: { marginLeft: 5, width: 100 }, onClick: self.formSubmit.bind(self), className: 'login-form-button' },
                                        '\u540C\u610F'
                                    ),
                                    _react3.default.createElement(
                                        _modal2.default,
                                        {
                                            title: '\u63D0\u793A\u4FE1\u606F',
                                            visible: self.state.visible,
                                            confirmLoading: self.state.confirmLoading,
                                            onOk: self.handleOk.bind(self),
                                            onCancel: self.handleCancel.bind(self)
                                        },
                                        _react3.default.createElement(
                                            FormItem,
                                            _extends({
                                                label: '\u9000\u56DE\u7406\u7531',
                                                style: { 'width': '100%' }
                                            }, formItemLayout),
                                            getFieldDecorator('reason')(_react3.default.createElement(
                                                'div',
                                                null,
                                                _react3.default.createElement(_input2.default, { style: { 'width': '100%' } }),
                                                _react3.default.createElement(
                                                    'span',
                                                    { style: { color: '#F04134' } },
                                                    self.state.message
                                                )
                                            ))
                                        )
                                    )
                                )
                            )
                        );
                    }
            });
            return panels;
        }
    }, {
        key: 'genProcessHisInfoRows',
        value: function genProcessHisInfoRows() {
            var conStyle = {
                textAlign: "right",
                height: "28px",
                lineHeight: "28px"
            };
            var processHisInfo = this.props.processHisInfo;
            var rows = processHisInfo.map(function (rows) {
                return _react3.default.createElement(
                    'div',
                    null,
                    _react3.default.createElement(
                        'div',
                        { style: conStyle },
                        _react3.default.createElement(
                            _col2.default,
                            { span: '4', style: { textAlign: 'right' } },
                            _react3.default.createElement(
                                'span',
                                null,
                                '\u7533\u8BF7\u4EBA\uFF1A'
                            )
                        ),
                        _react3.default.createElement(
                            _col2.default,
                            { span: '18', style: { textAlign: 'left' } },
                            _react3.default.createElement(
                                'span',
                                null,
                                rows.startUserId
                            )
                        )
                    ),
                    _react3.default.createElement(
                        'div',
                        { style: conStyle },
                        _react3.default.createElement(
                            _col2.default,
                            { span: '4', style: { textAlign: 'right' } },
                            _react3.default.createElement(
                                'span',
                                null,
                                '\u5F00\u59CB\u65F6\u95F4\uFF1A'
                            )
                        ),
                        _react3.default.createElement(
                            _col2.default,
                            { span: '18', style: { textAlign: 'left' } },
                            _react3.default.createElement(
                                'span',
                                null,
                                rows.startTime
                            )
                        )
                    ),
                    _react3.default.createElement(
                        'div',
                        { style: conStyle },
                        _react3.default.createElement(
                            _col2.default,
                            { span: '4', style: { textAlign: 'right' } },
                            _react3.default.createElement(
                                'span',
                                null,
                                '\u7ED3\u675F\u65F6\u95F4\uFF1A'
                            )
                        ),
                        _react3.default.createElement(
                            _col2.default,
                            { span: '18', style: { textAlign: 'left' } },
                            _react3.default.createElement(
                                'span',
                                null,
                                rows.endTime || "尚未结束"
                            )
                        )
                    )
                );
            });
            return rows;
        }
    }, {
        key: 'genProcessVarInfoRows',
        value: function genProcessVarInfoRows() {
            var processVarInfo = this.props.processVarInfo;
            var conStyle = {
                textAlign: "right",
                height: "28px",
                lineHeight: "28px"
            };
            var rows = processVarInfo.map(function (row) {
                var scroreStyle = {};
                if (row.variable.name == "自评分数" || row.variable.name == "考核小组打分" || row.variable.name == "部门评分") {
                    scroreStyle = { color: "red" };
                } else {
                    scroreStyle = {};
                }
                return _react3.default.createElement(
                    'div',
                    { style: conStyle },
                    _react3.default.createElement(
                        _col2.default,
                        { span: '4', style: { textAlign: 'right' } },
                        _react3.default.createElement(
                            'span',
                            null,
                            row.variable.name,
                            '\uFF1A'
                        )
                    ),
                    _react3.default.createElement(
                        _col2.default,
                        { span: '18', style: { textAlign: 'left' } },
                        _react3.default.createElement(
                            'span',
                            { style: scroreStyle },
                            row.variable.value
                        )
                    )
                );
            });
            return rows;
        }
    }, {
        key: 'showImgModal',
        value: function showImgModal() {
            this.setState({
                imgVisible: true
            });
        }
    }, {
        key: 'onImgOk',
        value: function onImgOk() {
            this.setState({
                imgVisible: false
            });
        }
    }, {
        key: 'render',
        value: function render() {
            var h3Style = {
                textAlign: "left",
                height: "40px",
                width: '100%',
                lineHeight: "40px",
                borderRadius: '3px',
                backgroundColor: "#ddd",
                paddingLeft: '10px',
                color: '#252525'
            };
            var processInstanceId = "";
            if (this.props.processImgData != "") {
                processInstanceId = this.props.processImgData[0].processInstanceId;
            }
            return _react3.default.createElement(
                'div',
                null,
                _react3.default.createElement(
                    'p',
                    { style: h3Style },
                    '\u6D41\u7A0B\u4FE1\u606F'
                ),
                _react3.default.createElement(
                    'div',
                    { className: 'processInfos' },
                    _react3.default.createElement(
                        'div',
                        { className: 'processInfo' },
                        this.genProcessHisInfoRows(),
                        this.genProcessVarInfoRows()
                    ),
                    _react3.default.createElement('img', { onClick: this.showImgModal.bind(this), title: '\u70B9\u51FB\u770B\u5927\u56FE', src: "/DZOMS/ky/runtime/process-instances/" + processInstanceId + "/diagram", className: 'processImg' }),
                    _react3.default.createElement('div', { style: { clear: 'both' } }),
                    _react3.default.createElement(
                        _modal2.default,
                        {
                            width: '100%',
                            title: '\u6D41\u7A0B\u56FE',
                            visible: this.state.imgVisible,
                            onOk: this.onImgOk.bind(this),
                            onCancel: this.onImgOk.bind(this)
                        },
                        _react3.default.createElement(
                            'div',
                            { style: { width: '95%', 'overflowX': 'scroll' } },
                            _react3.default.createElement('img', { src: "/DZOMS/ky/runtime/process-instances/" + processInstanceId + "/diagram" })
                        )
                    )
                ),
                _react3.default.createElement(
                    _collapse2.default,
                    { defaultActiveKey: ["1", "2"], onChange: this.callback.bind(this) },
                    this.genPanels()
                ),
                this.state.collapseIndex
            );
        }
    }]);

    return TaskCollapse;
}(_react2.Component));

var WrappedTaskCollapse = _form2.default.create()(TaskCollapse);

var TaskDetails = _wrapComponent('TaskDetails')(function (_React$Component) {
    _inherits(TaskDetails, _React$Component);

    function TaskDetails(props) {
        _classCallCheck(this, TaskDetails);

        var _this4 = _possibleConstructorReturn(this, (TaskDetails.__proto__ || Object.getPrototypeOf(TaskDetails)).call(this, props));

        _this4.state = {
            recResult: [],
            processVarInfo: [],
            processHisInfo: [],
            processName: "",
            processImgData: []
        };
        _this4.key = "";
        return _this4;
    }

    _createClass(TaskDetails, [{
        key: 'getTaskData',
        value: function getTaskData(id, taskDataList) {
            //console.log(this.props.getTaskDataUrl);
            var self = this;
            var promise = new Promise(function (resolve, reject) {
                $.ajax({
                    type: "GET",
                    url: self.props.getTaskDataUrl + id,
                    dataType: 'json',
                    contentType: 'application/json',
                    success: function success(result) {
                        taskDataList[id]['assignee'] = result.assignee;
                        taskDataList[id]['time'] = result.endTime;
                        taskDataList[id]['name'] = result.name;
                        resolve("");
                    },
                    error: function error(result) {
                        alert("操作失败");
                        reject("");
                    }
                });
            });
            return promise;
        }
    }, {
        key: 'getRuntimeData',
        value: function getRuntimeData(key, taskDataList) {
            var promise = new Promise(function (resolve, reject) {
                $.ajax({
                    type: "GET",
                    url: "/DZOMS/ky/form/form-data?taskId=" + key,
                    dataType: 'json',
                    contentType: 'application/json',
                    success: function success(result) {
                        taskDataList[key] = result;
                        taskDataList[key].name = "当前处理节点";
                        resolve(taskDataList[key]);
                    },
                    error: function error(result) {
                        alert("操作失败");
                        reject("");
                    }
                });
            });
            return promise;
        }
    }, {
        key: 'componentDidMount',
        value: function () {
            var _ref = _asyncToGenerator( /*#__PURE__*/_regenerator2.default.mark(function _callee() {
                var self, key, recResult;
                return _regenerator2.default.wrap(function _callee$(_context) {
                    while (1) {
                        switch (_context.prev = _context.next) {
                            case 0:
                                self = this;
                                key = window.location.pathname.substring(window.location.pathname.lastIndexOf("/") + 1);
                                recResult = [];
                                //console.log(key);

                                $.ajax({
                                    type: "GET",
                                    url: "/DZOMS/ky/runtime/tasks/" + key,
                                    dataType: 'json',
                                    contentType: 'application/json',
                                    success: function success(result) {
                                        //console.log(result);
                                        recResult.splice(0, 0, result);
                                        console.log(result);
                                        window.processInstanceId = result.processInstanceId;
                                        $.ajax({
                                            type: "GET",
                                            url: "/DZOMS/ky/history/historic-process-instances/" + window.processInstanceId + "?size=1000",
                                            dataType: 'json',
                                            contentType: 'application/json',
                                            success: function success(result) {
                                                var processHisInfo = [];
                                                processHisInfo.push(result);
                                                //console.log(processHisInfo);
                                                self.setState({
                                                    processHisInfo: processHisInfo
                                                });
                                            },
                                            error: function error(result) {
                                                alert("操作失败");
                                            }
                                        });
                                        // console.log(window.processInstanceId);
                                        $.ajax({
                                            type: "GET",
                                            url: "/DZOMS/ky/history/historic-variable-instances?processInstanceId=" + window.processInstanceId + "&size=1000",
                                            dataType: 'json',
                                            contentType: 'application/json',
                                            success: function success(result) {
                                                if (result.data) {
                                                    var expNull = null;
                                                    var taskDataList = {};
                                                    var startFormData = [];
                                                    for (var i = 0; i < result.data.length; i++) {
                                                        if (result.data[i].taskId === expNull) {
                                                            startFormData.push(result.data[i]);
                                                        }
                                                    }
                                                    self.setState({
                                                        processVarInfo: startFormData
                                                    });
                                                }
                                            },
                                            error: function error(result) {
                                                alert("操作失败");
                                            }
                                        });
                                        $.ajax({
                                            type: "GET",
                                            url: "/DZOMS/ky/history/historic-task-instances?processInstanceId=" + window.processInstanceId + "&size=1000",
                                            dataType: 'json',
                                            contentType: 'application/json',
                                            success: function success(result) {
                                                if (result.data) {
                                                    //console.log(result);  
                                                    var expNull = null;
                                                    if (self.props.history) {
                                                        self.setState({
                                                            recResult: result.data
                                                        });
                                                    } else {
                                                        var taskArray = [];
                                                        if (result.data.length > 1) {
                                                            taskArray = result.data.slice(0, result.data.length - 1);
                                                        }
                                                        var taskDataList = {};
                                                        self.getRuntimeData(key, taskDataList).then(function (data) {
                                                            taskArray.push(data);
                                                            self.setState({
                                                                recResult: taskArray,
                                                                processImgData: result.data
                                                            });
                                                        });
                                                    }
                                                }
                                            },
                                            error: function error(result) {
                                                alert("操作失败");
                                            }
                                        });
                                    },
                                    error: function error(result) {
                                        alert("操作失败");
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
            var _this5 = this;

            var data = this.state.recResult;
            return _react3.default.createElement(
                'div',
                null,
                _react3.default.createElement(WrappedTaskCollapse, _extends({}, pageUrls, { processImgData: this.state.processImgData, data: this.state.recResult, processVarInfo: this.state.processVarInfo, processHisInfo: this.state.processHisInfo })),
                _react3.default.createElement(
                    'div',
                    { style: { margin: 0, marginTop: 20, textAlign: 'center' } },
                    _react3.default.createElement(
                        _button2.default,
                        { type: 'primary', style: { marginLeft: 5, width: 100 }, onClick: function onClick() {
                                return window.location = _this5.props.jumpUrl;
                            }, className: 'login-form-button' },
                        '\u8FD4\u56DE'
                    )
                )
            );
        }
    }]);

    return TaskDetails;
}(_react3.default.Component));

if (document.getElementById("taskDetails")) {
    _reactDom2.default.render(_react3.default.createElement(TaskDetails, pageUrls), document.getElementById("taskDetails"));
}
exports.default = TaskDetails;
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(15)(module), __webpack_require__(16)))

/***/ }),

/***/ 239:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
  value: true
});

var _Collapse = __webpack_require__(520);

var _Collapse2 = _interopRequireDefault(_Collapse);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

exports['default'] = _Collapse2['default'];
module.exports = exports['default'];

/***/ }),

/***/ 240:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


__webpack_require__(22);

__webpack_require__(1021);

/***/ }),

/***/ 495:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function($) {

Object.defineProperty(exports, "__esModule", {
    value: true
});

var _regenerator = __webpack_require__(56);

var _regenerator2 = _interopRequireDefault(_regenerator);

var _form = __webpack_require__(33);

var _form2 = _interopRequireDefault(_form);

var _select = __webpack_require__(41);

var _select2 = _interopRequireDefault(_select);

var _input = __webpack_require__(28);

var _input2 = _interopRequireDefault(_input);

var _collapse = __webpack_require__(239);

var _collapse2 = _interopRequireDefault(_collapse);

var _radio = __webpack_require__(96);

var _radio2 = _interopRequireDefault(_radio);

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

__webpack_require__(34);

__webpack_require__(44);

__webpack_require__(27);

__webpack_require__(240);

__webpack_require__(116);

var _react = __webpack_require__(0);

var _react2 = _interopRequireDefault(_react);

var _reactDom = __webpack_require__(11);

var _reactDom2 = _interopRequireDefault(_reactDom);

var _SelectInfo = __webpack_require__(81);

var _SelectInfo2 = _interopRequireDefault(_SelectInfo);

var _taskDetails = __webpack_require__(233);

var _taskDetails2 = _interopRequireDefault(_taskDetails);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var RadioGroup = _radio2.default.Group;
var RadioButton = _radio2.default.Button;
var Panel = _collapse2.default.Panel;
var InputGroup = _input2.default.Group;
var Option = _select2.default.Option;
var FormItem = _form2.default.Item;

var HistoryTaskDetails = function (_TaskDetails) {
    _inherits(HistoryTaskDetails, _TaskDetails);

    function HistoryTaskDetails() {
        _classCallCheck(this, HistoryTaskDetails);

        return _possibleConstructorReturn(this, (HistoryTaskDetails.__proto__ || Object.getPrototypeOf(HistoryTaskDetails)).apply(this, arguments));
    }

    _createClass(HistoryTaskDetails, [{
        key: 'componentDidMount',
        value: function () {
            var _ref = _asyncToGenerator( /*#__PURE__*/_regenerator2.default.mark(function _callee() {
                var self, recResult;
                return _regenerator2.default.wrap(function _callee$(_context) {
                    while (1) {
                        switch (_context.prev = _context.next) {
                            case 0:
                                self = this;

                                window.processInstanceId = window.location.pathname.substring(window.location.pathname.lastIndexOf("/") + 1);
                                recResult = [];
                                //console.log(key);

                                $.ajax({
                                    type: "GET",
                                    url: "/DZOMS/ky/history/historic-process-instances/" + window.processInstanceId,
                                    dataType: 'json',
                                    contentType: 'application/json',
                                    success: function success(result) {
                                        var processHisInfo = [];
                                        processHisInfo.push(result);
                                        //console.log(processHisInfo);
                                        self.setState({
                                            processHisInfo: processHisInfo
                                        });
                                    },
                                    error: function error(result) {
                                        alert("操作失败");
                                    }
                                });
                                $.ajax({
                                    type: "GET",
                                    url: "/DZOMS/ky/history/historic-variable-instances?processInstanceId=" + window.processInstanceId,
                                    dataType: 'json',
                                    contentType: 'application/json',
                                    success: function success(result) {
                                        if (result.data) {
                                            var expNull = null;
                                            var taskDataList = {};
                                            var startFormData = [];
                                            for (var i = 0; i < result.data.length; i++) {
                                                if (result.data[i].taskId === expNull) {
                                                    startFormData.push(result.data[i]);
                                                }
                                            }
                                            self.setState({
                                                // recResult:taskArray,
                                                processVarInfo: startFormData
                                            });
                                        }
                                    },
                                    error: function error(result) {
                                        alert("操作失败");
                                    }
                                });
                                $.ajax({
                                    type: "GET",
                                    url: "/DZOMS/ky/history/historic-task-instances?processInstanceId=" + window.processInstanceId,
                                    dataType: 'json',
                                    contentType: 'application/json',
                                    success: function success(result) {
                                        if (result.data) {
                                            //console.log(result);  
                                            self.setState({
                                                recResult: result.data,
                                                processImgData: result.data
                                            });
                                        }
                                    },
                                    error: function error(result) {
                                        alert("操作失败");
                                    }
                                });

                            case 6:
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
    }]);

    return HistoryTaskDetails;
}(_taskDetails2.default);

if (document.getElementById("historyTaskDetails")) {
    _reactDom2.default.render(_react2.default.createElement(HistoryTaskDetails, pageUrls), document.getElementById("historyTaskDetails"));
}
exports.default = HistoryTaskDetails;
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(16)))

/***/ }),

/***/ 496:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(module, $) {

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _table = __webpack_require__(29);

var _table2 = _interopRequireDefault(_table);

var _button = __webpack_require__(18);

var _button2 = _interopRequireDefault(_button);

var _index = __webpack_require__(21);

var _index2 = _interopRequireDefault(_index);

var _index3 = __webpack_require__(19);

var _index4 = _interopRequireDefault(_index3);

var _react2 = __webpack_require__(0);

var _react3 = _interopRequireDefault(_react2);

var _index5 = __webpack_require__(20);

var _index6 = _interopRequireDefault(_index5);

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

__webpack_require__(30);

__webpack_require__(23);

var _reactDom = __webpack_require__(11);

var _reactDom2 = _interopRequireDefault(_reactDom);

var _Sorter = __webpack_require__(31);

var _Sorter2 = _interopRequireDefault(_Sorter);

var _Filters = __webpack_require__(38);

var _Filters2 = _interopRequireDefault(_Filters);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var _components = {
  ProcessesList: {
    displayName: 'ProcessesList'
  }
};

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2 = (0, _index6.default)({
  filename: '/Users/huang/work/dzoms_react/components/process/processesList.js',
  components: _components,
  locals: [module],
  imports: [_react3.default]
});

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2 = (0, _index4.default)({
  filename: '/Users/huang/work/dzoms_react/components/process/processesList.js',
  components: _components,
  locals: [],
  imports: [_react3.default, _index2.default]
});

function _wrapComponent(id) {
  return function (Component) {
    return _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2(_UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2(Component, id), id);
  };
}

var ProcessesList = _wrapComponent('ProcessesList')(function (_React$Component) {
  _inherits(ProcessesList, _React$Component);

  function ProcessesList(props) {
    _classCallCheck(this, ProcessesList);

    var _this = _possibleConstructorReturn(this, (ProcessesList.__proto__ || Object.getPrototypeOf(ProcessesList)).call(this, props));

    _this.state = {
      recResult: []
    };
    return _this;
  }

  _createClass(ProcessesList, [{
    key: 'componentDidMount',
    value: function componentDidMount() {
      var self = this;
      $.ajax({
        type: "GET",
        //url: "/ky/repository/process-definitions",//?latest=true
        url: this.props.processesListUrl,
        dataType: 'json',
        contentType: 'application/json',
        success: function success(result) {
          // console.log(result.data);
          self.setState({
            recResult: result.data
          });
        },
        error: function error(result) {
          alert("操作失败");
        }
      });
    }
  }, {
    key: 'startForm',
    value: function startForm(index) {
      window.location.href = this.props.executeStartForm + this.state.recResult[index].key;
    }
  }, {
    key: 'render',
    value: function render() {
      var _this2 = this;

      var self = this;
      var filterData = new _Filters2.default().filter(this.state.recResult);
      // console.log(filterData)
      var columns = [{
        title: '序号',
        render: function render(text, record, index) {
          return _react3.default.createElement(
            'span',
            null,
            ++index
          );
        }
      }, {
        title: '流程名称',
        dataIndex: 'name',
        key: "name"
        // filters: filterData.name, //数据中name的值为空，就报错
        // sorter: (a, b) => (new Sorter().sort(a.name, b.name)),
        // onFilter: (value, record) => record.name.indexOf(value) === 0
      }, {
        title: '流程图预览',
        dataIndex: 'diagramResource',
        key: "diagramResource",
        filters: filterData.diagramResource,
        sorter: function sorter(a, b) {
          return new _Sorter2.default().sort(a.diagramResource, b.diagramResource);
        },
        onFilter: function onFilter(value, record) {
          return record.diagramResource.indexOf(value) === 0;
        }
      }, {
        title: '启动',
        key: 'action',
        render: function render(text, record, index) {
          return _react3.default.createElement(
            _button2.default,
            { onClick: _this2.startForm.bind(_this2, index) },
            '\u542F\u52A8'
          );
        }
      }];
      // columns.map(function(rows){
      //     var colName=rows.dataIndex;
      //     rows["key"]=rows.dataIndex;
      //     rows["filters"]=filterData[rows.dataIndex];
      //     rows["onFilter"]=(value, record) => record[rows.dataIndex].indexOf(value) === 0
      //     rows["sorter"]=(a, b) => (new Sorter().sort(a[rows.dataIndex], b[rows.dataIndex])) //页内排序
      //     tableColData.push(rows);
      // });
      // console.log(tableColData);
      return _react3.default.createElement(
        'div',
        null,
        _react3.default.createElement(_table2.default, { pagination: false, columns: columns, dataSource: self.state.recResult })
      );
    }
  }]);

  return ProcessesList;
}(_react3.default.Component));

if (document.getElementById("processesList")) _reactDom2.default.render(_react3.default.createElement(ProcessesList, pageUrls), document.getElementById("processesList"));
exports.default = ProcessesList;
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(15)(module), __webpack_require__(16)))

/***/ }),

/***/ 497:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(module, $) {

Object.defineProperty(exports, "__esModule", {
    value: true
});

var _button = __webpack_require__(18);

var _button2 = _interopRequireDefault(_button);

var _input = __webpack_require__(28);

var _input2 = _interopRequireDefault(_input);

var _form = __webpack_require__(33);

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

__webpack_require__(23);

__webpack_require__(27);

__webpack_require__(34);

var _reactDom = __webpack_require__(11);

var _reactDom2 = _interopRequireDefault(_reactDom);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var _components = {
    StartForm: {
        displayName: 'StartForm'
    }
};

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2 = (0, _index6.default)({
    filename: '/Users/huang/work/dzoms_react/components/process/startForm.js',
    components: _components,
    locals: [module],
    imports: [_react3.default]
});

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2 = (0, _index4.default)({
    filename: '/Users/huang/work/dzoms_react/components/process/startForm.js',
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

var StartForm = _wrapComponent('StartForm')(function (_React$Component) {
    _inherits(StartForm, _React$Component);

    function StartForm(props) {
        _classCallCheck(this, StartForm);

        var _this = _possibleConstructorReturn(this, (StartForm.__proto__ || Object.getPrototypeOf(StartForm)).call(this, props));

        _this.state = {
            recResult: [],
            processName: ""
        };
        _this.key = "";
        return _this;
    }

    _createClass(StartForm, [{
        key: 'componentDidMount',
        value: function componentDidMount() {
            this.key = window.location.href.substring(window.location.href.lastIndexOf("/") + 1);
            var key = this.key;
            var self = this;
            self.setState({
                processName: key
            });
            $.ajax({
                type: "GET",
                url: this.props.startFormUrl + key,
                //url:"/startFormRecdata",
                dataType: 'json',
                contentType: 'application/json',
                success: function success(result) {
                    self.setState({
                        recResult: result.data
                    });
                },
                error: function error(result) {
                    alert("操作失败");
                }
            });
        }
    }, {
        key: 'handleSubmit',
        value: function handleSubmit(e) {
            var _this2 = this;

            var key = this.key;
            e.preventDefault();
            var result;
            this.props.form.validateFields(function (err, values) {
                if (!err) {
                    result = values;
                    $.ajax({
                        type: "POST",
                        url: _this2.props.startFormSubmitUrl + key,
                        data: JSON.stringify(result),
                        dataType: 'json',
                        contentType: 'application/json',
                        success: function success(data) {
                            if (data.status > 0) {
                                window.location.href = "/activity/task/list";
                            }
                        },
                        error: function error(data) {
                            alert("失败");
                        }
                    });
                    console.log(result);
                } else {
                    return;
                }
            });
        }
    }, {
        key: 'genFormItem',
        value: function genFormItem() {
            var getFieldDecorator = this.props.form.getFieldDecorator;

            var data = this.state.recResult;
            var self = this;
            var formItems = data.map(function (i) {
                //console.log(i.type.mimeType);
                return _react3.default.createElement(
                    FormItem,
                    {
                        label: i.name,
                        labelCol: { span: 4 },
                        wrapperCol: { span: 12 }
                    },
                    getFieldDecorator(i.name, {
                        rules: [{ required: true, message: '该字段不能为空!' }]
                    })(_react3.default.createElement(_input2.default, null))
                );
            });
            return formItems;
        }
    }, {
        key: 'render',
        value: function render() {
            //console.log(this.state.recResult); 
            // console.log(this.state.processName);
            var getFieldDecorator = this.props.form.getFieldDecorator;

            return _react3.default.createElement(
                _form2.default,
                { onSubmit: this.handleSubmit.bind(this) },
                _react3.default.createElement(
                    FormItem,
                    {
                        label: '\u6D41\u7A0B\u540D\u79F0',
                        labelCol: { span: 4 },
                        wrapperCol: { span: 12 }
                    },
                    _react3.default.createElement(
                        'span',
                        null,
                        this.state.processName
                    )
                ),
                this.genFormItem(),
                _react3.default.createElement(
                    FormItem,
                    {
                        wrapperCol: { span: 8, offset: 4 }
                    },
                    _react3.default.createElement(
                        _button2.default,
                        { type: 'primary', htmlType: 'submit', className: 'login-form-button' },
                        '\u63D0\u4EA4'
                    )
                )
            );
        }
    }]);

    return StartForm;
}(_react3.default.Component));

var WrappedStartForm = _form2.default.create()(StartForm);
if (document.getElementById("startForm")) {
    _reactDom2.default.render(_react3.default.createElement(WrappedStartForm, pageUrls), document.getElementById("startForm"));
}
exports.default = StartForm;
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(15)(module), __webpack_require__(16)))

/***/ }),

/***/ 498:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(module, $) {

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _table = __webpack_require__(29);

var _table2 = _interopRequireDefault(_table);

var _button = __webpack_require__(18);

var _button2 = _interopRequireDefault(_button);

var _form = __webpack_require__(33);

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

__webpack_require__(30);

__webpack_require__(23);

__webpack_require__(34);

var _reactDom = __webpack_require__(11);

var _reactDom2 = _interopRequireDefault(_reactDom);

var _Sorter = __webpack_require__(31);

var _Sorter2 = _interopRequireDefault(_Sorter);

var _Filters = __webpack_require__(38);

var _Filters2 = _interopRequireDefault(_Filters);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var _components = {
  TaskList: {
    displayName: 'TaskList'
  }
};

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformHmr104ReactTransformHmrLibIndexJs2 = (0, _index6.default)({
  filename: '/Users/huang/work/dzoms_react/components/process/taskList.js',
  components: _components,
  locals: [module],
  imports: [_react3.default]
});

var _UsersHuangWorkDzoms_reactNode_modules_reactTransformCatchErrors102ReactTransformCatchErrorsLibIndexJs2 = (0, _index4.default)({
  filename: '/Users/huang/work/dzoms_react/components/process/taskList.js',
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

var TaskList = _wrapComponent('TaskList')(function (_React$Component) {
  _inherits(TaskList, _React$Component);

  function TaskList(props) {
    _classCallCheck(this, TaskList);

    var _this = _possibleConstructorReturn(this, (TaskList.__proto__ || Object.getPrototypeOf(TaskList)).call(this, props));

    _this.state = {
      recResult: [],
      processName: ""
    };
    _this.key = 0;
    return _this;
  }

  _createClass(TaskList, [{
    key: 'componentDidMount',
    value: function componentDidMount() {
      var self = this;
      $.ajax({
        type: "get",
        url: this.props.taskListUrl,
        dataType: 'json',
        contentType: 'application/json',
        success: function success(result) {
          result.data.map(function (row) {
            for (var i in row) {
              if (row[i] == null) {
                row[i] = '';
              }
            }
          });
          // console.log(result.data);
          self.setState({
            recResult: result.data
          });
        },
        error: function error(result) {
          alert("操作失败");
        }
      });
    }
  }, {
    key: 'execute',
    value: function execute(index) {
      window.location.href = this.props.executeUrl + this.state.recResult[index].id;
    }
  }, {
    key: 'render',
    value: function render() {
      var _this2 = this;

      var self = this;
      var filterData = new _Filters2.default().filter(this.state.recResult);
      var tableColData = [];
      var columns = [{
        title: '序号',
        dataIndex: 'index',
        render: function render(text, record, index) {
          return _react3.default.createElement(
            'span',
            null,
            ++index
          );
        }
      }, {
        title: '部门',
        dataIndex: 'department'
      }, {
        title: '流程名称',
        dataIndex: 'processDefinitionId'
      }, {
        title: '任务ID',
        dataIndex: 'id'
      }, {
        title: '任务名称',
        dataIndex: 'name'
      }, {
        title: '创建时间',
        dataIndex: 'createTime'
      }, {
        title: '发起人',
        dataIndex: 'starter'
      }, {
        title: '操作人',
        dataIndex: 'assignee'
      }, {
        title: '执行',
        dataIndex: 'pingfen',
        render: function render(text, record, index) {
          return _react3.default.createElement(
            _button2.default,
            { onClick: _this2.execute.bind(_this2, index, text) },
            '\u6267\u884C'
          );
        }
      }];
      columns.map(function (rows) {
        if (rows.dataIndex && rows.dataIndex != "index") {
          rows["key"] = rows.dataIndex;
          rows["filters"] = filterData[rows.dataIndex];
          rows["onFilter"] = function (value, record) {
            return record[rows.dataIndex].indexOf(value) === 0;
          };
          rows["sorter"] = function (a, b) {
            return new _Sorter2.default().sort(a[rows.dataIndex], b[rows.dataIndex]);
          }; //页内排序
          // rows["sorter"]=(a, b) => (false);
        }
        tableColData.push(rows);
      });

      return _react3.default.createElement(
        'div',
        null,
        _react3.default.createElement(_table2.default, { pagination: false, columns: tableColData, dataSource: this.state.recResult })
      );
    }
  }]);

  return TaskList;
}(_react3.default.Component));

if (document.getElementById("taskList")) {
  _reactDom2.default.render(_react3.default.createElement(TaskList, pageUrls), document.getElementById("taskList"));
}
exports.default = TaskList;
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(15)(module), __webpack_require__(16)))

/***/ }),

/***/ 520:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
    value: true
});
exports.CollapsePanel = undefined;

var _extends2 = __webpack_require__(3);

var _extends3 = _interopRequireDefault(_extends2);

var _defineProperty2 = __webpack_require__(10);

var _defineProperty3 = _interopRequireDefault(_defineProperty2);

var _createClass2 = __webpack_require__(7);

var _createClass3 = _interopRequireDefault(_createClass2);

var _classCallCheck2 = __webpack_require__(4);

var _classCallCheck3 = _interopRequireDefault(_classCallCheck2);

var _possibleConstructorReturn2 = __webpack_require__(6);

var _possibleConstructorReturn3 = _interopRequireDefault(_possibleConstructorReturn2);

var _inherits2 = __webpack_require__(5);

var _inherits3 = _interopRequireDefault(_inherits2);

var _react = __webpack_require__(0);

var _react2 = _interopRequireDefault(_react);

var _rcCollapse = __webpack_require__(838);

var _rcCollapse2 = _interopRequireDefault(_rcCollapse);

var _classnames = __webpack_require__(9);

var _classnames2 = _interopRequireDefault(_classnames);

var _openAnimation = __webpack_require__(236);

var _openAnimation2 = _interopRequireDefault(_openAnimation);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var CollapsePanel = exports.CollapsePanel = function (_React$Component) {
    (0, _inherits3['default'])(CollapsePanel, _React$Component);

    function CollapsePanel() {
        (0, _classCallCheck3['default'])(this, CollapsePanel);
        return (0, _possibleConstructorReturn3['default'])(this, (CollapsePanel.__proto__ || Object.getPrototypeOf(CollapsePanel)).apply(this, arguments));
    }

    return CollapsePanel;
}(_react2['default'].Component);

var Collapse = function (_React$Component2) {
    (0, _inherits3['default'])(Collapse, _React$Component2);

    function Collapse() {
        (0, _classCallCheck3['default'])(this, Collapse);
        return (0, _possibleConstructorReturn3['default'])(this, (Collapse.__proto__ || Object.getPrototypeOf(Collapse)).apply(this, arguments));
    }

    (0, _createClass3['default'])(Collapse, [{
        key: 'render',
        value: function render() {
            var _props = this.props,
                prefixCls = _props.prefixCls,
                _props$className = _props.className,
                className = _props$className === undefined ? '' : _props$className,
                bordered = _props.bordered;

            var collapseClassName = (0, _classnames2['default'])((0, _defineProperty3['default'])({}, prefixCls + '-borderless', !bordered), className);
            return _react2['default'].createElement(_rcCollapse2['default'], (0, _extends3['default'])({}, this.props, { className: collapseClassName }));
        }
    }]);
    return Collapse;
}(_react2['default'].Component);

exports['default'] = Collapse;

Collapse.Panel = _rcCollapse2['default'].Panel;
Collapse.defaultProps = {
    prefixCls: 'ant-collapse',
    bordered: true,
    openAnimation: (0, _extends3['default'])({}, _openAnimation2['default'], {
        appear: function appear() {}
    })
};

/***/ }),

/***/ 599:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


__webpack_require__(496);
__webpack_require__(497);
__webpack_require__(498);
__webpack_require__(233);
__webpack_require__(495);

/***/ }),

/***/ 835:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_react__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_prop_types__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_prop_types___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_prop_types__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__Panel__ = __webpack_require__(836);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__openAnimationFactory__ = __webpack_require__(839);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4_classnames__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4_classnames___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_4_classnames__);
var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

function _toConsumableArray(arr) { if (Array.isArray(arr)) { for (var i = 0, arr2 = Array(arr.length); i < arr.length; i++) { arr2[i] = arr[i]; } return arr2; } else { return Array.from(arr); } }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }







function toArray(activeKey) {
  var currentActiveKey = activeKey;
  if (!Array.isArray(currentActiveKey)) {
    currentActiveKey = currentActiveKey ? [currentActiveKey] : [];
  }
  return currentActiveKey;
}

var Collapse = function (_Component) {
  _inherits(Collapse, _Component);

  function Collapse(props) {
    _classCallCheck(this, Collapse);

    var _this = _possibleConstructorReturn(this, (Collapse.__proto__ || Object.getPrototypeOf(Collapse)).call(this, props));

    var _this$props = _this.props,
        activeKey = _this$props.activeKey,
        defaultActiveKey = _this$props.defaultActiveKey;

    var currentActiveKey = defaultActiveKey;
    if ('activeKey' in _this.props) {
      currentActiveKey = activeKey;
    }

    _this.state = {
      openAnimation: _this.props.openAnimation || __webpack_require__.i(__WEBPACK_IMPORTED_MODULE_3__openAnimationFactory__["a" /* default */])(_this.props.prefixCls),
      activeKey: toArray(currentActiveKey)
    };
    return _this;
  }

  _createClass(Collapse, [{
    key: 'componentWillReceiveProps',
    value: function componentWillReceiveProps(nextProps) {
      if ('activeKey' in nextProps) {
        this.setState({
          activeKey: toArray(nextProps.activeKey)
        });
      }
      if ('openAnimation' in nextProps) {
        this.setState({
          openAnimation: nextProps.openAnimation
        });
      }
    }
  }, {
    key: 'onClickItem',
    value: function onClickItem(key) {
      var activeKey = this.state.activeKey;
      if (this.props.accordion) {
        activeKey = activeKey[0] === key ? [] : [key];
      } else {
        activeKey = [].concat(_toConsumableArray(activeKey));
        var index = activeKey.indexOf(key);
        var isActive = index > -1;
        if (isActive) {
          // remove active state
          activeKey.splice(index, 1);
        } else {
          activeKey.push(key);
        }
      }
      this.setActiveKey(activeKey);
    }
  }, {
    key: 'getItems',
    value: function getItems() {
      var _this2 = this;

      var activeKey = this.state.activeKey;
      var _props = this.props,
          prefixCls = _props.prefixCls,
          accordion = _props.accordion,
          destroyInactivePanel = _props.destroyInactivePanel;

      var newChildren = [];

      __WEBPACK_IMPORTED_MODULE_0_react__["Children"].forEach(this.props.children, function (child, index) {
        if (!child) return;
        // If there is no key provide, use the panel order as default key
        var key = child.key || String(index);
        var _child$props = child.props,
            header = _child$props.header,
            headerClass = _child$props.headerClass,
            disabled = _child$props.disabled;

        var isActive = false;
        if (accordion) {
          isActive = activeKey[0] === key;
        } else {
          isActive = activeKey.indexOf(key) > -1;
        }

        var props = {
          key: key,
          header: header,
          headerClass: headerClass,
          isActive: isActive,
          prefixCls: prefixCls,
          destroyInactivePanel: destroyInactivePanel,
          openAnimation: _this2.state.openAnimation,
          children: child.props.children,
          onItemClick: disabled ? null : function () {
            return _this2.onClickItem(key);
          }
        };

        newChildren.push(__WEBPACK_IMPORTED_MODULE_0_react___default.a.cloneElement(child, props));
      });

      return newChildren;
    }
  }, {
    key: 'setActiveKey',
    value: function setActiveKey(activeKey) {
      if (!('activeKey' in this.props)) {
        this.setState({ activeKey: activeKey });
      }
      this.props.onChange(this.props.accordion ? activeKey[0] : activeKey);
    }
  }, {
    key: 'render',
    value: function render() {
      var _classNames;

      var _props2 = this.props,
          prefixCls = _props2.prefixCls,
          className = _props2.className,
          style = _props2.style;

      var collapseClassName = __WEBPACK_IMPORTED_MODULE_4_classnames___default()((_classNames = {}, _defineProperty(_classNames, prefixCls, true), _defineProperty(_classNames, className, !!className), _classNames));
      return __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
        'div',
        { className: collapseClassName, style: style },
        this.getItems()
      );
    }
  }]);

  return Collapse;
}(__WEBPACK_IMPORTED_MODULE_0_react__["Component"]);

Collapse.propTypes = {
  children: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.any,
  prefixCls: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.string,
  activeKey: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.oneOfType([__WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.string, __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.arrayOf(__WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.string)]),
  defaultActiveKey: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.oneOfType([__WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.string, __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.arrayOf(__WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.string)]),
  openAnimation: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.object,
  onChange: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.func,
  accordion: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.bool,
  className: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.string,
  style: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.object,
  destroyInactivePanel: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.bool
};

Collapse.defaultProps = {
  prefixCls: 'rc-collapse',
  onChange: function onChange() {},

  accordion: false,
  destroyInactivePanel: false
};

Collapse.Panel = __WEBPACK_IMPORTED_MODULE_2__Panel__["a" /* default */];

/* harmony default export */ __webpack_exports__["a"] = (Collapse);

/***/ }),

/***/ 836:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_react__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_prop_types__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_prop_types___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_prop_types__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_classnames__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_classnames___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_2_classnames__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__PanelContent__ = __webpack_require__(837);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4_rc_animate__ = __webpack_require__(65);
var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }







var CollapsePanel = function (_Component) {
  _inherits(CollapsePanel, _Component);

  function CollapsePanel() {
    _classCallCheck(this, CollapsePanel);

    return _possibleConstructorReturn(this, (CollapsePanel.__proto__ || Object.getPrototypeOf(CollapsePanel)).apply(this, arguments));
  }

  _createClass(CollapsePanel, [{
    key: 'handleItemClick',
    value: function handleItemClick() {
      if (this.props.onItemClick) {
        this.props.onItemClick();
      }
    }
  }, {
    key: 'render',
    value: function render() {
      var _classNames2;

      var _props = this.props,
          className = _props.className,
          id = _props.id,
          style = _props.style,
          prefixCls = _props.prefixCls,
          header = _props.header,
          headerClass = _props.headerClass,
          children = _props.children,
          isActive = _props.isActive,
          showArrow = _props.showArrow,
          destroyInactivePanel = _props.destroyInactivePanel,
          disabled = _props.disabled;

      var headerCls = __WEBPACK_IMPORTED_MODULE_2_classnames___default()(prefixCls + '-header', _defineProperty({}, headerClass, headerClass));
      var itemCls = __WEBPACK_IMPORTED_MODULE_2_classnames___default()((_classNames2 = {}, _defineProperty(_classNames2, prefixCls + '-item', true), _defineProperty(_classNames2, prefixCls + '-item-active', isActive), _defineProperty(_classNames2, prefixCls + '-item-disabled', disabled), _classNames2), className);
      return __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
        'div',
        { className: itemCls, style: style, id: id, role: 'tablist' },
        __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
          'div',
          {
            className: headerCls,
            onClick: this.handleItemClick.bind(this),
            role: 'tab',
            'aria-expanded': isActive
          },
          showArrow && __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement('i', { className: 'arrow' }),
          header
        ),
        __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
          __WEBPACK_IMPORTED_MODULE_4_rc_animate__["default"],
          {
            showProp: 'isActive',
            exclusive: true,
            component: '',
            animation: this.props.openAnimation
          },
          __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
            __WEBPACK_IMPORTED_MODULE_3__PanelContent__["a" /* default */],
            {
              prefixCls: prefixCls,
              isActive: isActive,
              destroyInactivePanel: destroyInactivePanel
            },
            children
          )
        )
      );
    }
  }]);

  return CollapsePanel;
}(__WEBPACK_IMPORTED_MODULE_0_react__["Component"]);

CollapsePanel.propTypes = {
  className: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.oneOfType([__WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.string, __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.object]),
  id: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.string,
  children: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.any,
  openAnimation: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.object,
  prefixCls: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.string,
  header: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.oneOfType([__WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.string, __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.number, __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.node]),
  headerClass: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.string,
  showArrow: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.bool,
  isActive: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.bool,
  onItemClick: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.func,
  style: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.object,
  destroyInactivePanel: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.bool,
  disabled: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.bool
};

CollapsePanel.defaultProps = {
  showArrow: true,
  isActive: false,
  destroyInactivePanel: false,
  onItemClick: function onItemClick() {},

  headerClass: ''
};

/* harmony default export */ __webpack_exports__["a"] = (CollapsePanel);

/***/ }),

/***/ 837:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_react__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_prop_types__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_prop_types___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_prop_types__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_classnames__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_classnames___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_2_classnames__);
var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }





var PanelContent = function (_Component) {
  _inherits(PanelContent, _Component);

  function PanelContent() {
    _classCallCheck(this, PanelContent);

    return _possibleConstructorReturn(this, (PanelContent.__proto__ || Object.getPrototypeOf(PanelContent)).apply(this, arguments));
  }

  _createClass(PanelContent, [{
    key: 'shouldComponentUpdate',
    value: function shouldComponentUpdate(nextProps) {
      return this.props.isActive || nextProps.isActive;
    }
  }, {
    key: 'render',
    value: function render() {
      var _classnames;

      this._isActived = this._isActived || this.props.isActive;
      if (!this._isActived) {
        return null;
      }
      var _props = this.props,
          prefixCls = _props.prefixCls,
          isActive = _props.isActive,
          children = _props.children,
          destroyInactivePanel = _props.destroyInactivePanel;

      var contentCls = __WEBPACK_IMPORTED_MODULE_2_classnames___default()((_classnames = {}, _defineProperty(_classnames, prefixCls + '-content', true), _defineProperty(_classnames, prefixCls + '-content-active', isActive), _defineProperty(_classnames, prefixCls + '-content-inactive', !isActive), _classnames));
      var child = !isActive && destroyInactivePanel ? null : __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
        'div',
        { className: prefixCls + '-content-box' },
        children
      );
      return __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
        'div',
        {
          className: contentCls,
          role: 'tabpanel'
        },
        child
      );
    }
  }]);

  return PanelContent;
}(__WEBPACK_IMPORTED_MODULE_0_react__["Component"]);

PanelContent.propTypes = {
  prefixCls: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.string,
  isActive: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.bool,
  children: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.any,
  destroyInactivePanel: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.bool
};

/* harmony default export */ __webpack_exports__["a"] = (PanelContent);

/***/ }),

/***/ 838:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "Panel", function() { return Panel; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__Collapse__ = __webpack_require__(835);


/* harmony default export */ __webpack_exports__["default"] = (__WEBPACK_IMPORTED_MODULE_0__Collapse__["a" /* default */]);
var Panel = __WEBPACK_IMPORTED_MODULE_0__Collapse__["a" /* default */].Panel;

/***/ }),

/***/ 839:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_css_animation__ = __webpack_require__(169);


function animate(node, show, transitionName, done) {
  var height = void 0;
  return __webpack_require__.i(__WEBPACK_IMPORTED_MODULE_0_css_animation__["default"])(node, transitionName, {
    start: function start() {
      if (!show) {
        node.style.height = node.offsetHeight + 'px';
      } else {
        height = node.offsetHeight;
        node.style.height = 0;
      }
    },
    active: function active() {
      node.style.height = (show ? height : 0) + 'px';
    },
    end: function end() {
      node.style.height = '';
      done();
    }
  });
}

function animation(prefixCls) {
  return {
    enter: function enter(node, done) {
      return animate(node, true, prefixCls + '-anim', done);
    },
    leave: function leave(node, done) {
      return animate(node, false, prefixCls + '-anim', done);
    }
  };
}

/* harmony default export */ __webpack_exports__["a"] = (animation);

/***/ })

},[599]);