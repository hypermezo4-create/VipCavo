(() => {
var exports = {};
exports.id = 602;
exports.ids = [602];
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

/***/ 3951:
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": () => (/* binding */ AdminTeams)
/* harmony export */ });
/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(8038);
/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(react__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var next_link__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(1621);
/* harmony import */ var next_link__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(next_link__WEBPACK_IMPORTED_MODULE_1__);
/* harmony import */ var _lib_supabaseClient__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(9118);
/* harmony import */ var _lib_owner__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(4219);
/* harmony import */ var react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(6786);
/* harmony import */ var react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4___default = /*#__PURE__*/__webpack_require__.n(react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__);
"use client";







function AdminTeams() {
  const {
    0: ok,
    1: setOk
  } = (0,react__WEBPACK_IMPORTED_MODULE_0__.useState)(null);
  const {
    0: items,
    1: setItems
  } = (0,react__WEBPACK_IMPORTED_MODULE_0__.useState)([]);
  const {
    0: editing,
    1: setEditing
  } = (0,react__WEBPACK_IMPORTED_MODULE_0__.useState)(null);
  const {
    0: name,
    1: setName
  } = (0,react__WEBPACK_IMPORTED_MODULE_0__.useState)("");
  const {
    0: country,
    1: setCountry
  } = (0,react__WEBPACK_IMPORTED_MODULE_0__.useState)("");
  const {
    0: position,
    1: setPosition
  } = (0,react__WEBPACK_IMPORTED_MODULE_0__.useState)("");
  const {
    0: telegram,
    1: setTelegram
  } = (0,react__WEBPACK_IMPORTED_MODULE_0__.useState)("");
  const {
    0: github,
    1: setGithub
  } = (0,react__WEBPACK_IMPORTED_MODULE_0__.useState)("");

  async function load() {
    const {
      data
    } = await _lib_supabaseClient__WEBPACK_IMPORTED_MODULE_2__/* .supabase.from */ .O.from("teams").select("id,name,country,position,telegram_url,github_url").order("created_at", {
      ascending: false
    });
    setItems(data ?? []);
  }

  (0,react__WEBPACK_IMPORTED_MODULE_0__.useEffect)(() => {
    (async () => {
      const {
        data
      } = await _lib_supabaseClient__WEBPACK_IMPORTED_MODULE_2__/* .supabase.auth.getUser */ .O.auth.getUser();

      if (!data.user) {
        setOk(false);
        return;
      }

      setOk(await (0,_lib_owner__WEBPACK_IMPORTED_MODULE_3__/* .isOwner */ .m)());
      await load();
    })();
  }, []);
  (0,react__WEBPACK_IMPORTED_MODULE_0__.useEffect)(() => {
    if (!editing) {
      setName("");
      setCountry("");
      setPosition("");
      setTelegram("");
      setGithub("");
      return;
    }

    setName(editing.name);
    setCountry(editing.country ?? "");
    setPosition(editing.position ?? "");
    setTelegram(editing.telegram_url ?? "");
    setGithub(editing.github_url ?? "");
  }, [editing]);
  if (ok === null) return /*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__.jsx("p", {
    children: "Loading..."
  });
  if (!ok) return /*#__PURE__*/(0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__.jsxs)("p", {
    children: ["Access denied. ", /*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__.jsx((next_link__WEBPACK_IMPORTED_MODULE_1___default()), {
      href: "/admin",
      children: "Back"
    })]
  });

  async function save() {
    const payload = {
      name,
      country: country || null,
      position: position || null,
      telegram_url: telegram || null,
      github_url: github || null
    };
    if (editing) await _lib_supabaseClient__WEBPACK_IMPORTED_MODULE_2__/* .supabase.from */ .O.from("teams").update(payload).eq("id", editing.id);else await _lib_supabaseClient__WEBPACK_IMPORTED_MODULE_2__/* .supabase.from */ .O.from("teams").insert(payload);
    setEditing(null);
    await load();
  }

  async function del(id) {
    if (!confirm("Delete team member?")) return;
    await _lib_supabaseClient__WEBPACK_IMPORTED_MODULE_2__/* .supabase.from */ .O.from("teams").delete().eq("id", id);
    await load();
  }

  return /*#__PURE__*/(0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__.jsxs)("div", {
    children: [/*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__.jsx("h1", {
      style: {
        marginTop: 0
      },
      children: "Admin / Teams"
    }), /*#__PURE__*/(0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__.jsxs)("div", {
      style: {
        display: "grid",
        gap: 10,
        padding: 12,
        border: "1px solid #eee",
        borderRadius: 12
      },
      children: [/*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__.jsx("strong", {
        children: editing ? "Edit Member" : "Add Member"
      }), /*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__.jsx("input", {
        value: name,
        onChange: e => setName(e.target.value),
        placeholder: "Name"
      }), /*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__.jsx("input", {
        value: country,
        onChange: e => setCountry(e.target.value),
        placeholder: "Country"
      }), /*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__.jsx("input", {
        value: position,
        onChange: e => setPosition(e.target.value),
        placeholder: "Position"
      }), /*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__.jsx("input", {
        value: telegram,
        onChange: e => setTelegram(e.target.value),
        placeholder: "Telegram Link"
      }), /*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__.jsx("input", {
        value: github,
        onChange: e => setGithub(e.target.value),
        placeholder: "Github Link"
      }), /*#__PURE__*/(0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__.jsxs)("div", {
        style: {
          display: "flex",
          gap: 10
        },
        children: [/*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__.jsx("button", {
          onClick: save,
          children: editing ? "Save" : "Add"
        }), editing ? /*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__.jsx("button", {
          onClick: () => setEditing(null),
          children: "Cancel"
        }) : null]
      })]
    }), /*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__.jsx("h3", {
      children: "List"
    }), /*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__.jsx("div", {
      style: {
        display: "grid",
        gap: 8
      },
      children: items.map(t => /*#__PURE__*/(0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__.jsxs)("div", {
        style: {
          padding: 12,
          border: "1px solid #eee",
          borderRadius: 12,
          display: "flex",
          justifyContent: "space-between",
          gap: 10
        },
        children: [/*#__PURE__*/(0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__.jsxs)("div", {
          children: [/*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__.jsx("strong", {
            children: t.name
          }), " ", /*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__.jsx("span", {
            style: {
              opacity: 0.7
            },
            children: t.position ?? ""
          }), /*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__.jsx("div", {
            style: {
              fontSize: 12,
              opacity: 0.75
            },
            children: t.country ?? ""
          })]
        }), /*#__PURE__*/(0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__.jsxs)("div", {
          style: {
            display: "flex",
            gap: 8
          },
          children: [/*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__.jsx("button", {
            onClick: () => setEditing(t),
            children: "Edit"
          }), /*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__.jsx("button", {
            onClick: () => del(t.id),
            children: "Delete"
          })]
        })]
      }, t.id))
    }), /*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__.jsx("p", {
      style: {
        marginTop: 16
      },
      children: /*#__PURE__*/react_jsx_runtime__WEBPACK_IMPORTED_MODULE_4__.jsx((next_link__WEBPACK_IMPORTED_MODULE_1___default()), {
        href: "/admin",
        children: "Back to Admin"
      })
    })]
  });
}

/***/ }),

/***/ 4219:
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "m": () => (/* binding */ isOwner)
/* harmony export */ });
/* harmony import */ var _supabaseClient__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(9118);

async function isOwner() {
  const {
    data: {
      user
    }
  } = await _supabaseClient__WEBPACK_IMPORTED_MODULE_0__/* .supabase.auth.getUser */ .O.auth.getUser();
  if (!user?.email) return false;
  const {
    data,
    error
  } = await _supabaseClient__WEBPACK_IMPORTED_MODULE_0__/* .supabase.from */ .O.from("owners_allowlist").select("email").eq("email", user.email).maybeSingle();
  if (error) return false;
  return !!data?.email;
}

/***/ }),

/***/ 6418:
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
        'teams',
        {
        children: ['', {}, {
          page: [() => Promise.resolve(/* import() eager */).then(__webpack_require__.bind(__webpack_require__, 3013)), "/data/data/com.termux/files/home/cavo/src/app/admin/teams/page.tsx"],
          
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
    const pages = ["/data/data/com.termux/files/home/cavo/src/app/admin/teams/page.tsx"];

    
    
    
    

    
    
    

    

    
    const __next_app_webpack_require__ = __webpack_require__
  

/***/ }),

/***/ 1888:
/***/ ((__unused_webpack_module, __unused_webpack_exports, __webpack_require__) => {

Promise.resolve(/* import() eager */).then(__webpack_require__.t.bind(__webpack_require__, 5197, 23));
Promise.resolve(/* import() eager */).then(__webpack_require__.t.bind(__webpack_require__, 8536, 23));
Promise.resolve(/* import() eager */).then(__webpack_require__.t.bind(__webpack_require__, 8261, 23));
Promise.resolve(/* import() eager */).then(__webpack_require__.t.bind(__webpack_require__, 2835, 23))

/***/ }),

/***/ 5636:
/***/ ((__unused_webpack_module, __unused_webpack_exports, __webpack_require__) => {

Promise.resolve(/* import() eager */).then(__webpack_require__.bind(__webpack_require__, 3951))

/***/ }),

/***/ 3013:
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": () => (/* binding */ Page)
/* harmony export */ });
/* harmony import */ var _view__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(3498);
/* harmony import */ var _view__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_view__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var react_jsx_runtime__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(715);


function Page() {
    return /*#__PURE__*/ react_jsx_runtime__WEBPACK_IMPORTED_MODULE_1__.jsx((_view__WEBPACK_IMPORTED_MODULE_0___default()), {});
}


/***/ }),

/***/ 3498:
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

/* __next_internal_client_entry_do_not_use__ default */ const { createProxy  } = __webpack_require__(7520);
module.exports = createProxy("/data/data/com.termux/files/home/cavo/src/app/admin/teams/view.tsx");


/***/ })

};
;

// load runtime
var __webpack_require__ = require("../../../webpack-runtime.js");
__webpack_require__.C(exports);
var __webpack_exec__ = (moduleId) => (__webpack_require__(__webpack_require__.s = moduleId))
var __webpack_exports__ = __webpack_require__.X(0, [435,22], () => (__webpack_exec__(6418)));
module.exports = __webpack_exports__;

})();