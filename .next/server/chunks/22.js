exports.id = 22;
exports.ids = [22];
exports.modules = {

/***/ 6904:
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": () => (/* binding */ Nav)
/* harmony export */ });
/* harmony import */ var next_link__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(1621);
/* harmony import */ var next_link__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(next_link__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(8038);
/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(react__WEBPACK_IMPORTED_MODULE_1__);
/* harmony import */ var _lib_supabaseClient__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(9118);
/* harmony import */ var react_jsx_runtime__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(6786);
/* harmony import */ var react_jsx_runtime__WEBPACK_IMPORTED_MODULE_3___default = /*#__PURE__*/__webpack_require__.n(react_jsx_runtime__WEBPACK_IMPORTED_MODULE_3__);
"use client";






function Nav() {
  const {
    0: email,
    1: setEmail
  } = (0,react__WEBPACK_IMPORTED_MODULE_1__.useState)(null);
  (0,react__WEBPACK_IMPORTED_MODULE_1__.useEffect)(() => {
    _lib_supabaseClient__WEBPACK_IMPORTED_MODULE_2__/* .supabase.auth.getUser */ .O.auth.getUser().then(({
      data
    }) => setEmail(data.user?.email ?? null));
    const {
      data: sub
    } = _lib_supabaseClient__WEBPACK_IMPORTED_MODULE_2__/* .supabase.auth.onAuthStateChange */ .O.auth.onAuthStateChange((_e, session) => {
      setEmail(session?.user?.email ?? null);
    });
    return () => sub.subscription.unsubscribe();
  }, []);
  return /*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_3__.jsx("header", {
    style: {
      borderBottom: "1px solid #eee",
      padding: "12px 16px"
    },
    children: /*#__PURE__*/(0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_3__.jsxs)("nav", {
      style: {
        display: "flex",
        justifyContent: "space-between",
        alignItems: "center"
      },
      children: [/*#__PURE__*/(0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_3__.jsxs)("div", {
        style: {
          display: "flex",
          gap: 12,
          alignItems: "center"
        },
        children: [/*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_3__.jsx((next_link__WEBPACK_IMPORTED_MODULE_0___default()), {
          href: "/",
          style: {
            fontWeight: 700
          },
          children: "Cavo"
        }), /*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_3__.jsx((next_link__WEBPACK_IMPORTED_MODULE_0___default()), {
          href: "/devices",
          children: "Devices"
        }), /*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_3__.jsx((next_link__WEBPACK_IMPORTED_MODULE_0___default()), {
          href: "/roms",
          children: "ROMs"
        }), /*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_3__.jsx((next_link__WEBPACK_IMPORTED_MODULE_0___default()), {
          href: "/admin",
          children: "Admin"
        })]
      }), /*#__PURE__*/(0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_3__.jsxs)("div", {
        style: {
          display: "flex",
          gap: 10,
          alignItems: "center"
        },
        children: [email ? /*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_3__.jsx("span", {
          style: {
            fontSize: 12,
            opacity: 0.75
          },
          children: email
        }) : null, email ? /*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_3__.jsx("button", {
          onClick: () => _lib_supabaseClient__WEBPACK_IMPORTED_MODULE_2__/* .supabase.auth.signOut */ .O.auth.signOut(),
          children: "Sign out"
        }) : /*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_3__.jsx((next_link__WEBPACK_IMPORTED_MODULE_0___default()), {
          href: "/admin/login",
          children: "Sign in"
        })]
      })]
    })
  });
}

/***/ }),

/***/ 9118:
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "O": () => (/* binding */ supabase)
/* harmony export */ });
/* harmony import */ var _supabase_supabase_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(9907);

const supabase = (0,_supabase_supabase_js__WEBPACK_IMPORTED_MODULE_0__.createClient)(process.env.NEXT_PUBLIC_SUPABASE_URL, process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY);

/***/ }),

/***/ 2637:
/***/ ((__unused_webpack_module, __unused_webpack_exports, __webpack_require__) => {

Promise.resolve(/* import() eager */).then(__webpack_require__.bind(__webpack_require__, 6904))

/***/ }),

/***/ 6408:
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": () => (/* binding */ RootLayout),
/* harmony export */   "metadata": () => (/* binding */ metadata)
/* harmony export */ });
/* harmony import */ var _components_Nav__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(9580);
/* harmony import */ var _components_Nav__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_components_Nav__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var react_jsx_runtime__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(715);



const metadata = {
    title: "Cavo",
    description: "Devices / ROMs / Team / Notifications + Download Tracking"
};
function RootLayout({ children  }) {
    return /*#__PURE__*/ react_jsx_runtime__WEBPACK_IMPORTED_MODULE_1__.jsx("html", {
        lang: "en",
        children: /*#__PURE__*/ (0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_1__.jsxs)("body", {
            style: {
                margin: 0,
                fontFamily: "system-ui, -apple-system, Segoe UI, Roboto, Arial"
            },
            children: [
                /*#__PURE__*/ react_jsx_runtime__WEBPACK_IMPORTED_MODULE_1__.jsx((_components_Nav__WEBPACK_IMPORTED_MODULE_0___default()), {}),
                /*#__PURE__*/ react_jsx_runtime__WEBPACK_IMPORTED_MODULE_1__.jsx("main", {
                    style: {
                        maxWidth: 980,
                        margin: "0 auto",
                        padding: 16
                    },
                    children: children
                })
            ]
        })
    });
}


/***/ }),

/***/ 9580:
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

/* __next_internal_client_entry_do_not_use__ default */ const { createProxy  } = __webpack_require__(7520);
module.exports = createProxy("/data/data/com.termux/files/home/cavo/src/components/Nav.tsx");


/***/ })

};
;