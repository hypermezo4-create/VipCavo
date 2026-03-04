(() => {
var exports = {};
exports.id = 920;
exports.ids = [920];
exports.modules = {

/***/ 8038:
/***/ ((module) => {

"use strict";
module.exports = require("next/dist/compiled/react");

/***/ }),

/***/ 8704:
/***/ ((module) => {

"use strict";
module.exports = require("next/dist/compiled/react-dom/server-rendering-stub");

/***/ }),

/***/ 7897:
/***/ ((module) => {

"use strict";
module.exports = require("next/dist/compiled/react-server-dom-webpack/client");

/***/ }),

/***/ 6786:
/***/ ((module) => {

"use strict";
module.exports = require("next/dist/compiled/react/jsx-runtime");

/***/ }),

/***/ 3280:
/***/ ((module) => {

"use strict";
module.exports = require("next/dist/shared/lib/app-router-context.js");

/***/ }),

/***/ 9274:
/***/ ((module) => {

"use strict";
module.exports = require("next/dist/shared/lib/hooks-client-context.js");

/***/ }),

/***/ 4964:
/***/ ((module) => {

"use strict";
module.exports = require("next/dist/shared/lib/router-context.js");

/***/ }),

/***/ 1751:
/***/ ((module) => {

"use strict";
module.exports = require("next/dist/shared/lib/router/utils/add-path-prefix.js");

/***/ }),

/***/ 3938:
/***/ ((module) => {

"use strict";
module.exports = require("next/dist/shared/lib/router/utils/format-url.js");

/***/ }),

/***/ 1668:
/***/ ((module) => {

"use strict";
module.exports = require("next/dist/shared/lib/router/utils/handle-smooth-scroll.js");

/***/ }),

/***/ 1897:
/***/ ((module) => {

"use strict";
module.exports = require("next/dist/shared/lib/router/utils/is-bot.js");

/***/ }),

/***/ 1109:
/***/ ((module) => {

"use strict";
module.exports = require("next/dist/shared/lib/router/utils/is-local-url.js");

/***/ }),

/***/ 8854:
/***/ ((module) => {

"use strict";
module.exports = require("next/dist/shared/lib/router/utils/parse-path.js");

/***/ }),

/***/ 3297:
/***/ ((module) => {

"use strict";
module.exports = require("next/dist/shared/lib/router/utils/remove-trailing-slash.js");

/***/ }),

/***/ 7782:
/***/ ((module) => {

"use strict";
module.exports = require("next/dist/shared/lib/router/utils/resolve-href.js");

/***/ }),

/***/ 3349:
/***/ ((module) => {

"use strict";
module.exports = require("next/dist/shared/lib/server-inserted-html.js");

/***/ }),

/***/ 9232:
/***/ ((module) => {

"use strict";
module.exports = require("next/dist/shared/lib/utils.js");

/***/ }),

/***/ 2515:
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": () => (/* binding */ LoginPage)
/* harmony export */ });
/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(8038);
/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(react__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var _lib_supabaseClient__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(9118);
/* harmony import */ var react_jsx_runtime__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(6786);
/* harmony import */ var react_jsx_runtime__WEBPACK_IMPORTED_MODULE_2___default = /*#__PURE__*/__webpack_require__.n(react_jsx_runtime__WEBPACK_IMPORTED_MODULE_2__);
"use client";





function LoginPage() {
  const {
    0: email,
    1: setEmail
  } = (0,react__WEBPACK_IMPORTED_MODULE_0__.useState)("");
  const {
    0: password,
    1: setPassword
  } = (0,react__WEBPACK_IMPORTED_MODULE_0__.useState)("");
  const {
    0: msg,
    1: setMsg
  } = (0,react__WEBPACK_IMPORTED_MODULE_0__.useState)(null);

  async function signIn(e) {
    e.preventDefault();
    setMsg(null);
    const {
      error
    } = await _lib_supabaseClient__WEBPACK_IMPORTED_MODULE_1__/* .supabase.auth.signInWithPassword */ .O.auth.signInWithPassword({
      email,
      password
    });
    setMsg(error ? error.message : "Signed in. Open /admin");
  }

  async function signUp(e) {
    e.preventDefault();
    setMsg(null);
    const {
      error
    } = await _lib_supabaseClient__WEBPACK_IMPORTED_MODULE_1__/* .supabase.auth.signUp */ .O.auth.signUp({
      email,
      password
    });
    setMsg(error ? error.message : "Signed up. If allowlisted, you can access /admin");
  }

  return /*#__PURE__*/(0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_2__.jsxs)("div", {
    style: {
      maxWidth: 420
    },
    children: [/*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_2__.jsx("h1", {
      style: {
        marginTop: 0
      },
      children: "Admin Login"
    }), /*#__PURE__*/(0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_2__.jsxs)("form", {
      onSubmit: signIn,
      style: {
        display: "grid",
        gap: 10
      },
      children: [/*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_2__.jsx("input", {
        value: email,
        onChange: e => setEmail(e.target.value),
        placeholder: "Email"
      }), /*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_2__.jsx("input", {
        value: password,
        onChange: e => setPassword(e.target.value),
        placeholder: "Password",
        type: "password"
      }), /*#__PURE__*/(0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_2__.jsxs)("div", {
        style: {
          display: "flex",
          gap: 10
        },
        children: [/*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_2__.jsx("button", {
          type: "submit",
          children: "Sign in"
        }), /*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_2__.jsx("button", {
          type: "button",
          onClick: signUp,
          children: "Sign up"
        })]
      }), msg ? /*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_2__.jsx("p", {
        style: {
          margin: 0,
          opacity: 0.8
        },
        children: msg
      }) : null]
    }), /*#__PURE__*/(0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_2__.jsxs)("p", {
      style: {
        fontSize: 12,
        opacity: 0.7,
        marginTop: 12
      },
      children: ["Add the 2 owner emails into ", /*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_2__.jsx("code", {
        children: "owners_allowlist"
      }), " table in Supabase."]
    })]
  });
}

/***/ }),

/***/ 9203:
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "AppRouter": () => (/* reexport default from dynamic */ next_dist_client_components_app_router__WEBPACK_IMPORTED_MODULE_0___default.a),
/* harmony export */   "GlobalError": () => (/* reexport default from dynamic */ next_dist_client_components_error_boundary__WEBPACK_IMPORTED_MODULE_3___default.a),
/* harmony export */   "LayoutRouter": () => (/* reexport default from dynamic */ next_dist_client_components_layout_router__WEBPACK_IMPORTED_MODULE_1___default.a),
/* harmony export */   "RenderFromTemplateContext": () => (/* reexport default from dynamic */ next_dist_client_components_render_from_template_context__WEBPACK_IMPORTED_MODULE_2___default.a),
/* harmony export */   "__next_app_webpack_require__": () => (/* binding */ __next_app_webpack_require__),
/* harmony export */   "pages": () => (/* binding */ pages),
/* harmony export */   "renderToReadableStream": () => (/* reexport safe */ next_dist_compiled_react_server_dom_webpack_server_edge__WEBPACK_IMPORTED_MODULE_7__.renderToReadableStream),
/* harmony export */   "requestAsyncStorage": () => (/* reexport safe */ next_dist_client_components_request_async_storage__WEBPACK_IMPORTED_MODULE_5__.requestAsyncStorage),
/* harmony export */   "serverHooks": () => (/* reexport module object */ next_dist_client_components_hooks_server_context__WEBPACK_IMPORTED_MODULE_6__),
/* harmony export */   "staticGenerationAsyncStorage": () => (/* reexport safe */ next_dist_client_components_static_generation_async_storage__WEBPACK_IMPORTED_MODULE_4__.staticGenerationAsyncStorage),
/* harmony export */   "tree": () => (/* binding */ tree)
/* harmony export */ });
/* harmony import */ var next_dist_client_components_app_router__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(6789);
/* harmony import */ var next_dist_client_components_app_router__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(next_dist_client_components_app_router__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var next_dist_client_components_layout_router__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(277);
/* harmony import */ var next_dist_client_components_layout_router__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(next_dist_client_components_layout_router__WEBPACK_IMPORTED_MODULE_1__);
/* harmony import */ var next_dist_client_components_render_from_template_context__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(639);
/* harmony import */ var next_dist_client_components_render_from_template_context__WEBPACK_IMPORTED_MODULE_2___default = /*#__PURE__*/__webpack_require__.n(next_dist_client_components_render_from_template_context__WEBPACK_IMPORTED_MODULE_2__);
/* harmony import */ var next_dist_client_components_error_boundary__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(5998);
/* harmony import */ var next_dist_client_components_error_boundary__WEBPACK_IMPORTED_MODULE_3___default = /*#__PURE__*/__webpack_require__.n(next_dist_client_components_error_boundary__WEBPACK_IMPORTED_MODULE_3__);
/* harmony import */ var next_dist_client_components_static_generation_async_storage__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(6064);
/* harmony import */ var next_dist_client_components_static_generation_async_storage__WEBPACK_IMPORTED_MODULE_4___default = /*#__PURE__*/__webpack_require__.n(next_dist_client_components_static_generation_async_storage__WEBPACK_IMPORTED_MODULE_4__);
/* harmony import */ var next_dist_client_components_request_async_storage__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(6425);
/* harmony import */ var next_dist_client_components_request_async_storage__WEBPACK_IMPORTED_MODULE_5___default = /*#__PURE__*/__webpack_require__.n(next_dist_client_components_request_async_storage__WEBPACK_IMPORTED_MODULE_5__);
/* harmony import */ var next_dist_client_components_hooks_server_context__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(1488);
/* harmony import */ var next_dist_client_components_hooks_server_context__WEBPACK_IMPORTED_MODULE_6___default = /*#__PURE__*/__webpack_require__.n(next_dist_client_components_hooks_server_context__WEBPACK_IMPORTED_MODULE_6__);
/* harmony import */ var next_dist_compiled_react_server_dom_webpack_server_edge__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(4491);

    const tree = {
        children: [
        '',
        {
        children: [
        'admin',
        {
        children: [
        'login',
        {
        children: ['', {}, {
          page: [() => Promise.resolve(/* import() eager */).then(__webpack_require__.t.bind(__webpack_require__, 3734, 23)), "/data/data/com.termux/files/home/cavo/src/app/admin/login/page.tsx"],
          
        }]
      },
        {
          
          
        }
      ]
      },
        {
          
          
        }
      ]
      },
        {
          'layout': [() => Promise.resolve(/* import() eager */).then(__webpack_require__.bind(__webpack_require__, 6408)), "/data/data/com.termux/files/home/cavo/src/app/layout.tsx"],
          
        }
      ]
      }.children;
    const pages = ["/data/data/com.termux/files/home/cavo/src/app/admin/login/page.tsx"];

    
    
    
    

    
    
    

    

    
    const __next_app_webpack_require__ = __webpack_require__
  

/***/ }),

/***/ 1888:
/***/ ((__unused_webpack_module, __unused_webpack_exports, __webpack_require__) => {

Promise.resolve(/* import() eager */).then(__webpack_require__.t.bind(__webpack_require__, 5197, 23));
Promise.resolve(/* import() eager */).then(__webpack_require__.t.bind(__webpack_require__, 8536, 23));
Promise.resolve(/* import() eager */).then(__webpack_require__.t.bind(__webpack_require__, 8261, 23));
Promise.resolve(/* import() eager */).then(__webpack_require__.t.bind(__webpack_require__, 2835, 23))

/***/ }),

/***/ 1516:
/***/ ((__unused_webpack_module, __unused_webpack_exports, __webpack_require__) => {

Promise.resolve(/* import() eager */).then(__webpack_require__.bind(__webpack_require__, 2515))

/***/ }),

/***/ 3734:
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

/* __next_internal_client_entry_do_not_use__ default */ const { createProxy  } = __webpack_require__(7520);
module.exports = createProxy("/data/data/com.termux/files/home/cavo/src/app/admin/login/page.tsx");


/***/ })

};
;

// load runtime
var __webpack_require__ = require("../../../webpack-runtime.js");
__webpack_require__.C(exports);
var __webpack_exec__ = (moduleId) => (__webpack_require__(__webpack_require__.s = moduleId))
var __webpack_exports__ = __webpack_require__.X(0, [435,22], () => (__webpack_exec__(9203)));
module.exports = __webpack_exports__;

})();