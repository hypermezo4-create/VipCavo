exports.id = 435;
exports.ids = [435];
exports.modules = {

/***/ 5442:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({ value: true }));
const tslib_1 = __webpack_require__(1915);
const GoTrueAdminApi_1 = tslib_1.__importDefault(__webpack_require__(5529));
const AuthAdminApi = GoTrueAdminApi_1.default;
exports["default"] = AuthAdminApi;
//# sourceMappingURL=AuthAdminApi.js.map

/***/ }),

/***/ 5264:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({ value: true }));
const tslib_1 = __webpack_require__(1915);
const GoTrueClient_1 = tslib_1.__importDefault(__webpack_require__(7405));
const AuthClient = GoTrueClient_1.default;
exports["default"] = AuthClient;
//# sourceMappingURL=AuthClient.js.map

/***/ }),

/***/ 5529:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({ value: true }));
const tslib_1 = __webpack_require__(1915);
const fetch_1 = __webpack_require__(4928);
const helpers_1 = __webpack_require__(1742);
const types_1 = __webpack_require__(9012);
const errors_1 = __webpack_require__(2268);
class GoTrueAdminApi {
    /**
     * Creates an admin API client that can be used to manage users and OAuth clients.
     *
     * @example
     * ```ts
     * import { GoTrueAdminApi } from '@supabase/auth-js'
     *
     * const admin = new GoTrueAdminApi({
     *   url: 'https://xyzcompany.supabase.co/auth/v1',
     *   headers: { Authorization: `Bearer ${process.env.SUPABASE_SERVICE_ROLE_KEY}` },
     * })
     * ```
     */
    constructor({ url = '', headers = {}, fetch, }) {
        this.url = url;
        this.headers = headers;
        this.fetch = (0, helpers_1.resolveFetch)(fetch);
        this.mfa = {
            listFactors: this._listFactors.bind(this),
            deleteFactor: this._deleteFactor.bind(this),
        };
        this.oauth = {
            listClients: this._listOAuthClients.bind(this),
            createClient: this._createOAuthClient.bind(this),
            getClient: this._getOAuthClient.bind(this),
            updateClient: this._updateOAuthClient.bind(this),
            deleteClient: this._deleteOAuthClient.bind(this),
            regenerateClientSecret: this._regenerateOAuthClientSecret.bind(this),
        };
    }
    /**
     * Removes a logged-in session.
     * @param jwt A valid, logged-in JWT.
     * @param scope The logout sope.
     */
    async signOut(jwt, scope = types_1.SIGN_OUT_SCOPES[0]) {
        if (types_1.SIGN_OUT_SCOPES.indexOf(scope) < 0) {
            throw new Error(`@supabase/auth-js: Parameter scope must be one of ${types_1.SIGN_OUT_SCOPES.join(', ')}`);
        }
        try {
            await (0, fetch_1._request)(this.fetch, 'POST', `${this.url}/logout?scope=${scope}`, {
                headers: this.headers,
                jwt,
                noResolveJson: true,
            });
            return { data: null, error: null };
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return { data: null, error };
            }
            throw error;
        }
    }
    /**
     * Sends an invite link to an email address.
     * @param email The email address of the user.
     * @param options Additional options to be included when inviting.
     */
    async inviteUserByEmail(email, options = {}) {
        try {
            return await (0, fetch_1._request)(this.fetch, 'POST', `${this.url}/invite`, {
                body: { email, data: options.data },
                headers: this.headers,
                redirectTo: options.redirectTo,
                xform: fetch_1._userResponse,
            });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return { data: { user: null }, error };
            }
            throw error;
        }
    }
    /**
     * Generates email links and OTPs to be sent via a custom email provider.
     * @param email The user's email.
     * @param options.password User password. For signup only.
     * @param options.data Optional user metadata. For signup only.
     * @param options.redirectTo The redirect url which should be appended to the generated link
     */
    async generateLink(params) {
        try {
            const { options } = params, rest = tslib_1.__rest(params, ["options"]);
            const body = Object.assign(Object.assign({}, rest), options);
            if ('newEmail' in rest) {
                // replace newEmail with new_email in request body
                body.new_email = rest === null || rest === void 0 ? void 0 : rest.newEmail;
                delete body['newEmail'];
            }
            return await (0, fetch_1._request)(this.fetch, 'POST', `${this.url}/admin/generate_link`, {
                body: body,
                headers: this.headers,
                xform: fetch_1._generateLinkResponse,
                redirectTo: options === null || options === void 0 ? void 0 : options.redirectTo,
            });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return {
                    data: {
                        properties: null,
                        user: null,
                    },
                    error,
                };
            }
            throw error;
        }
    }
    // User Admin API
    /**
     * Creates a new user.
     * This function should only be called on a server. Never expose your `service_role` key in the browser.
     */
    async createUser(attributes) {
        try {
            return await (0, fetch_1._request)(this.fetch, 'POST', `${this.url}/admin/users`, {
                body: attributes,
                headers: this.headers,
                xform: fetch_1._userResponse,
            });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return { data: { user: null }, error };
            }
            throw error;
        }
    }
    /**
     * Get a list of users.
     *
     * This function should only be called on a server. Never expose your `service_role` key in the browser.
     * @param params An object which supports `page` and `perPage` as numbers, to alter the paginated results.
     */
    async listUsers(params) {
        var _a, _b, _c, _d, _e, _f, _g;
        try {
            const pagination = { nextPage: null, lastPage: 0, total: 0 };
            const response = await (0, fetch_1._request)(this.fetch, 'GET', `${this.url}/admin/users`, {
                headers: this.headers,
                noResolveJson: true,
                query: {
                    page: (_b = (_a = params === null || params === void 0 ? void 0 : params.page) === null || _a === void 0 ? void 0 : _a.toString()) !== null && _b !== void 0 ? _b : '',
                    per_page: (_d = (_c = params === null || params === void 0 ? void 0 : params.perPage) === null || _c === void 0 ? void 0 : _c.toString()) !== null && _d !== void 0 ? _d : '',
                },
                xform: fetch_1._noResolveJsonResponse,
            });
            if (response.error)
                throw response.error;
            const users = await response.json();
            const total = (_e = response.headers.get('x-total-count')) !== null && _e !== void 0 ? _e : 0;
            const links = (_g = (_f = response.headers.get('link')) === null || _f === void 0 ? void 0 : _f.split(',')) !== null && _g !== void 0 ? _g : [];
            if (links.length > 0) {
                links.forEach((link) => {
                    const page = parseInt(link.split(';')[0].split('=')[1].substring(0, 1));
                    const rel = JSON.parse(link.split(';')[1].split('=')[1]);
                    pagination[`${rel}Page`] = page;
                });
                pagination.total = parseInt(total);
            }
            return { data: Object.assign(Object.assign({}, users), pagination), error: null };
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return { data: { users: [] }, error };
            }
            throw error;
        }
    }
    /**
     * Get user by id.
     *
     * @param uid The user's unique identifier
     *
     * This function should only be called on a server. Never expose your `service_role` key in the browser.
     */
    async getUserById(uid) {
        (0, helpers_1.validateUUID)(uid);
        try {
            return await (0, fetch_1._request)(this.fetch, 'GET', `${this.url}/admin/users/${uid}`, {
                headers: this.headers,
                xform: fetch_1._userResponse,
            });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return { data: { user: null }, error };
            }
            throw error;
        }
    }
    /**
     * Updates the user data. Changes are applied directly without confirmation flows.
     *
     * @param uid The user's unique identifier
     * @param attributes The data you want to update.
     *
     * This function should only be called on a server. Never expose your `service_role` key in the browser.
     *
     * @remarks
     * **Important:** This is a server-side operation and does **not** trigger client-side
     * `onAuthStateChange` listeners. The admin API has no connection to client state.
     *
     * To sync changes to the client after calling this method:
     * 1. On the client, call `supabase.auth.refreshSession()` to fetch the updated user data
     * 2. This will trigger the `TOKEN_REFRESHED` event and notify all listeners
     *
     * @example
     * ```typescript
     * // Server-side (Edge Function)
     * const { data, error } = await supabase.auth.admin.updateUserById(
     *   userId,
     *   { user_metadata: { preferences: { theme: 'dark' } } }
     * )
     *
     * // Client-side (to sync the changes)
     * const { data, error } = await supabase.auth.refreshSession()
     * // onAuthStateChange listeners will now be notified with updated user
     * ```
     *
     * @see {@link GoTrueClient.refreshSession} for syncing admin changes to the client
     * @see {@link GoTrueClient.updateUser} for client-side user updates (triggers listeners automatically)
     */
    async updateUserById(uid, attributes) {
        (0, helpers_1.validateUUID)(uid);
        try {
            return await (0, fetch_1._request)(this.fetch, 'PUT', `${this.url}/admin/users/${uid}`, {
                body: attributes,
                headers: this.headers,
                xform: fetch_1._userResponse,
            });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return { data: { user: null }, error };
            }
            throw error;
        }
    }
    /**
     * Delete a user. Requires a `service_role` key.
     *
     * @param id The user id you want to remove.
     * @param shouldSoftDelete If true, then the user will be soft-deleted from the auth schema. Soft deletion allows user identification from the hashed user ID but is not reversible.
     * Defaults to false for backward compatibility.
     *
     * This function should only be called on a server. Never expose your `service_role` key in the browser.
     */
    async deleteUser(id, shouldSoftDelete = false) {
        (0, helpers_1.validateUUID)(id);
        try {
            return await (0, fetch_1._request)(this.fetch, 'DELETE', `${this.url}/admin/users/${id}`, {
                headers: this.headers,
                body: {
                    should_soft_delete: shouldSoftDelete,
                },
                xform: fetch_1._userResponse,
            });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return { data: { user: null }, error };
            }
            throw error;
        }
    }
    async _listFactors(params) {
        (0, helpers_1.validateUUID)(params.userId);
        try {
            const { data, error } = await (0, fetch_1._request)(this.fetch, 'GET', `${this.url}/admin/users/${params.userId}/factors`, {
                headers: this.headers,
                xform: (factors) => {
                    return { data: { factors }, error: null };
                },
            });
            return { data, error };
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return { data: null, error };
            }
            throw error;
        }
    }
    async _deleteFactor(params) {
        (0, helpers_1.validateUUID)(params.userId);
        (0, helpers_1.validateUUID)(params.id);
        try {
            const data = await (0, fetch_1._request)(this.fetch, 'DELETE', `${this.url}/admin/users/${params.userId}/factors/${params.id}`, {
                headers: this.headers,
            });
            return { data, error: null };
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return { data: null, error };
            }
            throw error;
        }
    }
    /**
     * Lists all OAuth clients with optional pagination.
     * Only relevant when the OAuth 2.1 server is enabled in Supabase Auth.
     *
     * This function should only be called on a server. Never expose your `service_role` key in the browser.
     */
    async _listOAuthClients(params) {
        var _a, _b, _c, _d, _e, _f, _g;
        try {
            const pagination = { nextPage: null, lastPage: 0, total: 0 };
            const response = await (0, fetch_1._request)(this.fetch, 'GET', `${this.url}/admin/oauth/clients`, {
                headers: this.headers,
                noResolveJson: true,
                query: {
                    page: (_b = (_a = params === null || params === void 0 ? void 0 : params.page) === null || _a === void 0 ? void 0 : _a.toString()) !== null && _b !== void 0 ? _b : '',
                    per_page: (_d = (_c = params === null || params === void 0 ? void 0 : params.perPage) === null || _c === void 0 ? void 0 : _c.toString()) !== null && _d !== void 0 ? _d : '',
                },
                xform: fetch_1._noResolveJsonResponse,
            });
            if (response.error)
                throw response.error;
            const clients = await response.json();
            const total = (_e = response.headers.get('x-total-count')) !== null && _e !== void 0 ? _e : 0;
            const links = (_g = (_f = response.headers.get('link')) === null || _f === void 0 ? void 0 : _f.split(',')) !== null && _g !== void 0 ? _g : [];
            if (links.length > 0) {
                links.forEach((link) => {
                    const page = parseInt(link.split(';')[0].split('=')[1].substring(0, 1));
                    const rel = JSON.parse(link.split(';')[1].split('=')[1]);
                    pagination[`${rel}Page`] = page;
                });
                pagination.total = parseInt(total);
            }
            return { data: Object.assign(Object.assign({}, clients), pagination), error: null };
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return { data: { clients: [] }, error };
            }
            throw error;
        }
    }
    /**
     * Creates a new OAuth client.
     * Only relevant when the OAuth 2.1 server is enabled in Supabase Auth.
     *
     * This function should only be called on a server. Never expose your `service_role` key in the browser.
     */
    async _createOAuthClient(params) {
        try {
            return await (0, fetch_1._request)(this.fetch, 'POST', `${this.url}/admin/oauth/clients`, {
                body: params,
                headers: this.headers,
                xform: (client) => {
                    return { data: client, error: null };
                },
            });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return { data: null, error };
            }
            throw error;
        }
    }
    /**
     * Gets details of a specific OAuth client.
     * Only relevant when the OAuth 2.1 server is enabled in Supabase Auth.
     *
     * This function should only be called on a server. Never expose your `service_role` key in the browser.
     */
    async _getOAuthClient(clientId) {
        try {
            return await (0, fetch_1._request)(this.fetch, 'GET', `${this.url}/admin/oauth/clients/${clientId}`, {
                headers: this.headers,
                xform: (client) => {
                    return { data: client, error: null };
                },
            });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return { data: null, error };
            }
            throw error;
        }
    }
    /**
     * Updates an existing OAuth client.
     * Only relevant when the OAuth 2.1 server is enabled in Supabase Auth.
     *
     * This function should only be called on a server. Never expose your `service_role` key in the browser.
     */
    async _updateOAuthClient(clientId, params) {
        try {
            return await (0, fetch_1._request)(this.fetch, 'PUT', `${this.url}/admin/oauth/clients/${clientId}`, {
                body: params,
                headers: this.headers,
                xform: (client) => {
                    return { data: client, error: null };
                },
            });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return { data: null, error };
            }
            throw error;
        }
    }
    /**
     * Deletes an OAuth client.
     * Only relevant when the OAuth 2.1 server is enabled in Supabase Auth.
     *
     * This function should only be called on a server. Never expose your `service_role` key in the browser.
     */
    async _deleteOAuthClient(clientId) {
        try {
            await (0, fetch_1._request)(this.fetch, 'DELETE', `${this.url}/admin/oauth/clients/${clientId}`, {
                headers: this.headers,
                noResolveJson: true,
            });
            return { data: null, error: null };
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return { data: null, error };
            }
            throw error;
        }
    }
    /**
     * Regenerates the secret for an OAuth client.
     * Only relevant when the OAuth 2.1 server is enabled in Supabase Auth.
     *
     * This function should only be called on a server. Never expose your `service_role` key in the browser.
     */
    async _regenerateOAuthClientSecret(clientId) {
        try {
            return await (0, fetch_1._request)(this.fetch, 'POST', `${this.url}/admin/oauth/clients/${clientId}/regenerate_secret`, {
                headers: this.headers,
                xform: (client) => {
                    return { data: client, error: null };
                },
            });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return { data: null, error };
            }
            throw error;
        }
    }
}
exports["default"] = GoTrueAdminApi;
//# sourceMappingURL=GoTrueAdminApi.js.map

/***/ }),

/***/ 7405:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({ value: true }));
const tslib_1 = __webpack_require__(1915);
const GoTrueAdminApi_1 = tslib_1.__importDefault(__webpack_require__(5529));
const constants_1 = __webpack_require__(6883);
const errors_1 = __webpack_require__(2268);
const fetch_1 = __webpack_require__(4928);
const helpers_1 = __webpack_require__(1742);
const local_storage_1 = __webpack_require__(1030);
const locks_1 = __webpack_require__(5029);
const polyfills_1 = __webpack_require__(3965);
const version_1 = __webpack_require__(5316);
const base64url_1 = __webpack_require__(7162);
const ethereum_1 = __webpack_require__(4368);
const webauthn_1 = __webpack_require__(6025);
(0, polyfills_1.polyfillGlobalThis)(); // Make "globalThis" available
const DEFAULT_OPTIONS = {
    url: constants_1.GOTRUE_URL,
    storageKey: constants_1.STORAGE_KEY,
    autoRefreshToken: true,
    persistSession: true,
    detectSessionInUrl: true,
    headers: constants_1.DEFAULT_HEADERS,
    flowType: 'implicit',
    debug: false,
    hasCustomAuthorizationHeader: false,
    throwOnError: false,
    lockAcquireTimeout: 5000, // 5 seconds
    skipAutoInitialize: false,
};
async function lockNoOp(name, acquireTimeout, fn) {
    return await fn();
}
/**
 * Caches JWKS values for all clients created in the same environment. This is
 * especially useful for shared-memory execution environments such as Vercel's
 * Fluid Compute, AWS Lambda or Supabase's Edge Functions. Regardless of how
 * many clients are created, if they share the same storage key they will use
 * the same JWKS cache, significantly speeding up getClaims() with asymmetric
 * JWTs.
 */
const GLOBAL_JWKS = {};
class GoTrueClient {
    /**
     * The JWKS used for verifying asymmetric JWTs
     */
    get jwks() {
        var _a, _b;
        return (_b = (_a = GLOBAL_JWKS[this.storageKey]) === null || _a === void 0 ? void 0 : _a.jwks) !== null && _b !== void 0 ? _b : { keys: [] };
    }
    set jwks(value) {
        GLOBAL_JWKS[this.storageKey] = Object.assign(Object.assign({}, GLOBAL_JWKS[this.storageKey]), { jwks: value });
    }
    get jwks_cached_at() {
        var _a, _b;
        return (_b = (_a = GLOBAL_JWKS[this.storageKey]) === null || _a === void 0 ? void 0 : _a.cachedAt) !== null && _b !== void 0 ? _b : Number.MIN_SAFE_INTEGER;
    }
    set jwks_cached_at(value) {
        GLOBAL_JWKS[this.storageKey] = Object.assign(Object.assign({}, GLOBAL_JWKS[this.storageKey]), { cachedAt: value });
    }
    /**
     * Create a new client for use in the browser.
     *
     * @example
     * ```ts
     * import { GoTrueClient } from '@supabase/auth-js'
     *
     * const auth = new GoTrueClient({
     *   url: 'https://xyzcompany.supabase.co/auth/v1',
     *   headers: { apikey: 'public-anon-key' },
     *   storageKey: 'supabase-auth',
     * })
     * ```
     */
    constructor(options) {
        var _a, _b, _c;
        /**
         * @experimental
         */
        this.userStorage = null;
        this.memoryStorage = null;
        this.stateChangeEmitters = new Map();
        this.autoRefreshTicker = null;
        this.autoRefreshTickTimeout = null;
        this.visibilityChangedCallback = null;
        this.refreshingDeferred = null;
        /**
         * Keeps track of the async client initialization.
         * When null or not yet resolved the auth state is `unknown`
         * Once resolved the auth state is known and it's safe to call any further client methods.
         * Keep extra care to never reject or throw uncaught errors
         */
        this.initializePromise = null;
        this.detectSessionInUrl = true;
        this.hasCustomAuthorizationHeader = false;
        this.suppressGetSessionWarning = false;
        this.lockAcquired = false;
        this.pendingInLock = [];
        /**
         * Used to broadcast state change events to other tabs listening.
         */
        this.broadcastChannel = null;
        this.logger = console.log;
        const settings = Object.assign(Object.assign({}, DEFAULT_OPTIONS), options);
        this.storageKey = settings.storageKey;
        this.instanceID = (_a = GoTrueClient.nextInstanceID[this.storageKey]) !== null && _a !== void 0 ? _a : 0;
        GoTrueClient.nextInstanceID[this.storageKey] = this.instanceID + 1;
        this.logDebugMessages = !!settings.debug;
        if (typeof settings.debug === 'function') {
            this.logger = settings.debug;
        }
        if (this.instanceID > 0 && (0, helpers_1.isBrowser)()) {
            const message = `${this._logPrefix()} Multiple GoTrueClient instances detected in the same browser context. It is not an error, but this should be avoided as it may produce undefined behavior when used concurrently under the same storage key.`;
            console.warn(message);
            if (this.logDebugMessages) {
                console.trace(message);
            }
        }
        this.persistSession = settings.persistSession;
        this.autoRefreshToken = settings.autoRefreshToken;
        this.admin = new GoTrueAdminApi_1.default({
            url: settings.url,
            headers: settings.headers,
            fetch: settings.fetch,
        });
        this.url = settings.url;
        this.headers = settings.headers;
        this.fetch = (0, helpers_1.resolveFetch)(settings.fetch);
        this.lock = settings.lock || lockNoOp;
        this.detectSessionInUrl = settings.detectSessionInUrl;
        this.flowType = settings.flowType;
        this.hasCustomAuthorizationHeader = settings.hasCustomAuthorizationHeader;
        this.throwOnError = settings.throwOnError;
        this.lockAcquireTimeout = settings.lockAcquireTimeout;
        if (settings.lock) {
            this.lock = settings.lock;
        }
        else if (this.persistSession && (0, helpers_1.isBrowser)() && ((_b = globalThis === null || globalThis === void 0 ? void 0 : globalThis.navigator) === null || _b === void 0 ? void 0 : _b.locks)) {
            this.lock = locks_1.navigatorLock;
        }
        else {
            this.lock = lockNoOp;
        }
        if (!this.jwks) {
            this.jwks = { keys: [] };
            this.jwks_cached_at = Number.MIN_SAFE_INTEGER;
        }
        this.mfa = {
            verify: this._verify.bind(this),
            enroll: this._enroll.bind(this),
            unenroll: this._unenroll.bind(this),
            challenge: this._challenge.bind(this),
            listFactors: this._listFactors.bind(this),
            challengeAndVerify: this._challengeAndVerify.bind(this),
            getAuthenticatorAssuranceLevel: this._getAuthenticatorAssuranceLevel.bind(this),
            webauthn: new webauthn_1.WebAuthnApi(this),
        };
        this.oauth = {
            getAuthorizationDetails: this._getAuthorizationDetails.bind(this),
            approveAuthorization: this._approveAuthorization.bind(this),
            denyAuthorization: this._denyAuthorization.bind(this),
            listGrants: this._listOAuthGrants.bind(this),
            revokeGrant: this._revokeOAuthGrant.bind(this),
        };
        if (this.persistSession) {
            if (settings.storage) {
                this.storage = settings.storage;
            }
            else {
                if ((0, helpers_1.supportsLocalStorage)()) {
                    this.storage = globalThis.localStorage;
                }
                else {
                    this.memoryStorage = {};
                    this.storage = (0, local_storage_1.memoryLocalStorageAdapter)(this.memoryStorage);
                }
            }
            if (settings.userStorage) {
                this.userStorage = settings.userStorage;
            }
        }
        else {
            this.memoryStorage = {};
            this.storage = (0, local_storage_1.memoryLocalStorageAdapter)(this.memoryStorage);
        }
        if ((0, helpers_1.isBrowser)() && globalThis.BroadcastChannel && this.persistSession && this.storageKey) {
            try {
                this.broadcastChannel = new globalThis.BroadcastChannel(this.storageKey);
            }
            catch (e) {
                console.error('Failed to create a new BroadcastChannel, multi-tab state changes will not be available', e);
            }
            (_c = this.broadcastChannel) === null || _c === void 0 ? void 0 : _c.addEventListener('message', async (event) => {
                this._debug('received broadcast notification from other tab or client', event);
                try {
                    await this._notifyAllSubscribers(event.data.event, event.data.session, false); // broadcast = false so we don't get an endless loop of messages
                }
                catch (error) {
                    this._debug('#broadcastChannel', 'error', error);
                }
            });
        }
        // Only auto-initialize if not explicitly disabled. Skipped in SSR contexts
        // where initialization timing must be controlled. All public methods have
        // lazy initialization, so the client remains fully functional.
        if (!settings.skipAutoInitialize) {
            this.initialize().catch((error) => {
                this._debug('#initialize()', 'error', error);
            });
        }
    }
    /**
     * Returns whether error throwing mode is enabled for this client.
     */
    isThrowOnErrorEnabled() {
        return this.throwOnError;
    }
    /**
     * Centralizes return handling with optional error throwing. When `throwOnError` is enabled
     * and the provided result contains a non-nullish error, the error is thrown instead of
     * being returned. This ensures consistent behavior across all public API methods.
     */
    _returnResult(result) {
        if (this.throwOnError && result && result.error) {
            throw result.error;
        }
        return result;
    }
    _logPrefix() {
        return ('GoTrueClient@' +
            `${this.storageKey}:${this.instanceID} (${version_1.version}) ${new Date().toISOString()}`);
    }
    _debug(...args) {
        if (this.logDebugMessages) {
            this.logger(this._logPrefix(), ...args);
        }
        return this;
    }
    /**
     * Initializes the client session either from the url or from storage.
     * This method is automatically called when instantiating the client, but should also be called
     * manually when checking for an error from an auth redirect (oauth, magiclink, password recovery, etc).
     */
    async initialize() {
        if (this.initializePromise) {
            return await this.initializePromise;
        }
        this.initializePromise = (async () => {
            return await this._acquireLock(this.lockAcquireTimeout, async () => {
                return await this._initialize();
            });
        })();
        return await this.initializePromise;
    }
    /**
     * IMPORTANT:
     * 1. Never throw in this method, as it is called from the constructor
     * 2. Never return a session from this method as it would be cached over
     *    the whole lifetime of the client
     */
    async _initialize() {
        var _a;
        try {
            let params = {};
            let callbackUrlType = 'none';
            if ((0, helpers_1.isBrowser)()) {
                params = (0, helpers_1.parseParametersFromURL)(window.location.href);
                if (this._isImplicitGrantCallback(params)) {
                    callbackUrlType = 'implicit';
                }
                else if (await this._isPKCECallback(params)) {
                    callbackUrlType = 'pkce';
                }
            }
            /**
             * Attempt to get the session from the URL only if these conditions are fulfilled
             *
             * Note: If the URL isn't one of the callback url types (implicit or pkce),
             * then there could be an existing session so we don't want to prematurely remove it
             */
            if ((0, helpers_1.isBrowser)() && this.detectSessionInUrl && callbackUrlType !== 'none') {
                const { data, error } = await this._getSessionFromURL(params, callbackUrlType);
                if (error) {
                    this._debug('#_initialize()', 'error detecting session from URL', error);
                    if ((0, errors_1.isAuthImplicitGrantRedirectError)(error)) {
                        const errorCode = (_a = error.details) === null || _a === void 0 ? void 0 : _a.code;
                        if (errorCode === 'identity_already_exists' ||
                            errorCode === 'identity_not_found' ||
                            errorCode === 'single_identity_not_deletable') {
                            return { error };
                        }
                    }
                    // Don't remove existing session on URL login failure.
                    // A failed attempt (e.g. reused magic link) shouldn't invalidate a valid session.
                    return { error };
                }
                const { session, redirectType } = data;
                this._debug('#_initialize()', 'detected session in URL', session, 'redirect type', redirectType);
                await this._saveSession(session);
                setTimeout(async () => {
                    if (redirectType === 'recovery') {
                        await this._notifyAllSubscribers('PASSWORD_RECOVERY', session);
                    }
                    else {
                        await this._notifyAllSubscribers('SIGNED_IN', session);
                    }
                }, 0);
                return { error: null };
            }
            // no login attempt via callback url try to recover session from storage
            await this._recoverAndRefresh();
            return { error: null };
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ error });
            }
            return this._returnResult({
                error: new errors_1.AuthUnknownError('Unexpected error during initialization', error),
            });
        }
        finally {
            await this._handleVisibilityChange();
            this._debug('#_initialize()', 'end');
        }
    }
    /**
     * Creates a new anonymous user.
     *
     * @returns A session where the is_anonymous claim in the access token JWT set to true
     */
    async signInAnonymously(credentials) {
        var _a, _b, _c;
        try {
            const res = await (0, fetch_1._request)(this.fetch, 'POST', `${this.url}/signup`, {
                headers: this.headers,
                body: {
                    data: (_b = (_a = credentials === null || credentials === void 0 ? void 0 : credentials.options) === null || _a === void 0 ? void 0 : _a.data) !== null && _b !== void 0 ? _b : {},
                    gotrue_meta_security: { captcha_token: (_c = credentials === null || credentials === void 0 ? void 0 : credentials.options) === null || _c === void 0 ? void 0 : _c.captchaToken },
                },
                xform: fetch_1._sessionResponse,
            });
            const { data, error } = res;
            if (error || !data) {
                return this._returnResult({ data: { user: null, session: null }, error: error });
            }
            const session = data.session;
            const user = data.user;
            if (data.session) {
                await this._saveSession(data.session);
                await this._notifyAllSubscribers('SIGNED_IN', session);
            }
            return this._returnResult({ data: { user, session }, error: null });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: { user: null, session: null }, error });
            }
            throw error;
        }
    }
    /**
     * Creates a new user.
     *
     * Be aware that if a user account exists in the system you may get back an
     * error message that attempts to hide this information from the user.
     * This method has support for PKCE via email signups. The PKCE flow cannot be used when autoconfirm is enabled.
     *
     * @returns A logged-in session if the server has "autoconfirm" ON
     * @returns A user if the server has "autoconfirm" OFF
     */
    async signUp(credentials) {
        var _a, _b, _c;
        try {
            let res;
            if ('email' in credentials) {
                const { email, password, options } = credentials;
                let codeChallenge = null;
                let codeChallengeMethod = null;
                if (this.flowType === 'pkce') {
                    ;
                    [codeChallenge, codeChallengeMethod] = await (0, helpers_1.getCodeChallengeAndMethod)(this.storage, this.storageKey);
                }
                res = await (0, fetch_1._request)(this.fetch, 'POST', `${this.url}/signup`, {
                    headers: this.headers,
                    redirectTo: options === null || options === void 0 ? void 0 : options.emailRedirectTo,
                    body: {
                        email,
                        password,
                        data: (_a = options === null || options === void 0 ? void 0 : options.data) !== null && _a !== void 0 ? _a : {},
                        gotrue_meta_security: { captcha_token: options === null || options === void 0 ? void 0 : options.captchaToken },
                        code_challenge: codeChallenge,
                        code_challenge_method: codeChallengeMethod,
                    },
                    xform: fetch_1._sessionResponse,
                });
            }
            else if ('phone' in credentials) {
                const { phone, password, options } = credentials;
                res = await (0, fetch_1._request)(this.fetch, 'POST', `${this.url}/signup`, {
                    headers: this.headers,
                    body: {
                        phone,
                        password,
                        data: (_b = options === null || options === void 0 ? void 0 : options.data) !== null && _b !== void 0 ? _b : {},
                        channel: (_c = options === null || options === void 0 ? void 0 : options.channel) !== null && _c !== void 0 ? _c : 'sms',
                        gotrue_meta_security: { captcha_token: options === null || options === void 0 ? void 0 : options.captchaToken },
                    },
                    xform: fetch_1._sessionResponse,
                });
            }
            else {
                throw new errors_1.AuthInvalidCredentialsError('You must provide either an email or phone number and a password');
            }
            const { data, error } = res;
            if (error || !data) {
                await (0, helpers_1.removeItemAsync)(this.storage, `${this.storageKey}-code-verifier`);
                return this._returnResult({ data: { user: null, session: null }, error: error });
            }
            const session = data.session;
            const user = data.user;
            if (data.session) {
                await this._saveSession(data.session);
                await this._notifyAllSubscribers('SIGNED_IN', session);
            }
            return this._returnResult({ data: { user, session }, error: null });
        }
        catch (error) {
            await (0, helpers_1.removeItemAsync)(this.storage, `${this.storageKey}-code-verifier`);
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: { user: null, session: null }, error });
            }
            throw error;
        }
    }
    /**
     * Log in an existing user with an email and password or phone and password.
     *
     * Be aware that you may get back an error message that will not distinguish
     * between the cases where the account does not exist or that the
     * email/phone and password combination is wrong or that the account can only
     * be accessed via social login.
     */
    async signInWithPassword(credentials) {
        try {
            let res;
            if ('email' in credentials) {
                const { email, password, options } = credentials;
                res = await (0, fetch_1._request)(this.fetch, 'POST', `${this.url}/token?grant_type=password`, {
                    headers: this.headers,
                    body: {
                        email,
                        password,
                        gotrue_meta_security: { captcha_token: options === null || options === void 0 ? void 0 : options.captchaToken },
                    },
                    xform: fetch_1._sessionResponsePassword,
                });
            }
            else if ('phone' in credentials) {
                const { phone, password, options } = credentials;
                res = await (0, fetch_1._request)(this.fetch, 'POST', `${this.url}/token?grant_type=password`, {
                    headers: this.headers,
                    body: {
                        phone,
                        password,
                        gotrue_meta_security: { captcha_token: options === null || options === void 0 ? void 0 : options.captchaToken },
                    },
                    xform: fetch_1._sessionResponsePassword,
                });
            }
            else {
                throw new errors_1.AuthInvalidCredentialsError('You must provide either an email or phone number and a password');
            }
            const { data, error } = res;
            if (error) {
                return this._returnResult({ data: { user: null, session: null }, error });
            }
            else if (!data || !data.session || !data.user) {
                const invalidTokenError = new errors_1.AuthInvalidTokenResponseError();
                return this._returnResult({ data: { user: null, session: null }, error: invalidTokenError });
            }
            if (data.session) {
                await this._saveSession(data.session);
                await this._notifyAllSubscribers('SIGNED_IN', data.session);
            }
            return this._returnResult({
                data: Object.assign({ user: data.user, session: data.session }, (data.weak_password ? { weakPassword: data.weak_password } : null)),
                error,
            });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: { user: null, session: null }, error });
            }
            throw error;
        }
    }
    /**
     * Log in an existing user via a third-party provider.
     * This method supports the PKCE flow.
     */
    async signInWithOAuth(credentials) {
        var _a, _b, _c, _d;
        return await this._handleProviderSignIn(credentials.provider, {
            redirectTo: (_a = credentials.options) === null || _a === void 0 ? void 0 : _a.redirectTo,
            scopes: (_b = credentials.options) === null || _b === void 0 ? void 0 : _b.scopes,
            queryParams: (_c = credentials.options) === null || _c === void 0 ? void 0 : _c.queryParams,
            skipBrowserRedirect: (_d = credentials.options) === null || _d === void 0 ? void 0 : _d.skipBrowserRedirect,
        });
    }
    /**
     * Log in an existing user by exchanging an Auth Code issued during the PKCE flow.
     */
    async exchangeCodeForSession(authCode) {
        await this.initializePromise;
        return this._acquireLock(this.lockAcquireTimeout, async () => {
            return this._exchangeCodeForSession(authCode);
        });
    }
    /**
     * Signs in a user by verifying a message signed by the user's private key.
     * Supports Ethereum (via Sign-In-With-Ethereum) & Solana (Sign-In-With-Solana) standards,
     * both of which derive from the EIP-4361 standard
     * With slight variation on Solana's side.
     * @reference https://eips.ethereum.org/EIPS/eip-4361
     */
    async signInWithWeb3(credentials) {
        const { chain } = credentials;
        switch (chain) {
            case 'ethereum':
                return await this.signInWithEthereum(credentials);
            case 'solana':
                return await this.signInWithSolana(credentials);
            default:
                throw new Error(`@supabase/auth-js: Unsupported chain "${chain}"`);
        }
    }
    async signInWithEthereum(credentials) {
        var _a, _b, _c, _d, _e, _f, _g, _h, _j, _k, _l;
        // TODO: flatten type
        let message;
        let signature;
        if ('message' in credentials) {
            message = credentials.message;
            signature = credentials.signature;
        }
        else {
            const { chain, wallet, statement, options } = credentials;
            let resolvedWallet;
            if (!(0, helpers_1.isBrowser)()) {
                if (typeof wallet !== 'object' || !(options === null || options === void 0 ? void 0 : options.url)) {
                    throw new Error('@supabase/auth-js: Both wallet and url must be specified in non-browser environments.');
                }
                resolvedWallet = wallet;
            }
            else if (typeof wallet === 'object') {
                resolvedWallet = wallet;
            }
            else {
                const windowAny = window;
                if ('ethereum' in windowAny &&
                    typeof windowAny.ethereum === 'object' &&
                    'request' in windowAny.ethereum &&
                    typeof windowAny.ethereum.request === 'function') {
                    resolvedWallet = windowAny.ethereum;
                }
                else {
                    throw new Error(`@supabase/auth-js: No compatible Ethereum wallet interface on the window object (window.ethereum) detected. Make sure the user already has a wallet installed and connected for this app. Prefer passing the wallet interface object directly to signInWithWeb3({ chain: 'ethereum', wallet: resolvedUserWallet }) instead.`);
                }
            }
            const url = new URL((_a = options === null || options === void 0 ? void 0 : options.url) !== null && _a !== void 0 ? _a : window.location.href);
            const accounts = await resolvedWallet
                .request({
                method: 'eth_requestAccounts',
            })
                .then((accs) => accs)
                .catch(() => {
                throw new Error(`@supabase/auth-js: Wallet method eth_requestAccounts is missing or invalid`);
            });
            if (!accounts || accounts.length === 0) {
                throw new Error(`@supabase/auth-js: No accounts available. Please ensure the wallet is connected.`);
            }
            const address = (0, ethereum_1.getAddress)(accounts[0]);
            let chainId = (_b = options === null || options === void 0 ? void 0 : options.signInWithEthereum) === null || _b === void 0 ? void 0 : _b.chainId;
            if (!chainId) {
                const chainIdHex = await resolvedWallet.request({
                    method: 'eth_chainId',
                });
                chainId = (0, ethereum_1.fromHex)(chainIdHex);
            }
            const siweMessage = {
                domain: url.host,
                address: address,
                statement: statement,
                uri: url.href,
                version: '1',
                chainId: chainId,
                nonce: (_c = options === null || options === void 0 ? void 0 : options.signInWithEthereum) === null || _c === void 0 ? void 0 : _c.nonce,
                issuedAt: (_e = (_d = options === null || options === void 0 ? void 0 : options.signInWithEthereum) === null || _d === void 0 ? void 0 : _d.issuedAt) !== null && _e !== void 0 ? _e : new Date(),
                expirationTime: (_f = options === null || options === void 0 ? void 0 : options.signInWithEthereum) === null || _f === void 0 ? void 0 : _f.expirationTime,
                notBefore: (_g = options === null || options === void 0 ? void 0 : options.signInWithEthereum) === null || _g === void 0 ? void 0 : _g.notBefore,
                requestId: (_h = options === null || options === void 0 ? void 0 : options.signInWithEthereum) === null || _h === void 0 ? void 0 : _h.requestId,
                resources: (_j = options === null || options === void 0 ? void 0 : options.signInWithEthereum) === null || _j === void 0 ? void 0 : _j.resources,
            };
            message = (0, ethereum_1.createSiweMessage)(siweMessage);
            // Sign message
            signature = (await resolvedWallet.request({
                method: 'personal_sign',
                params: [(0, ethereum_1.toHex)(message), address],
            }));
        }
        try {
            const { data, error } = await (0, fetch_1._request)(this.fetch, 'POST', `${this.url}/token?grant_type=web3`, {
                headers: this.headers,
                body: Object.assign({ chain: 'ethereum', message,
                    signature }, (((_k = credentials.options) === null || _k === void 0 ? void 0 : _k.captchaToken)
                    ? { gotrue_meta_security: { captcha_token: (_l = credentials.options) === null || _l === void 0 ? void 0 : _l.captchaToken } }
                    : null)),
                xform: fetch_1._sessionResponse,
            });
            if (error) {
                throw error;
            }
            if (!data || !data.session || !data.user) {
                const invalidTokenError = new errors_1.AuthInvalidTokenResponseError();
                return this._returnResult({ data: { user: null, session: null }, error: invalidTokenError });
            }
            if (data.session) {
                await this._saveSession(data.session);
                await this._notifyAllSubscribers('SIGNED_IN', data.session);
            }
            return this._returnResult({ data: Object.assign({}, data), error });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: { user: null, session: null }, error });
            }
            throw error;
        }
    }
    async signInWithSolana(credentials) {
        var _a, _b, _c, _d, _e, _f, _g, _h, _j, _k, _l, _m;
        let message;
        let signature;
        if ('message' in credentials) {
            message = credentials.message;
            signature = credentials.signature;
        }
        else {
            const { chain, wallet, statement, options } = credentials;
            let resolvedWallet;
            if (!(0, helpers_1.isBrowser)()) {
                if (typeof wallet !== 'object' || !(options === null || options === void 0 ? void 0 : options.url)) {
                    throw new Error('@supabase/auth-js: Both wallet and url must be specified in non-browser environments.');
                }
                resolvedWallet = wallet;
            }
            else if (typeof wallet === 'object') {
                resolvedWallet = wallet;
            }
            else {
                const windowAny = window;
                if ('solana' in windowAny &&
                    typeof windowAny.solana === 'object' &&
                    (('signIn' in windowAny.solana && typeof windowAny.solana.signIn === 'function') ||
                        ('signMessage' in windowAny.solana &&
                            typeof windowAny.solana.signMessage === 'function'))) {
                    resolvedWallet = windowAny.solana;
                }
                else {
                    throw new Error(`@supabase/auth-js: No compatible Solana wallet interface on the window object (window.solana) detected. Make sure the user already has a wallet installed and connected for this app. Prefer passing the wallet interface object directly to signInWithWeb3({ chain: 'solana', wallet: resolvedUserWallet }) instead.`);
                }
            }
            const url = new URL((_a = options === null || options === void 0 ? void 0 : options.url) !== null && _a !== void 0 ? _a : window.location.href);
            if ('signIn' in resolvedWallet && resolvedWallet.signIn) {
                const output = await resolvedWallet.signIn(Object.assign(Object.assign(Object.assign({ issuedAt: new Date().toISOString() }, options === null || options === void 0 ? void 0 : options.signInWithSolana), { 
                    // non-overridable properties
                    version: '1', domain: url.host, uri: url.href }), (statement ? { statement } : null)));
                let outputToProcess;
                if (Array.isArray(output) && output[0] && typeof output[0] === 'object') {
                    outputToProcess = output[0];
                }
                else if (output &&
                    typeof output === 'object' &&
                    'signedMessage' in output &&
                    'signature' in output) {
                    outputToProcess = output;
                }
                else {
                    throw new Error('@supabase/auth-js: Wallet method signIn() returned unrecognized value');
                }
                if ('signedMessage' in outputToProcess &&
                    'signature' in outputToProcess &&
                    (typeof outputToProcess.signedMessage === 'string' ||
                        outputToProcess.signedMessage instanceof Uint8Array) &&
                    outputToProcess.signature instanceof Uint8Array) {
                    message =
                        typeof outputToProcess.signedMessage === 'string'
                            ? outputToProcess.signedMessage
                            : new TextDecoder().decode(outputToProcess.signedMessage);
                    signature = outputToProcess.signature;
                }
                else {
                    throw new Error('@supabase/auth-js: Wallet method signIn() API returned object without signedMessage and signature fields');
                }
            }
            else {
                if (!('signMessage' in resolvedWallet) ||
                    typeof resolvedWallet.signMessage !== 'function' ||
                    !('publicKey' in resolvedWallet) ||
                    typeof resolvedWallet !== 'object' ||
                    !resolvedWallet.publicKey ||
                    !('toBase58' in resolvedWallet.publicKey) ||
                    typeof resolvedWallet.publicKey.toBase58 !== 'function') {
                    throw new Error('@supabase/auth-js: Wallet does not have a compatible signMessage() and publicKey.toBase58() API');
                }
                message = [
                    `${url.host} wants you to sign in with your Solana account:`,
                    resolvedWallet.publicKey.toBase58(),
                    ...(statement ? ['', statement, ''] : ['']),
                    'Version: 1',
                    `URI: ${url.href}`,
                    `Issued At: ${(_c = (_b = options === null || options === void 0 ? void 0 : options.signInWithSolana) === null || _b === void 0 ? void 0 : _b.issuedAt) !== null && _c !== void 0 ? _c : new Date().toISOString()}`,
                    ...(((_d = options === null || options === void 0 ? void 0 : options.signInWithSolana) === null || _d === void 0 ? void 0 : _d.notBefore)
                        ? [`Not Before: ${options.signInWithSolana.notBefore}`]
                        : []),
                    ...(((_e = options === null || options === void 0 ? void 0 : options.signInWithSolana) === null || _e === void 0 ? void 0 : _e.expirationTime)
                        ? [`Expiration Time: ${options.signInWithSolana.expirationTime}`]
                        : []),
                    ...(((_f = options === null || options === void 0 ? void 0 : options.signInWithSolana) === null || _f === void 0 ? void 0 : _f.chainId)
                        ? [`Chain ID: ${options.signInWithSolana.chainId}`]
                        : []),
                    ...(((_g = options === null || options === void 0 ? void 0 : options.signInWithSolana) === null || _g === void 0 ? void 0 : _g.nonce) ? [`Nonce: ${options.signInWithSolana.nonce}`] : []),
                    ...(((_h = options === null || options === void 0 ? void 0 : options.signInWithSolana) === null || _h === void 0 ? void 0 : _h.requestId)
                        ? [`Request ID: ${options.signInWithSolana.requestId}`]
                        : []),
                    ...(((_k = (_j = options === null || options === void 0 ? void 0 : options.signInWithSolana) === null || _j === void 0 ? void 0 : _j.resources) === null || _k === void 0 ? void 0 : _k.length)
                        ? [
                            'Resources',
                            ...options.signInWithSolana.resources.map((resource) => `- ${resource}`),
                        ]
                        : []),
                ].join('\n');
                const maybeSignature = await resolvedWallet.signMessage(new TextEncoder().encode(message), 'utf8');
                if (!maybeSignature || !(maybeSignature instanceof Uint8Array)) {
                    throw new Error('@supabase/auth-js: Wallet signMessage() API returned an recognized value');
                }
                signature = maybeSignature;
            }
        }
        try {
            const { data, error } = await (0, fetch_1._request)(this.fetch, 'POST', `${this.url}/token?grant_type=web3`, {
                headers: this.headers,
                body: Object.assign({ chain: 'solana', message, signature: (0, base64url_1.bytesToBase64URL)(signature) }, (((_l = credentials.options) === null || _l === void 0 ? void 0 : _l.captchaToken)
                    ? { gotrue_meta_security: { captcha_token: (_m = credentials.options) === null || _m === void 0 ? void 0 : _m.captchaToken } }
                    : null)),
                xform: fetch_1._sessionResponse,
            });
            if (error) {
                throw error;
            }
            if (!data || !data.session || !data.user) {
                const invalidTokenError = new errors_1.AuthInvalidTokenResponseError();
                return this._returnResult({ data: { user: null, session: null }, error: invalidTokenError });
            }
            if (data.session) {
                await this._saveSession(data.session);
                await this._notifyAllSubscribers('SIGNED_IN', data.session);
            }
            return this._returnResult({ data: Object.assign({}, data), error });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: { user: null, session: null }, error });
            }
            throw error;
        }
    }
    async _exchangeCodeForSession(authCode) {
        const storageItem = await (0, helpers_1.getItemAsync)(this.storage, `${this.storageKey}-code-verifier`);
        const [codeVerifier, redirectType] = (storageItem !== null && storageItem !== void 0 ? storageItem : '').split('/');
        try {
            if (!codeVerifier && this.flowType === 'pkce') {
                throw new errors_1.AuthPKCECodeVerifierMissingError();
            }
            const { data, error } = await (0, fetch_1._request)(this.fetch, 'POST', `${this.url}/token?grant_type=pkce`, {
                headers: this.headers,
                body: {
                    auth_code: authCode,
                    code_verifier: codeVerifier,
                },
                xform: fetch_1._sessionResponse,
            });
            await (0, helpers_1.removeItemAsync)(this.storage, `${this.storageKey}-code-verifier`);
            if (error) {
                throw error;
            }
            if (!data || !data.session || !data.user) {
                const invalidTokenError = new errors_1.AuthInvalidTokenResponseError();
                return this._returnResult({
                    data: { user: null, session: null, redirectType: null },
                    error: invalidTokenError,
                });
            }
            if (data.session) {
                await this._saveSession(data.session);
                await this._notifyAllSubscribers('SIGNED_IN', data.session);
            }
            return this._returnResult({ data: Object.assign(Object.assign({}, data), { redirectType: redirectType !== null && redirectType !== void 0 ? redirectType : null }), error });
        }
        catch (error) {
            await (0, helpers_1.removeItemAsync)(this.storage, `${this.storageKey}-code-verifier`);
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({
                    data: { user: null, session: null, redirectType: null },
                    error,
                });
            }
            throw error;
        }
    }
    /**
     * Allows signing in with an OIDC ID token. The authentication provider used
     * should be enabled and configured.
     */
    async signInWithIdToken(credentials) {
        try {
            const { options, provider, token, access_token, nonce } = credentials;
            const res = await (0, fetch_1._request)(this.fetch, 'POST', `${this.url}/token?grant_type=id_token`, {
                headers: this.headers,
                body: {
                    provider,
                    id_token: token,
                    access_token,
                    nonce,
                    gotrue_meta_security: { captcha_token: options === null || options === void 0 ? void 0 : options.captchaToken },
                },
                xform: fetch_1._sessionResponse,
            });
            const { data, error } = res;
            if (error) {
                return this._returnResult({ data: { user: null, session: null }, error });
            }
            else if (!data || !data.session || !data.user) {
                const invalidTokenError = new errors_1.AuthInvalidTokenResponseError();
                return this._returnResult({ data: { user: null, session: null }, error: invalidTokenError });
            }
            if (data.session) {
                await this._saveSession(data.session);
                await this._notifyAllSubscribers('SIGNED_IN', data.session);
            }
            return this._returnResult({ data, error });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: { user: null, session: null }, error });
            }
            throw error;
        }
    }
    /**
     * Log in a user using magiclink or a one-time password (OTP).
     *
     * If the `{{ .ConfirmationURL }}` variable is specified in the email template, a magiclink will be sent.
     * If the `{{ .Token }}` variable is specified in the email template, an OTP will be sent.
     * If you're using phone sign-ins, only an OTP will be sent. You won't be able to send a magiclink for phone sign-ins.
     *
     * Be aware that you may get back an error message that will not distinguish
     * between the cases where the account does not exist or, that the account
     * can only be accessed via social login.
     *
     * Do note that you will need to configure a Whatsapp sender on Twilio
     * if you are using phone sign in with the 'whatsapp' channel. The whatsapp
     * channel is not supported on other providers
     * at this time.
     * This method supports PKCE when an email is passed.
     */
    async signInWithOtp(credentials) {
        var _a, _b, _c, _d, _e;
        try {
            if ('email' in credentials) {
                const { email, options } = credentials;
                let codeChallenge = null;
                let codeChallengeMethod = null;
                if (this.flowType === 'pkce') {
                    ;
                    [codeChallenge, codeChallengeMethod] = await (0, helpers_1.getCodeChallengeAndMethod)(this.storage, this.storageKey);
                }
                const { error } = await (0, fetch_1._request)(this.fetch, 'POST', `${this.url}/otp`, {
                    headers: this.headers,
                    body: {
                        email,
                        data: (_a = options === null || options === void 0 ? void 0 : options.data) !== null && _a !== void 0 ? _a : {},
                        create_user: (_b = options === null || options === void 0 ? void 0 : options.shouldCreateUser) !== null && _b !== void 0 ? _b : true,
                        gotrue_meta_security: { captcha_token: options === null || options === void 0 ? void 0 : options.captchaToken },
                        code_challenge: codeChallenge,
                        code_challenge_method: codeChallengeMethod,
                    },
                    redirectTo: options === null || options === void 0 ? void 0 : options.emailRedirectTo,
                });
                return this._returnResult({ data: { user: null, session: null }, error });
            }
            if ('phone' in credentials) {
                const { phone, options } = credentials;
                const { data, error } = await (0, fetch_1._request)(this.fetch, 'POST', `${this.url}/otp`, {
                    headers: this.headers,
                    body: {
                        phone,
                        data: (_c = options === null || options === void 0 ? void 0 : options.data) !== null && _c !== void 0 ? _c : {},
                        create_user: (_d = options === null || options === void 0 ? void 0 : options.shouldCreateUser) !== null && _d !== void 0 ? _d : true,
                        gotrue_meta_security: { captcha_token: options === null || options === void 0 ? void 0 : options.captchaToken },
                        channel: (_e = options === null || options === void 0 ? void 0 : options.channel) !== null && _e !== void 0 ? _e : 'sms',
                    },
                });
                return this._returnResult({
                    data: { user: null, session: null, messageId: data === null || data === void 0 ? void 0 : data.message_id },
                    error,
                });
            }
            throw new errors_1.AuthInvalidCredentialsError('You must provide either an email or phone number.');
        }
        catch (error) {
            await (0, helpers_1.removeItemAsync)(this.storage, `${this.storageKey}-code-verifier`);
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: { user: null, session: null }, error });
            }
            throw error;
        }
    }
    /**
     * Log in a user given a User supplied OTP or TokenHash received through mobile or email.
     */
    async verifyOtp(params) {
        var _a, _b;
        try {
            let redirectTo = undefined;
            let captchaToken = undefined;
            if ('options' in params) {
                redirectTo = (_a = params.options) === null || _a === void 0 ? void 0 : _a.redirectTo;
                captchaToken = (_b = params.options) === null || _b === void 0 ? void 0 : _b.captchaToken;
            }
            const { data, error } = await (0, fetch_1._request)(this.fetch, 'POST', `${this.url}/verify`, {
                headers: this.headers,
                body: Object.assign(Object.assign({}, params), { gotrue_meta_security: { captcha_token: captchaToken } }),
                redirectTo,
                xform: fetch_1._sessionResponse,
            });
            if (error) {
                throw error;
            }
            if (!data) {
                const tokenVerificationError = new Error('An error occurred on token verification.');
                throw tokenVerificationError;
            }
            const session = data.session;
            const user = data.user;
            if (session === null || session === void 0 ? void 0 : session.access_token) {
                await this._saveSession(session);
                await this._notifyAllSubscribers(params.type == 'recovery' ? 'PASSWORD_RECOVERY' : 'SIGNED_IN', session);
            }
            return this._returnResult({ data: { user, session }, error: null });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: { user: null, session: null }, error });
            }
            throw error;
        }
    }
    /**
     * Attempts a single-sign on using an enterprise Identity Provider. A
     * successful SSO attempt will redirect the current page to the identity
     * provider authorization page. The redirect URL is implementation and SSO
     * protocol specific.
     *
     * You can use it by providing a SSO domain. Typically you can extract this
     * domain by asking users for their email address. If this domain is
     * registered on the Auth instance the redirect will use that organization's
     * currently active SSO Identity Provider for the login.
     *
     * If you have built an organization-specific login page, you can use the
     * organization's SSO Identity Provider UUID directly instead.
     */
    async signInWithSSO(params) {
        var _a, _b, _c, _d, _e;
        try {
            let codeChallenge = null;
            let codeChallengeMethod = null;
            if (this.flowType === 'pkce') {
                ;
                [codeChallenge, codeChallengeMethod] = await (0, helpers_1.getCodeChallengeAndMethod)(this.storage, this.storageKey);
            }
            const result = await (0, fetch_1._request)(this.fetch, 'POST', `${this.url}/sso`, {
                body: Object.assign(Object.assign(Object.assign(Object.assign(Object.assign({}, ('providerId' in params ? { provider_id: params.providerId } : null)), ('domain' in params ? { domain: params.domain } : null)), { redirect_to: (_b = (_a = params.options) === null || _a === void 0 ? void 0 : _a.redirectTo) !== null && _b !== void 0 ? _b : undefined }), (((_c = params === null || params === void 0 ? void 0 : params.options) === null || _c === void 0 ? void 0 : _c.captchaToken)
                    ? { gotrue_meta_security: { captcha_token: params.options.captchaToken } }
                    : null)), { skip_http_redirect: true, code_challenge: codeChallenge, code_challenge_method: codeChallengeMethod }),
                headers: this.headers,
                xform: fetch_1._ssoResponse,
            });
            // Automatically redirect in browser unless skipBrowserRedirect is true
            if (((_d = result.data) === null || _d === void 0 ? void 0 : _d.url) && (0, helpers_1.isBrowser)() && !((_e = params.options) === null || _e === void 0 ? void 0 : _e.skipBrowserRedirect)) {
                window.location.assign(result.data.url);
            }
            return this._returnResult(result);
        }
        catch (error) {
            await (0, helpers_1.removeItemAsync)(this.storage, `${this.storageKey}-code-verifier`);
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: null, error });
            }
            throw error;
        }
    }
    /**
     * Sends a reauthentication OTP to the user's email or phone number.
     * Requires the user to be signed-in.
     */
    async reauthenticate() {
        await this.initializePromise;
        return await this._acquireLock(this.lockAcquireTimeout, async () => {
            return await this._reauthenticate();
        });
    }
    async _reauthenticate() {
        try {
            return await this._useSession(async (result) => {
                const { data: { session }, error: sessionError, } = result;
                if (sessionError)
                    throw sessionError;
                if (!session)
                    throw new errors_1.AuthSessionMissingError();
                const { error } = await (0, fetch_1._request)(this.fetch, 'GET', `${this.url}/reauthenticate`, {
                    headers: this.headers,
                    jwt: session.access_token,
                });
                return this._returnResult({ data: { user: null, session: null }, error });
            });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: { user: null, session: null }, error });
            }
            throw error;
        }
    }
    /**
     * Resends an existing signup confirmation email, email change email, SMS OTP or phone change OTP.
     */
    async resend(credentials) {
        try {
            const endpoint = `${this.url}/resend`;
            if ('email' in credentials) {
                const { email, type, options } = credentials;
                const { error } = await (0, fetch_1._request)(this.fetch, 'POST', endpoint, {
                    headers: this.headers,
                    body: {
                        email,
                        type,
                        gotrue_meta_security: { captcha_token: options === null || options === void 0 ? void 0 : options.captchaToken },
                    },
                    redirectTo: options === null || options === void 0 ? void 0 : options.emailRedirectTo,
                });
                return this._returnResult({ data: { user: null, session: null }, error });
            }
            else if ('phone' in credentials) {
                const { phone, type, options } = credentials;
                const { data, error } = await (0, fetch_1._request)(this.fetch, 'POST', endpoint, {
                    headers: this.headers,
                    body: {
                        phone,
                        type,
                        gotrue_meta_security: { captcha_token: options === null || options === void 0 ? void 0 : options.captchaToken },
                    },
                });
                return this._returnResult({
                    data: { user: null, session: null, messageId: data === null || data === void 0 ? void 0 : data.message_id },
                    error,
                });
            }
            throw new errors_1.AuthInvalidCredentialsError('You must provide either an email or phone number and a type');
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: { user: null, session: null }, error });
            }
            throw error;
        }
    }
    /**
     * Returns the session, refreshing it if necessary.
     *
     * The session returned can be null if the session is not detected which can happen in the event a user is not signed-in or has logged out.
     *
     * **IMPORTANT:** This method loads values directly from the storage attached
     * to the client. If that storage is based on request cookies for example,
     * the values in it may not be authentic and therefore it's strongly advised
     * against using this method and its results in such circumstances. A warning
     * will be emitted if this is detected. Use {@link #getUser()} instead.
     */
    async getSession() {
        await this.initializePromise;
        const result = await this._acquireLock(this.lockAcquireTimeout, async () => {
            return this._useSession(async (result) => {
                return result;
            });
        });
        return result;
    }
    /**
     * Acquires a global lock based on the storage key.
     */
    async _acquireLock(acquireTimeout, fn) {
        this._debug('#_acquireLock', 'begin', acquireTimeout);
        try {
            if (this.lockAcquired) {
                const last = this.pendingInLock.length
                    ? this.pendingInLock[this.pendingInLock.length - 1]
                    : Promise.resolve();
                const result = (async () => {
                    await last;
                    return await fn();
                })();
                this.pendingInLock.push((async () => {
                    try {
                        await result;
                    }
                    catch (e) {
                        // we just care if it finished
                    }
                })());
                return result;
            }
            return await this.lock(`lock:${this.storageKey}`, acquireTimeout, async () => {
                this._debug('#_acquireLock', 'lock acquired for storage key', this.storageKey);
                try {
                    this.lockAcquired = true;
                    const result = fn();
                    this.pendingInLock.push((async () => {
                        try {
                            await result;
                        }
                        catch (e) {
                            // we just care if it finished
                        }
                    })());
                    await result;
                    // keep draining the queue until there's nothing to wait on
                    while (this.pendingInLock.length) {
                        const waitOn = [...this.pendingInLock];
                        await Promise.all(waitOn);
                        this.pendingInLock.splice(0, waitOn.length);
                    }
                    return await result;
                }
                finally {
                    this._debug('#_acquireLock', 'lock released for storage key', this.storageKey);
                    this.lockAcquired = false;
                }
            });
        }
        finally {
            this._debug('#_acquireLock', 'end');
        }
    }
    /**
     * Use instead of {@link #getSession} inside the library. It is
     * semantically usually what you want, as getting a session involves some
     * processing afterwards that requires only one client operating on the
     * session at once across multiple tabs or processes.
     */
    async _useSession(fn) {
        this._debug('#_useSession', 'begin');
        try {
            // the use of __loadSession here is the only correct use of the function!
            const result = await this.__loadSession();
            return await fn(result);
        }
        finally {
            this._debug('#_useSession', 'end');
        }
    }
    /**
     * NEVER USE DIRECTLY!
     *
     * Always use {@link #_useSession}.
     */
    async __loadSession() {
        this._debug('#__loadSession()', 'begin');
        if (!this.lockAcquired) {
            this._debug('#__loadSession()', 'used outside of an acquired lock!', new Error().stack);
        }
        try {
            let currentSession = null;
            const maybeSession = await (0, helpers_1.getItemAsync)(this.storage, this.storageKey);
            this._debug('#getSession()', 'session from storage', maybeSession);
            if (maybeSession !== null) {
                if (this._isValidSession(maybeSession)) {
                    currentSession = maybeSession;
                }
                else {
                    this._debug('#getSession()', 'session from storage is not valid');
                    await this._removeSession();
                }
            }
            if (!currentSession) {
                return { data: { session: null }, error: null };
            }
            // A session is considered expired before the access token _actually_
            // expires. When the autoRefreshToken option is off (or when the tab is
            // in the background), very eager users of getSession() -- like
            // realtime-js -- might send a valid JWT which will expire by the time it
            // reaches the server.
            const hasExpired = currentSession.expires_at
                ? currentSession.expires_at * 1000 - Date.now() < constants_1.EXPIRY_MARGIN_MS
                : false;
            this._debug('#__loadSession()', `session has${hasExpired ? '' : ' not'} expired`, 'expires_at', currentSession.expires_at);
            if (!hasExpired) {
                if (this.userStorage) {
                    const maybeUser = (await (0, helpers_1.getItemAsync)(this.userStorage, this.storageKey + '-user'));
                    if (maybeUser === null || maybeUser === void 0 ? void 0 : maybeUser.user) {
                        currentSession.user = maybeUser.user;
                    }
                    else {
                        currentSession.user = (0, helpers_1.userNotAvailableProxy)();
                    }
                }
                // Wrap the user object with a warning proxy on the server
                // This warns when properties of the user are accessed, not when session.user itself is accessed
                if (this.storage.isServer &&
                    currentSession.user &&
                    !currentSession.user.__isUserNotAvailableProxy) {
                    const suppressWarningRef = { value: this.suppressGetSessionWarning };
                    currentSession.user = (0, helpers_1.insecureUserWarningProxy)(currentSession.user, suppressWarningRef);
                    // Update the client-level suppression flag when the proxy suppresses the warning
                    if (suppressWarningRef.value) {
                        this.suppressGetSessionWarning = true;
                    }
                }
                return { data: { session: currentSession }, error: null };
            }
            const { data: session, error } = await this._callRefreshToken(currentSession.refresh_token);
            if (error) {
                return this._returnResult({ data: { session: null }, error });
            }
            return this._returnResult({ data: { session }, error: null });
        }
        finally {
            this._debug('#__loadSession()', 'end');
        }
    }
    /**
     * Gets the current user details if there is an existing session. This method
     * performs a network request to the Supabase Auth server, so the returned
     * value is authentic and can be used to base authorization rules on.
     *
     * @param jwt Takes in an optional access token JWT. If no JWT is provided, the JWT from the current session is used.
     */
    async getUser(jwt) {
        if (jwt) {
            return await this._getUser(jwt);
        }
        await this.initializePromise;
        const result = await this._acquireLock(this.lockAcquireTimeout, async () => {
            return await this._getUser();
        });
        if (result.data.user) {
            this.suppressGetSessionWarning = true;
        }
        return result;
    }
    async _getUser(jwt) {
        try {
            if (jwt) {
                return await (0, fetch_1._request)(this.fetch, 'GET', `${this.url}/user`, {
                    headers: this.headers,
                    jwt: jwt,
                    xform: fetch_1._userResponse,
                });
            }
            return await this._useSession(async (result) => {
                var _a, _b, _c;
                const { data, error } = result;
                if (error) {
                    throw error;
                }
                // returns an error if there is no access_token or custom authorization header
                if (!((_a = data.session) === null || _a === void 0 ? void 0 : _a.access_token) && !this.hasCustomAuthorizationHeader) {
                    return { data: { user: null }, error: new errors_1.AuthSessionMissingError() };
                }
                return await (0, fetch_1._request)(this.fetch, 'GET', `${this.url}/user`, {
                    headers: this.headers,
                    jwt: (_c = (_b = data.session) === null || _b === void 0 ? void 0 : _b.access_token) !== null && _c !== void 0 ? _c : undefined,
                    xform: fetch_1._userResponse,
                });
            });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                if ((0, errors_1.isAuthSessionMissingError)(error)) {
                    // JWT contains a `session_id` which does not correspond to an active
                    // session in the database, indicating the user is signed out.
                    await this._removeSession();
                    await (0, helpers_1.removeItemAsync)(this.storage, `${this.storageKey}-code-verifier`);
                }
                return this._returnResult({ data: { user: null }, error });
            }
            throw error;
        }
    }
    /**
     * Updates user data for a logged in user.
     */
    async updateUser(attributes, options = {}) {
        await this.initializePromise;
        return await this._acquireLock(this.lockAcquireTimeout, async () => {
            return await this._updateUser(attributes, options);
        });
    }
    async _updateUser(attributes, options = {}) {
        try {
            return await this._useSession(async (result) => {
                const { data: sessionData, error: sessionError } = result;
                if (sessionError) {
                    throw sessionError;
                }
                if (!sessionData.session) {
                    throw new errors_1.AuthSessionMissingError();
                }
                const session = sessionData.session;
                let codeChallenge = null;
                let codeChallengeMethod = null;
                if (this.flowType === 'pkce' && attributes.email != null) {
                    ;
                    [codeChallenge, codeChallengeMethod] = await (0, helpers_1.getCodeChallengeAndMethod)(this.storage, this.storageKey);
                }
                const { data, error: userError } = await (0, fetch_1._request)(this.fetch, 'PUT', `${this.url}/user`, {
                    headers: this.headers,
                    redirectTo: options === null || options === void 0 ? void 0 : options.emailRedirectTo,
                    body: Object.assign(Object.assign({}, attributes), { code_challenge: codeChallenge, code_challenge_method: codeChallengeMethod }),
                    jwt: session.access_token,
                    xform: fetch_1._userResponse,
                });
                if (userError) {
                    throw userError;
                }
                session.user = data.user;
                await this._saveSession(session);
                await this._notifyAllSubscribers('USER_UPDATED', session);
                return this._returnResult({ data: { user: session.user }, error: null });
            });
        }
        catch (error) {
            await (0, helpers_1.removeItemAsync)(this.storage, `${this.storageKey}-code-verifier`);
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: { user: null }, error });
            }
            throw error;
        }
    }
    /**
     * Sets the session data from the current session. If the current session is expired, setSession will take care of refreshing it to obtain a new session.
     * If the refresh token or access token in the current session is invalid, an error will be thrown.
     * @param currentSession The current session that minimally contains an access token and refresh token.
     */
    async setSession(currentSession) {
        await this.initializePromise;
        return await this._acquireLock(this.lockAcquireTimeout, async () => {
            return await this._setSession(currentSession);
        });
    }
    async _setSession(currentSession) {
        try {
            if (!currentSession.access_token || !currentSession.refresh_token) {
                throw new errors_1.AuthSessionMissingError();
            }
            const timeNow = Date.now() / 1000;
            let expiresAt = timeNow;
            let hasExpired = true;
            let session = null;
            const { payload } = (0, helpers_1.decodeJWT)(currentSession.access_token);
            if (payload.exp) {
                expiresAt = payload.exp;
                hasExpired = expiresAt <= timeNow;
            }
            if (hasExpired) {
                const { data: refreshedSession, error } = await this._callRefreshToken(currentSession.refresh_token);
                if (error) {
                    return this._returnResult({ data: { user: null, session: null }, error: error });
                }
                if (!refreshedSession) {
                    return { data: { user: null, session: null }, error: null };
                }
                session = refreshedSession;
            }
            else {
                const { data, error } = await this._getUser(currentSession.access_token);
                if (error) {
                    return this._returnResult({ data: { user: null, session: null }, error });
                }
                session = {
                    access_token: currentSession.access_token,
                    refresh_token: currentSession.refresh_token,
                    user: data.user,
                    token_type: 'bearer',
                    expires_in: expiresAt - timeNow,
                    expires_at: expiresAt,
                };
                await this._saveSession(session);
                await this._notifyAllSubscribers('SIGNED_IN', session);
            }
            return this._returnResult({ data: { user: session.user, session }, error: null });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: { session: null, user: null }, error });
            }
            throw error;
        }
    }
    /**
     * Returns a new session, regardless of expiry status.
     * Takes in an optional current session. If not passed in, then refreshSession() will attempt to retrieve it from getSession().
     * If the current session's refresh token is invalid, an error will be thrown.
     * @param currentSession The current session. If passed in, it must contain a refresh token.
     */
    async refreshSession(currentSession) {
        await this.initializePromise;
        return await this._acquireLock(this.lockAcquireTimeout, async () => {
            return await this._refreshSession(currentSession);
        });
    }
    async _refreshSession(currentSession) {
        try {
            return await this._useSession(async (result) => {
                var _a;
                if (!currentSession) {
                    const { data, error } = result;
                    if (error) {
                        throw error;
                    }
                    currentSession = (_a = data.session) !== null && _a !== void 0 ? _a : undefined;
                }
                if (!(currentSession === null || currentSession === void 0 ? void 0 : currentSession.refresh_token)) {
                    throw new errors_1.AuthSessionMissingError();
                }
                const { data: session, error } = await this._callRefreshToken(currentSession.refresh_token);
                if (error) {
                    return this._returnResult({ data: { user: null, session: null }, error: error });
                }
                if (!session) {
                    return this._returnResult({ data: { user: null, session: null }, error: null });
                }
                return this._returnResult({ data: { user: session.user, session }, error: null });
            });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: { user: null, session: null }, error });
            }
            throw error;
        }
    }
    /**
     * Gets the session data from a URL string
     */
    async _getSessionFromURL(params, callbackUrlType) {
        try {
            if (!(0, helpers_1.isBrowser)())
                throw new errors_1.AuthImplicitGrantRedirectError('No browser detected.');
            // If there's an error in the URL, it doesn't matter what flow it is, we just return the error.
            if (params.error || params.error_description || params.error_code) {
                // The error class returned implies that the redirect is from an implicit grant flow
                // but it could also be from a redirect error from a PKCE flow.
                throw new errors_1.AuthImplicitGrantRedirectError(params.error_description || 'Error in URL with unspecified error_description', {
                    error: params.error || 'unspecified_error',
                    code: params.error_code || 'unspecified_code',
                });
            }
            // Checks for mismatches between the flowType initialised in the client and the URL parameters
            switch (callbackUrlType) {
                case 'implicit':
                    if (this.flowType === 'pkce') {
                        throw new errors_1.AuthPKCEGrantCodeExchangeError('Not a valid PKCE flow url.');
                    }
                    break;
                case 'pkce':
                    if (this.flowType === 'implicit') {
                        throw new errors_1.AuthImplicitGrantRedirectError('Not a valid implicit grant flow url.');
                    }
                    break;
                default:
                // there's no mismatch so we continue
            }
            // Since this is a redirect for PKCE, we attempt to retrieve the code from the URL for the code exchange
            if (callbackUrlType === 'pkce') {
                this._debug('#_initialize()', 'begin', 'is PKCE flow', true);
                if (!params.code)
                    throw new errors_1.AuthPKCEGrantCodeExchangeError('No code detected.');
                const { data, error } = await this._exchangeCodeForSession(params.code);
                if (error)
                    throw error;
                const url = new URL(window.location.href);
                url.searchParams.delete('code');
                window.history.replaceState(window.history.state, '', url.toString());
                return { data: { session: data.session, redirectType: null }, error: null };
            }
            const { provider_token, provider_refresh_token, access_token, refresh_token, expires_in, expires_at, token_type, } = params;
            if (!access_token || !expires_in || !refresh_token || !token_type) {
                throw new errors_1.AuthImplicitGrantRedirectError('No session defined in URL');
            }
            const timeNow = Math.round(Date.now() / 1000);
            const expiresIn = parseInt(expires_in);
            let expiresAt = timeNow + expiresIn;
            if (expires_at) {
                expiresAt = parseInt(expires_at);
            }
            const actuallyExpiresIn = expiresAt - timeNow;
            if (actuallyExpiresIn * 1000 <= constants_1.AUTO_REFRESH_TICK_DURATION_MS) {
                console.warn(`@supabase/gotrue-js: Session as retrieved from URL expires in ${actuallyExpiresIn}s, should have been closer to ${expiresIn}s`);
            }
            const issuedAt = expiresAt - expiresIn;
            if (timeNow - issuedAt >= 120) {
                console.warn('@supabase/gotrue-js: Session as retrieved from URL was issued over 120s ago, URL could be stale', issuedAt, expiresAt, timeNow);
            }
            else if (timeNow - issuedAt < 0) {
                console.warn('@supabase/gotrue-js: Session as retrieved from URL was issued in the future? Check the device clock for skew', issuedAt, expiresAt, timeNow);
            }
            const { data, error } = await this._getUser(access_token);
            if (error)
                throw error;
            const session = {
                provider_token,
                provider_refresh_token,
                access_token,
                expires_in: expiresIn,
                expires_at: expiresAt,
                refresh_token,
                token_type: token_type,
                user: data.user,
            };
            // Remove tokens from URL
            window.location.hash = '';
            this._debug('#_getSessionFromURL()', 'clearing window.location.hash');
            return this._returnResult({ data: { session, redirectType: params.type }, error: null });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: { session: null, redirectType: null }, error });
            }
            throw error;
        }
    }
    /**
     * Checks if the current URL contains parameters given by an implicit oauth grant flow (https://www.rfc-editor.org/rfc/rfc6749.html#section-4.2)
     *
     * If `detectSessionInUrl` is a function, it will be called with the URL and params to determine
     * if the URL should be processed as a Supabase auth callback. This allows users to exclude
     * URLs from other OAuth providers (e.g., Facebook Login) that also return access_token in the fragment.
     */
    _isImplicitGrantCallback(params) {
        if (typeof this.detectSessionInUrl === 'function') {
            return this.detectSessionInUrl(new URL(window.location.href), params);
        }
        return Boolean(params.access_token || params.error_description);
    }
    /**
     * Checks if the current URL and backing storage contain parameters given by a PKCE flow
     */
    async _isPKCECallback(params) {
        const currentStorageContent = await (0, helpers_1.getItemAsync)(this.storage, `${this.storageKey}-code-verifier`);
        return !!(params.code && currentStorageContent);
    }
    /**
     * Inside a browser context, `signOut()` will remove the logged in user from the browser session and log them out - removing all items from localstorage and then trigger a `"SIGNED_OUT"` event.
     *
     * For server-side management, you can revoke all refresh tokens for a user by passing a user's JWT through to `auth.api.signOut(JWT: string)`.
     * There is no way to revoke a user's access token jwt until it expires. It is recommended to set a shorter expiry on the jwt for this reason.
     *
     * If using `others` scope, no `SIGNED_OUT` event is fired!
     */
    async signOut(options = { scope: 'global' }) {
        await this.initializePromise;
        return await this._acquireLock(this.lockAcquireTimeout, async () => {
            return await this._signOut(options);
        });
    }
    async _signOut({ scope } = { scope: 'global' }) {
        return await this._useSession(async (result) => {
            var _a;
            const { data, error: sessionError } = result;
            if (sessionError && !(0, errors_1.isAuthSessionMissingError)(sessionError)) {
                return this._returnResult({ error: sessionError });
            }
            const accessToken = (_a = data.session) === null || _a === void 0 ? void 0 : _a.access_token;
            if (accessToken) {
                const { error } = await this.admin.signOut(accessToken, scope);
                if (error) {
                    // ignore 404s since user might not exist anymore
                    // ignore 401s since an invalid or expired JWT should sign out the current session
                    if (!(((0, errors_1.isAuthApiError)(error) &&
                        (error.status === 404 || error.status === 401 || error.status === 403)) ||
                        (0, errors_1.isAuthSessionMissingError)(error))) {
                        return this._returnResult({ error });
                    }
                }
            }
            if (scope !== 'others') {
                await this._removeSession();
                await (0, helpers_1.removeItemAsync)(this.storage, `${this.storageKey}-code-verifier`);
            }
            return this._returnResult({ error: null });
        });
    }
    onAuthStateChange(callback) {
        const id = (0, helpers_1.generateCallbackId)();
        const subscription = {
            id,
            callback,
            unsubscribe: () => {
                this._debug('#unsubscribe()', 'state change callback with id removed', id);
                this.stateChangeEmitters.delete(id);
            },
        };
        this._debug('#onAuthStateChange()', 'registered callback with id', id);
        this.stateChangeEmitters.set(id, subscription);
        (async () => {
            await this.initializePromise;
            await this._acquireLock(this.lockAcquireTimeout, async () => {
                this._emitInitialSession(id);
            });
        })();
        return { data: { subscription } };
    }
    async _emitInitialSession(id) {
        return await this._useSession(async (result) => {
            var _a, _b;
            try {
                const { data: { session }, error, } = result;
                if (error)
                    throw error;
                await ((_a = this.stateChangeEmitters.get(id)) === null || _a === void 0 ? void 0 : _a.callback('INITIAL_SESSION', session));
                this._debug('INITIAL_SESSION', 'callback id', id, 'session', session);
            }
            catch (err) {
                await ((_b = this.stateChangeEmitters.get(id)) === null || _b === void 0 ? void 0 : _b.callback('INITIAL_SESSION', null));
                this._debug('INITIAL_SESSION', 'callback id', id, 'error', err);
                console.error(err);
            }
        });
    }
    /**
     * Sends a password reset request to an email address. This method supports the PKCE flow.
     *
     * @param email The email address of the user.
     * @param options.redirectTo The URL to send the user to after they click the password reset link.
     * @param options.captchaToken Verification token received when the user completes the captcha on the site.
     */
    async resetPasswordForEmail(email, options = {}) {
        let codeChallenge = null;
        let codeChallengeMethod = null;
        if (this.flowType === 'pkce') {
            ;
            [codeChallenge, codeChallengeMethod] = await (0, helpers_1.getCodeChallengeAndMethod)(this.storage, this.storageKey, true // isPasswordRecovery
            );
        }
        try {
            return await (0, fetch_1._request)(this.fetch, 'POST', `${this.url}/recover`, {
                body: {
                    email,
                    code_challenge: codeChallenge,
                    code_challenge_method: codeChallengeMethod,
                    gotrue_meta_security: { captcha_token: options.captchaToken },
                },
                headers: this.headers,
                redirectTo: options.redirectTo,
            });
        }
        catch (error) {
            await (0, helpers_1.removeItemAsync)(this.storage, `${this.storageKey}-code-verifier`);
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: null, error });
            }
            throw error;
        }
    }
    /**
     * Gets all the identities linked to a user.
     */
    async getUserIdentities() {
        var _a;
        try {
            const { data, error } = await this.getUser();
            if (error)
                throw error;
            return this._returnResult({ data: { identities: (_a = data.user.identities) !== null && _a !== void 0 ? _a : [] }, error: null });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: null, error });
            }
            throw error;
        }
    }
    async linkIdentity(credentials) {
        if ('token' in credentials) {
            return this.linkIdentityIdToken(credentials);
        }
        return this.linkIdentityOAuth(credentials);
    }
    async linkIdentityOAuth(credentials) {
        var _a;
        try {
            const { data, error } = await this._useSession(async (result) => {
                var _a, _b, _c, _d, _e;
                const { data, error } = result;
                if (error)
                    throw error;
                const url = await this._getUrlForProvider(`${this.url}/user/identities/authorize`, credentials.provider, {
                    redirectTo: (_a = credentials.options) === null || _a === void 0 ? void 0 : _a.redirectTo,
                    scopes: (_b = credentials.options) === null || _b === void 0 ? void 0 : _b.scopes,
                    queryParams: (_c = credentials.options) === null || _c === void 0 ? void 0 : _c.queryParams,
                    skipBrowserRedirect: true,
                });
                return await (0, fetch_1._request)(this.fetch, 'GET', url, {
                    headers: this.headers,
                    jwt: (_e = (_d = data.session) === null || _d === void 0 ? void 0 : _d.access_token) !== null && _e !== void 0 ? _e : undefined,
                });
            });
            if (error)
                throw error;
            if ((0, helpers_1.isBrowser)() && !((_a = credentials.options) === null || _a === void 0 ? void 0 : _a.skipBrowserRedirect)) {
                window.location.assign(data === null || data === void 0 ? void 0 : data.url);
            }
            return this._returnResult({
                data: { provider: credentials.provider, url: data === null || data === void 0 ? void 0 : data.url },
                error: null,
            });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: { provider: credentials.provider, url: null }, error });
            }
            throw error;
        }
    }
    async linkIdentityIdToken(credentials) {
        return await this._useSession(async (result) => {
            var _a;
            try {
                const { error: sessionError, data: { session }, } = result;
                if (sessionError)
                    throw sessionError;
                const { options, provider, token, access_token, nonce } = credentials;
                const res = await (0, fetch_1._request)(this.fetch, 'POST', `${this.url}/token?grant_type=id_token`, {
                    headers: this.headers,
                    jwt: (_a = session === null || session === void 0 ? void 0 : session.access_token) !== null && _a !== void 0 ? _a : undefined,
                    body: {
                        provider,
                        id_token: token,
                        access_token,
                        nonce,
                        link_identity: true,
                        gotrue_meta_security: { captcha_token: options === null || options === void 0 ? void 0 : options.captchaToken },
                    },
                    xform: fetch_1._sessionResponse,
                });
                const { data, error } = res;
                if (error) {
                    return this._returnResult({ data: { user: null, session: null }, error });
                }
                else if (!data || !data.session || !data.user) {
                    return this._returnResult({
                        data: { user: null, session: null },
                        error: new errors_1.AuthInvalidTokenResponseError(),
                    });
                }
                if (data.session) {
                    await this._saveSession(data.session);
                    await this._notifyAllSubscribers('USER_UPDATED', data.session);
                }
                return this._returnResult({ data, error });
            }
            catch (error) {
                await (0, helpers_1.removeItemAsync)(this.storage, `${this.storageKey}-code-verifier`);
                if ((0, errors_1.isAuthError)(error)) {
                    return this._returnResult({ data: { user: null, session: null }, error });
                }
                throw error;
            }
        });
    }
    /**
     * Unlinks an identity from a user by deleting it. The user will no longer be able to sign in with that identity once it's unlinked.
     */
    async unlinkIdentity(identity) {
        try {
            return await this._useSession(async (result) => {
                var _a, _b;
                const { data, error } = result;
                if (error) {
                    throw error;
                }
                return await (0, fetch_1._request)(this.fetch, 'DELETE', `${this.url}/user/identities/${identity.identity_id}`, {
                    headers: this.headers,
                    jwt: (_b = (_a = data.session) === null || _a === void 0 ? void 0 : _a.access_token) !== null && _b !== void 0 ? _b : undefined,
                });
            });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: null, error });
            }
            throw error;
        }
    }
    /**
     * Generates a new JWT.
     * @param refreshToken A valid refresh token that was returned on login.
     */
    async _refreshAccessToken(refreshToken) {
        const debugName = `#_refreshAccessToken(${refreshToken.substring(0, 5)}...)`;
        this._debug(debugName, 'begin');
        try {
            const startedAt = Date.now();
            // will attempt to refresh the token with exponential backoff
            return await (0, helpers_1.retryable)(async (attempt) => {
                if (attempt > 0) {
                    await (0, helpers_1.sleep)(200 * Math.pow(2, attempt - 1)); // 200, 400, 800, ...
                }
                this._debug(debugName, 'refreshing attempt', attempt);
                return await (0, fetch_1._request)(this.fetch, 'POST', `${this.url}/token?grant_type=refresh_token`, {
                    body: { refresh_token: refreshToken },
                    headers: this.headers,
                    xform: fetch_1._sessionResponse,
                });
            }, (attempt, error) => {
                const nextBackOffInterval = 200 * Math.pow(2, attempt);
                return (error &&
                    (0, errors_1.isAuthRetryableFetchError)(error) &&
                    // retryable only if the request can be sent before the backoff overflows the tick duration
                    Date.now() + nextBackOffInterval - startedAt < constants_1.AUTO_REFRESH_TICK_DURATION_MS);
            });
        }
        catch (error) {
            this._debug(debugName, 'error', error);
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: { session: null, user: null }, error });
            }
            throw error;
        }
        finally {
            this._debug(debugName, 'end');
        }
    }
    _isValidSession(maybeSession) {
        const isValidSession = typeof maybeSession === 'object' &&
            maybeSession !== null &&
            'access_token' in maybeSession &&
            'refresh_token' in maybeSession &&
            'expires_at' in maybeSession;
        return isValidSession;
    }
    async _handleProviderSignIn(provider, options) {
        const url = await this._getUrlForProvider(`${this.url}/authorize`, provider, {
            redirectTo: options.redirectTo,
            scopes: options.scopes,
            queryParams: options.queryParams,
        });
        this._debug('#_handleProviderSignIn()', 'provider', provider, 'options', options, 'url', url);
        // try to open on the browser
        if ((0, helpers_1.isBrowser)() && !options.skipBrowserRedirect) {
            window.location.assign(url);
        }
        return { data: { provider, url }, error: null };
    }
    /**
     * Recovers the session from LocalStorage and refreshes the token
     * Note: this method is async to accommodate for AsyncStorage e.g. in React native.
     */
    async _recoverAndRefresh() {
        var _a, _b;
        const debugName = '#_recoverAndRefresh()';
        this._debug(debugName, 'begin');
        try {
            const currentSession = (await (0, helpers_1.getItemAsync)(this.storage, this.storageKey));
            if (currentSession && this.userStorage) {
                let maybeUser = (await (0, helpers_1.getItemAsync)(this.userStorage, this.storageKey + '-user'));
                if (!this.storage.isServer && Object.is(this.storage, this.userStorage) && !maybeUser) {
                    // storage and userStorage are the same storage medium, for example
                    // window.localStorage if userStorage does not have the user from
                    // storage stored, store it first thereby migrating the user object
                    // from storage -> userStorage
                    maybeUser = { user: currentSession.user };
                    await (0, helpers_1.setItemAsync)(this.userStorage, this.storageKey + '-user', maybeUser);
                }
                currentSession.user = (_a = maybeUser === null || maybeUser === void 0 ? void 0 : maybeUser.user) !== null && _a !== void 0 ? _a : (0, helpers_1.userNotAvailableProxy)();
            }
            else if (currentSession && !currentSession.user) {
                // user storage is not set, let's check if it was previously enabled so
                // we bring back the storage as it should be
                if (!currentSession.user) {
                    // test if userStorage was previously enabled and the storage medium was the same, to move the user back under the same key
                    const separateUser = (await (0, helpers_1.getItemAsync)(this.storage, this.storageKey + '-user'));
                    if (separateUser && (separateUser === null || separateUser === void 0 ? void 0 : separateUser.user)) {
                        currentSession.user = separateUser.user;
                        await (0, helpers_1.removeItemAsync)(this.storage, this.storageKey + '-user');
                        await (0, helpers_1.setItemAsync)(this.storage, this.storageKey, currentSession);
                    }
                    else {
                        currentSession.user = (0, helpers_1.userNotAvailableProxy)();
                    }
                }
            }
            this._debug(debugName, 'session from storage', currentSession);
            if (!this._isValidSession(currentSession)) {
                this._debug(debugName, 'session is not valid');
                if (currentSession !== null) {
                    await this._removeSession();
                }
                return;
            }
            const expiresWithMargin = ((_b = currentSession.expires_at) !== null && _b !== void 0 ? _b : Infinity) * 1000 - Date.now() < constants_1.EXPIRY_MARGIN_MS;
            this._debug(debugName, `session has${expiresWithMargin ? '' : ' not'} expired with margin of ${constants_1.EXPIRY_MARGIN_MS}s`);
            if (expiresWithMargin) {
                if (this.autoRefreshToken && currentSession.refresh_token) {
                    const { error } = await this._callRefreshToken(currentSession.refresh_token);
                    if (error) {
                        console.error(error);
                        if (!(0, errors_1.isAuthRetryableFetchError)(error)) {
                            this._debug(debugName, 'refresh failed with a non-retryable error, removing the session', error);
                            await this._removeSession();
                        }
                    }
                }
            }
            else if (currentSession.user &&
                currentSession.user.__isUserNotAvailableProxy === true) {
                // If we have a proxy user, try to get the real user data
                try {
                    const { data, error: userError } = await this._getUser(currentSession.access_token);
                    if (!userError && (data === null || data === void 0 ? void 0 : data.user)) {
                        currentSession.user = data.user;
                        await this._saveSession(currentSession);
                        await this._notifyAllSubscribers('SIGNED_IN', currentSession);
                    }
                    else {
                        this._debug(debugName, 'could not get user data, skipping SIGNED_IN notification');
                    }
                }
                catch (getUserError) {
                    console.error('Error getting user data:', getUserError);
                    this._debug(debugName, 'error getting user data, skipping SIGNED_IN notification', getUserError);
                }
            }
            else {
                // no need to persist currentSession again, as we just loaded it from
                // local storage; persisting it again may overwrite a value saved by
                // another client with access to the same local storage
                await this._notifyAllSubscribers('SIGNED_IN', currentSession);
            }
        }
        catch (err) {
            this._debug(debugName, 'error', err);
            console.error(err);
            return;
        }
        finally {
            this._debug(debugName, 'end');
        }
    }
    async _callRefreshToken(refreshToken) {
        var _a, _b;
        if (!refreshToken) {
            throw new errors_1.AuthSessionMissingError();
        }
        // refreshing is already in progress
        if (this.refreshingDeferred) {
            return this.refreshingDeferred.promise;
        }
        const debugName = `#_callRefreshToken(${refreshToken.substring(0, 5)}...)`;
        this._debug(debugName, 'begin');
        try {
            this.refreshingDeferred = new helpers_1.Deferred();
            const { data, error } = await this._refreshAccessToken(refreshToken);
            if (error)
                throw error;
            if (!data.session)
                throw new errors_1.AuthSessionMissingError();
            await this._saveSession(data.session);
            await this._notifyAllSubscribers('TOKEN_REFRESHED', data.session);
            const result = { data: data.session, error: null };
            this.refreshingDeferred.resolve(result);
            return result;
        }
        catch (error) {
            this._debug(debugName, 'error', error);
            if ((0, errors_1.isAuthError)(error)) {
                const result = { data: null, error };
                if (!(0, errors_1.isAuthRetryableFetchError)(error)) {
                    await this._removeSession();
                }
                (_a = this.refreshingDeferred) === null || _a === void 0 ? void 0 : _a.resolve(result);
                return result;
            }
            (_b = this.refreshingDeferred) === null || _b === void 0 ? void 0 : _b.reject(error);
            throw error;
        }
        finally {
            this.refreshingDeferred = null;
            this._debug(debugName, 'end');
        }
    }
    async _notifyAllSubscribers(event, session, broadcast = true) {
        const debugName = `#_notifyAllSubscribers(${event})`;
        this._debug(debugName, 'begin', session, `broadcast = ${broadcast}`);
        try {
            if (this.broadcastChannel && broadcast) {
                this.broadcastChannel.postMessage({ event, session });
            }
            const errors = [];
            const promises = Array.from(this.stateChangeEmitters.values()).map(async (x) => {
                try {
                    await x.callback(event, session);
                }
                catch (e) {
                    errors.push(e);
                }
            });
            await Promise.all(promises);
            if (errors.length > 0) {
                for (let i = 0; i < errors.length; i += 1) {
                    console.error(errors[i]);
                }
                throw errors[0];
            }
        }
        finally {
            this._debug(debugName, 'end');
        }
    }
    /**
     * set currentSession and currentUser
     * process to _startAutoRefreshToken if possible
     */
    async _saveSession(session) {
        this._debug('#_saveSession()', session);
        // _saveSession is always called whenever a new session has been acquired
        // so we can safely suppress the warning returned by future getSession calls
        this.suppressGetSessionWarning = true;
        await (0, helpers_1.removeItemAsync)(this.storage, `${this.storageKey}-code-verifier`);
        // Create a shallow copy to work with, to avoid mutating the original session object if it's used elsewhere
        const sessionToProcess = Object.assign({}, session);
        const userIsProxy = sessionToProcess.user && sessionToProcess.user.__isUserNotAvailableProxy === true;
        if (this.userStorage) {
            if (!userIsProxy && sessionToProcess.user) {
                // If it's a real user object, save it to userStorage.
                await (0, helpers_1.setItemAsync)(this.userStorage, this.storageKey + '-user', {
                    user: sessionToProcess.user,
                });
            }
            else if (userIsProxy) {
                // If it's the proxy, it means user was not found in userStorage.
                // We should ensure no stale user data for this key exists in userStorage if we were to save null,
                // or simply not save the proxy. For now, we don't save the proxy here.
                // If there's a need to clear userStorage if user becomes proxy, that logic would go here.
            }
            // Prepare the main session data for primary storage: remove the user property before cloning
            // This is important because the original session.user might be the proxy
            const mainSessionData = Object.assign({}, sessionToProcess);
            delete mainSessionData.user; // Remove user (real or proxy) before cloning for main storage
            const clonedMainSessionData = (0, helpers_1.deepClone)(mainSessionData);
            await (0, helpers_1.setItemAsync)(this.storage, this.storageKey, clonedMainSessionData);
        }
        else {
            // No userStorage is configured.
            // In this case, session.user should ideally not be a proxy.
            // If it were, structuredClone would fail. This implies an issue elsewhere if user is a proxy here
            const clonedSession = (0, helpers_1.deepClone)(sessionToProcess); // sessionToProcess still has its original user property
            await (0, helpers_1.setItemAsync)(this.storage, this.storageKey, clonedSession);
        }
    }
    async _removeSession() {
        this._debug('#_removeSession()');
        this.suppressGetSessionWarning = false;
        await (0, helpers_1.removeItemAsync)(this.storage, this.storageKey);
        await (0, helpers_1.removeItemAsync)(this.storage, this.storageKey + '-code-verifier');
        await (0, helpers_1.removeItemAsync)(this.storage, this.storageKey + '-user');
        if (this.userStorage) {
            await (0, helpers_1.removeItemAsync)(this.userStorage, this.storageKey + '-user');
        }
        await this._notifyAllSubscribers('SIGNED_OUT', null);
    }
    /**
     * Removes any registered visibilitychange callback.
     *
     * {@see #startAutoRefresh}
     * {@see #stopAutoRefresh}
     */
    _removeVisibilityChangedCallback() {
        this._debug('#_removeVisibilityChangedCallback()');
        const callback = this.visibilityChangedCallback;
        this.visibilityChangedCallback = null;
        try {
            if (callback && (0, helpers_1.isBrowser)() && (window === null || window === void 0 ? void 0 : window.removeEventListener)) {
                window.removeEventListener('visibilitychange', callback);
            }
        }
        catch (e) {
            console.error('removing visibilitychange callback failed', e);
        }
    }
    /**
     * This is the private implementation of {@link #startAutoRefresh}. Use this
     * within the library.
     */
    async _startAutoRefresh() {
        await this._stopAutoRefresh();
        this._debug('#_startAutoRefresh()');
        const ticker = setInterval(() => this._autoRefreshTokenTick(), constants_1.AUTO_REFRESH_TICK_DURATION_MS);
        this.autoRefreshTicker = ticker;
        if (ticker && typeof ticker === 'object' && typeof ticker.unref === 'function') {
            // ticker is a NodeJS Timeout object that has an `unref` method
            // https://nodejs.org/api/timers.html#timeoutunref
            // When auto refresh is used in NodeJS (like for testing) the
            // `setInterval` is preventing the process from being marked as
            // finished and tests run endlessly. This can be prevented by calling
            // `unref()` on the returned object.
            ticker.unref();
            // @ts-expect-error TS has no context of Deno
        }
        else if (typeof Deno !== 'undefined' && typeof Deno.unrefTimer === 'function') {
            // similar like for NodeJS, but with the Deno API
            // https://deno.land/api@latest?unstable&s=Deno.unrefTimer
            // @ts-expect-error TS has no context of Deno
            Deno.unrefTimer(ticker);
        }
        // run the tick immediately, but in the next pass of the event loop so that
        // #_initialize can be allowed to complete without recursively waiting on
        // itself
        const timeout = setTimeout(async () => {
            await this.initializePromise;
            await this._autoRefreshTokenTick();
        }, 0);
        this.autoRefreshTickTimeout = timeout;
        if (timeout && typeof timeout === 'object' && typeof timeout.unref === 'function') {
            timeout.unref();
            // @ts-expect-error TS has no context of Deno
        }
        else if (typeof Deno !== 'undefined' && typeof Deno.unrefTimer === 'function') {
            // @ts-expect-error TS has no context of Deno
            Deno.unrefTimer(timeout);
        }
    }
    /**
     * This is the private implementation of {@link #stopAutoRefresh}. Use this
     * within the library.
     */
    async _stopAutoRefresh() {
        this._debug('#_stopAutoRefresh()');
        const ticker = this.autoRefreshTicker;
        this.autoRefreshTicker = null;
        if (ticker) {
            clearInterval(ticker);
        }
        const timeout = this.autoRefreshTickTimeout;
        this.autoRefreshTickTimeout = null;
        if (timeout) {
            clearTimeout(timeout);
        }
    }
    /**
     * Starts an auto-refresh process in the background. The session is checked
     * every few seconds. Close to the time of expiration a process is started to
     * refresh the session. If refreshing fails it will be retried for as long as
     * necessary.
     *
     * If you set the {@link GoTrueClientOptions#autoRefreshToken} you don't need
     * to call this function, it will be called for you.
     *
     * On browsers the refresh process works only when the tab/window is in the
     * foreground to conserve resources as well as prevent race conditions and
     * flooding auth with requests. If you call this method any managed
     * visibility change callback will be removed and you must manage visibility
     * changes on your own.
     *
     * On non-browser platforms the refresh process works *continuously* in the
     * background, which may not be desirable. You should hook into your
     * platform's foreground indication mechanism and call these methods
     * appropriately to conserve resources.
     *
     * {@see #stopAutoRefresh}
     */
    async startAutoRefresh() {
        this._removeVisibilityChangedCallback();
        await this._startAutoRefresh();
    }
    /**
     * Stops an active auto refresh process running in the background (if any).
     *
     * If you call this method any managed visibility change callback will be
     * removed and you must manage visibility changes on your own.
     *
     * See {@link #startAutoRefresh} for more details.
     */
    async stopAutoRefresh() {
        this._removeVisibilityChangedCallback();
        await this._stopAutoRefresh();
    }
    /**
     * Runs the auto refresh token tick.
     */
    async _autoRefreshTokenTick() {
        this._debug('#_autoRefreshTokenTick()', 'begin');
        try {
            await this._acquireLock(0, async () => {
                try {
                    const now = Date.now();
                    try {
                        return await this._useSession(async (result) => {
                            const { data: { session }, } = result;
                            if (!session || !session.refresh_token || !session.expires_at) {
                                this._debug('#_autoRefreshTokenTick()', 'no session');
                                return;
                            }
                            // session will expire in this many ticks (or has already expired if <= 0)
                            const expiresInTicks = Math.floor((session.expires_at * 1000 - now) / constants_1.AUTO_REFRESH_TICK_DURATION_MS);
                            this._debug('#_autoRefreshTokenTick()', `access token expires in ${expiresInTicks} ticks, a tick lasts ${constants_1.AUTO_REFRESH_TICK_DURATION_MS}ms, refresh threshold is ${constants_1.AUTO_REFRESH_TICK_THRESHOLD} ticks`);
                            if (expiresInTicks <= constants_1.AUTO_REFRESH_TICK_THRESHOLD) {
                                await this._callRefreshToken(session.refresh_token);
                            }
                        });
                    }
                    catch (e) {
                        console.error('Auto refresh tick failed with error. This is likely a transient error.', e);
                    }
                }
                finally {
                    this._debug('#_autoRefreshTokenTick()', 'end');
                }
            });
        }
        catch (e) {
            if (e.isAcquireTimeout || e instanceof locks_1.LockAcquireTimeoutError) {
                this._debug('auto refresh token tick lock not available');
            }
            else {
                throw e;
            }
        }
    }
    /**
     * Registers callbacks on the browser / platform, which in-turn run
     * algorithms when the browser window/tab are in foreground. On non-browser
     * platforms it assumes always foreground.
     */
    async _handleVisibilityChange() {
        this._debug('#_handleVisibilityChange()');
        if (!(0, helpers_1.isBrowser)() || !(window === null || window === void 0 ? void 0 : window.addEventListener)) {
            if (this.autoRefreshToken) {
                // in non-browser environments the refresh token ticker runs always
                this.startAutoRefresh();
            }
            return false;
        }
        try {
            this.visibilityChangedCallback = async () => {
                try {
                    await this._onVisibilityChanged(false);
                }
                catch (error) {
                    this._debug('#visibilityChangedCallback', 'error', error);
                }
            };
            window === null || window === void 0 ? void 0 : window.addEventListener('visibilitychange', this.visibilityChangedCallback);
            // now immediately call the visbility changed callback to setup with the
            // current visbility state
            await this._onVisibilityChanged(true); // initial call
        }
        catch (error) {
            console.error('_handleVisibilityChange', error);
        }
    }
    /**
     * Callback registered with `window.addEventListener('visibilitychange')`.
     */
    async _onVisibilityChanged(calledFromInitialize) {
        const methodName = `#_onVisibilityChanged(${calledFromInitialize})`;
        this._debug(methodName, 'visibilityState', document.visibilityState);
        if (document.visibilityState === 'visible') {
            if (this.autoRefreshToken) {
                // in browser environments the refresh token ticker runs only on focused tabs
                // which prevents race conditions
                this._startAutoRefresh();
            }
            if (!calledFromInitialize) {
                // called when the visibility has changed, i.e. the browser
                // transitioned from hidden -> visible so we need to see if the session
                // should be recovered immediately... but to do that we need to acquire
                // the lock first asynchronously
                await this.initializePromise;
                await this._acquireLock(this.lockAcquireTimeout, async () => {
                    if (document.visibilityState !== 'visible') {
                        this._debug(methodName, 'acquired the lock to recover the session, but the browser visibilityState is no longer visible, aborting');
                        // visibility has changed while waiting for the lock, abort
                        return;
                    }
                    // recover the session
                    await this._recoverAndRefresh();
                });
            }
        }
        else if (document.visibilityState === 'hidden') {
            if (this.autoRefreshToken) {
                this._stopAutoRefresh();
            }
        }
    }
    /**
     * Generates the relevant login URL for a third-party provider.
     * @param options.redirectTo A URL or mobile address to send the user to after they are confirmed.
     * @param options.scopes A space-separated list of scopes granted to the OAuth application.
     * @param options.queryParams An object of key-value pairs containing query parameters granted to the OAuth application.
     */
    async _getUrlForProvider(url, provider, options) {
        const urlParams = [`provider=${encodeURIComponent(provider)}`];
        if (options === null || options === void 0 ? void 0 : options.redirectTo) {
            urlParams.push(`redirect_to=${encodeURIComponent(options.redirectTo)}`);
        }
        if (options === null || options === void 0 ? void 0 : options.scopes) {
            urlParams.push(`scopes=${encodeURIComponent(options.scopes)}`);
        }
        if (this.flowType === 'pkce') {
            const [codeChallenge, codeChallengeMethod] = await (0, helpers_1.getCodeChallengeAndMethod)(this.storage, this.storageKey);
            const flowParams = new URLSearchParams({
                code_challenge: `${encodeURIComponent(codeChallenge)}`,
                code_challenge_method: `${encodeURIComponent(codeChallengeMethod)}`,
            });
            urlParams.push(flowParams.toString());
        }
        if (options === null || options === void 0 ? void 0 : options.queryParams) {
            const query = new URLSearchParams(options.queryParams);
            urlParams.push(query.toString());
        }
        if (options === null || options === void 0 ? void 0 : options.skipBrowserRedirect) {
            urlParams.push(`skip_http_redirect=${options.skipBrowserRedirect}`);
        }
        return `${url}?${urlParams.join('&')}`;
    }
    async _unenroll(params) {
        try {
            return await this._useSession(async (result) => {
                var _a;
                const { data: sessionData, error: sessionError } = result;
                if (sessionError) {
                    return this._returnResult({ data: null, error: sessionError });
                }
                return await (0, fetch_1._request)(this.fetch, 'DELETE', `${this.url}/factors/${params.factorId}`, {
                    headers: this.headers,
                    jwt: (_a = sessionData === null || sessionData === void 0 ? void 0 : sessionData.session) === null || _a === void 0 ? void 0 : _a.access_token,
                });
            });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: null, error });
            }
            throw error;
        }
    }
    async _enroll(params) {
        try {
            return await this._useSession(async (result) => {
                var _a, _b;
                const { data: sessionData, error: sessionError } = result;
                if (sessionError) {
                    return this._returnResult({ data: null, error: sessionError });
                }
                const body = Object.assign({ friendly_name: params.friendlyName, factor_type: params.factorType }, (params.factorType === 'phone'
                    ? { phone: params.phone }
                    : params.factorType === 'totp'
                        ? { issuer: params.issuer }
                        : {}));
                const { data, error } = (await (0, fetch_1._request)(this.fetch, 'POST', `${this.url}/factors`, {
                    body,
                    headers: this.headers,
                    jwt: (_a = sessionData === null || sessionData === void 0 ? void 0 : sessionData.session) === null || _a === void 0 ? void 0 : _a.access_token,
                }));
                if (error) {
                    return this._returnResult({ data: null, error });
                }
                if (params.factorType === 'totp' && data.type === 'totp' && ((_b = data === null || data === void 0 ? void 0 : data.totp) === null || _b === void 0 ? void 0 : _b.qr_code)) {
                    data.totp.qr_code = `data:image/svg+xml;utf-8,${data.totp.qr_code}`;
                }
                return this._returnResult({ data, error: null });
            });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: null, error });
            }
            throw error;
        }
    }
    async _verify(params) {
        return this._acquireLock(this.lockAcquireTimeout, async () => {
            try {
                return await this._useSession(async (result) => {
                    var _a;
                    const { data: sessionData, error: sessionError } = result;
                    if (sessionError) {
                        return this._returnResult({ data: null, error: sessionError });
                    }
                    const body = Object.assign({ challenge_id: params.challengeId }, ('webauthn' in params
                        ? {
                            webauthn: Object.assign(Object.assign({}, params.webauthn), { credential_response: params.webauthn.type === 'create'
                                    ? (0, webauthn_1.serializeCredentialCreationResponse)(params.webauthn.credential_response)
                                    : (0, webauthn_1.serializeCredentialRequestResponse)(params.webauthn.credential_response) }),
                        }
                        : { code: params.code }));
                    const { data, error } = await (0, fetch_1._request)(this.fetch, 'POST', `${this.url}/factors/${params.factorId}/verify`, {
                        body,
                        headers: this.headers,
                        jwt: (_a = sessionData === null || sessionData === void 0 ? void 0 : sessionData.session) === null || _a === void 0 ? void 0 : _a.access_token,
                    });
                    if (error) {
                        return this._returnResult({ data: null, error });
                    }
                    await this._saveSession(Object.assign({ expires_at: Math.round(Date.now() / 1000) + data.expires_in }, data));
                    await this._notifyAllSubscribers('MFA_CHALLENGE_VERIFIED', data);
                    return this._returnResult({ data, error });
                });
            }
            catch (error) {
                if ((0, errors_1.isAuthError)(error)) {
                    return this._returnResult({ data: null, error });
                }
                throw error;
            }
        });
    }
    async _challenge(params) {
        return this._acquireLock(this.lockAcquireTimeout, async () => {
            try {
                return await this._useSession(async (result) => {
                    var _a;
                    const { data: sessionData, error: sessionError } = result;
                    if (sessionError) {
                        return this._returnResult({ data: null, error: sessionError });
                    }
                    const response = (await (0, fetch_1._request)(this.fetch, 'POST', `${this.url}/factors/${params.factorId}/challenge`, {
                        body: params,
                        headers: this.headers,
                        jwt: (_a = sessionData === null || sessionData === void 0 ? void 0 : sessionData.session) === null || _a === void 0 ? void 0 : _a.access_token,
                    }));
                    if (response.error) {
                        return response;
                    }
                    const { data } = response;
                    if (data.type !== 'webauthn') {
                        return { data, error: null };
                    }
                    switch (data.webauthn.type) {
                        case 'create':
                            return {
                                data: Object.assign(Object.assign({}, data), { webauthn: Object.assign(Object.assign({}, data.webauthn), { credential_options: Object.assign(Object.assign({}, data.webauthn.credential_options), { publicKey: (0, webauthn_1.deserializeCredentialCreationOptions)(data.webauthn.credential_options.publicKey) }) }) }),
                                error: null,
                            };
                        case 'request':
                            return {
                                data: Object.assign(Object.assign({}, data), { webauthn: Object.assign(Object.assign({}, data.webauthn), { credential_options: Object.assign(Object.assign({}, data.webauthn.credential_options), { publicKey: (0, webauthn_1.deserializeCredentialRequestOptions)(data.webauthn.credential_options.publicKey) }) }) }),
                                error: null,
                            };
                    }
                });
            }
            catch (error) {
                if ((0, errors_1.isAuthError)(error)) {
                    return this._returnResult({ data: null, error });
                }
                throw error;
            }
        });
    }
    /**
     * {@see GoTrueMFAApi#challengeAndVerify}
     */
    async _challengeAndVerify(params) {
        // both _challenge and _verify independently acquire the lock, so no need
        // to acquire it here
        const { data: challengeData, error: challengeError } = await this._challenge({
            factorId: params.factorId,
        });
        if (challengeError) {
            return this._returnResult({ data: null, error: challengeError });
        }
        return await this._verify({
            factorId: params.factorId,
            challengeId: challengeData.id,
            code: params.code,
        });
    }
    /**
     * {@see GoTrueMFAApi#listFactors}
     */
    async _listFactors() {
        var _a;
        // use #getUser instead of #_getUser as the former acquires a lock
        const { data: { user }, error: userError, } = await this.getUser();
        if (userError) {
            return { data: null, error: userError };
        }
        const data = {
            all: [],
            phone: [],
            totp: [],
            webauthn: [],
        };
        // loop over the factors ONCE
        for (const factor of (_a = user === null || user === void 0 ? void 0 : user.factors) !== null && _a !== void 0 ? _a : []) {
            data.all.push(factor);
            if (factor.status === 'verified') {
                ;
                data[factor.factor_type].push(factor);
            }
        }
        return {
            data,
            error: null,
        };
    }
    /**
     * {@see GoTrueMFAApi#getAuthenticatorAssuranceLevel}
     */
    async _getAuthenticatorAssuranceLevel(jwt) {
        var _a, _b, _c, _d;
        if (jwt) {
            try {
                const { payload } = (0, helpers_1.decodeJWT)(jwt);
                let currentLevel = null;
                if (payload.aal) {
                    currentLevel = payload.aal;
                }
                let nextLevel = currentLevel;
                const { data: { user }, error: userError, } = await this.getUser(jwt);
                if (userError) {
                    return this._returnResult({ data: null, error: userError });
                }
                const verifiedFactors = (_b = (_a = user === null || user === void 0 ? void 0 : user.factors) === null || _a === void 0 ? void 0 : _a.filter((factor) => factor.status === 'verified')) !== null && _b !== void 0 ? _b : [];
                if (verifiedFactors.length > 0) {
                    nextLevel = 'aal2';
                }
                const currentAuthenticationMethods = payload.amr || [];
                return { data: { currentLevel, nextLevel, currentAuthenticationMethods }, error: null };
            }
            catch (error) {
                if ((0, errors_1.isAuthError)(error)) {
                    return this._returnResult({ data: null, error });
                }
                throw error;
            }
        }
        const { data: { session }, error: sessionError, } = await this.getSession();
        if (sessionError) {
            return this._returnResult({ data: null, error: sessionError });
        }
        if (!session) {
            return {
                data: { currentLevel: null, nextLevel: null, currentAuthenticationMethods: [] },
                error: null,
            };
        }
        const { payload } = (0, helpers_1.decodeJWT)(session.access_token);
        let currentLevel = null;
        if (payload.aal) {
            currentLevel = payload.aal;
        }
        let nextLevel = currentLevel;
        const verifiedFactors = (_d = (_c = session.user.factors) === null || _c === void 0 ? void 0 : _c.filter((factor) => factor.status === 'verified')) !== null && _d !== void 0 ? _d : [];
        if (verifiedFactors.length > 0) {
            nextLevel = 'aal2';
        }
        const currentAuthenticationMethods = payload.amr || [];
        return { data: { currentLevel, nextLevel, currentAuthenticationMethods }, error: null };
    }
    /**
     * Retrieves details about an OAuth authorization request.
     * Only relevant when the OAuth 2.1 server is enabled in Supabase Auth.
     *
     * Returns authorization details including client info, scopes, and user information.
     * If the response includes only a redirect_url field, it means consent was already given - the caller
     * should handle the redirect manually if needed.
     */
    async _getAuthorizationDetails(authorizationId) {
        try {
            return await this._useSession(async (result) => {
                const { data: { session }, error: sessionError, } = result;
                if (sessionError) {
                    return this._returnResult({ data: null, error: sessionError });
                }
                if (!session) {
                    return this._returnResult({ data: null, error: new errors_1.AuthSessionMissingError() });
                }
                return await (0, fetch_1._request)(this.fetch, 'GET', `${this.url}/oauth/authorizations/${authorizationId}`, {
                    headers: this.headers,
                    jwt: session.access_token,
                    xform: (data) => ({ data, error: null }),
                });
            });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: null, error });
            }
            throw error;
        }
    }
    /**
     * Approves an OAuth authorization request.
     * Only relevant when the OAuth 2.1 server is enabled in Supabase Auth.
     */
    async _approveAuthorization(authorizationId, options) {
        try {
            return await this._useSession(async (result) => {
                const { data: { session }, error: sessionError, } = result;
                if (sessionError) {
                    return this._returnResult({ data: null, error: sessionError });
                }
                if (!session) {
                    return this._returnResult({ data: null, error: new errors_1.AuthSessionMissingError() });
                }
                const response = await (0, fetch_1._request)(this.fetch, 'POST', `${this.url}/oauth/authorizations/${authorizationId}/consent`, {
                    headers: this.headers,
                    jwt: session.access_token,
                    body: { action: 'approve' },
                    xform: (data) => ({ data, error: null }),
                });
                if (response.data && response.data.redirect_url) {
                    // Automatically redirect in browser unless skipBrowserRedirect is true
                    if ((0, helpers_1.isBrowser)() && !(options === null || options === void 0 ? void 0 : options.skipBrowserRedirect)) {
                        window.location.assign(response.data.redirect_url);
                    }
                }
                return response;
            });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: null, error });
            }
            throw error;
        }
    }
    /**
     * Denies an OAuth authorization request.
     * Only relevant when the OAuth 2.1 server is enabled in Supabase Auth.
     */
    async _denyAuthorization(authorizationId, options) {
        try {
            return await this._useSession(async (result) => {
                const { data: { session }, error: sessionError, } = result;
                if (sessionError) {
                    return this._returnResult({ data: null, error: sessionError });
                }
                if (!session) {
                    return this._returnResult({ data: null, error: new errors_1.AuthSessionMissingError() });
                }
                const response = await (0, fetch_1._request)(this.fetch, 'POST', `${this.url}/oauth/authorizations/${authorizationId}/consent`, {
                    headers: this.headers,
                    jwt: session.access_token,
                    body: { action: 'deny' },
                    xform: (data) => ({ data, error: null }),
                });
                if (response.data && response.data.redirect_url) {
                    // Automatically redirect in browser unless skipBrowserRedirect is true
                    if ((0, helpers_1.isBrowser)() && !(options === null || options === void 0 ? void 0 : options.skipBrowserRedirect)) {
                        window.location.assign(response.data.redirect_url);
                    }
                }
                return response;
            });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: null, error });
            }
            throw error;
        }
    }
    /**
     * Lists all OAuth grants that the authenticated user has authorized.
     * Only relevant when the OAuth 2.1 server is enabled in Supabase Auth.
     */
    async _listOAuthGrants() {
        try {
            return await this._useSession(async (result) => {
                const { data: { session }, error: sessionError, } = result;
                if (sessionError) {
                    return this._returnResult({ data: null, error: sessionError });
                }
                if (!session) {
                    return this._returnResult({ data: null, error: new errors_1.AuthSessionMissingError() });
                }
                return await (0, fetch_1._request)(this.fetch, 'GET', `${this.url}/user/oauth/grants`, {
                    headers: this.headers,
                    jwt: session.access_token,
                    xform: (data) => ({ data, error: null }),
                });
            });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: null, error });
            }
            throw error;
        }
    }
    /**
     * Revokes a user's OAuth grant for a specific client.
     * Only relevant when the OAuth 2.1 server is enabled in Supabase Auth.
     */
    async _revokeOAuthGrant(options) {
        try {
            return await this._useSession(async (result) => {
                const { data: { session }, error: sessionError, } = result;
                if (sessionError) {
                    return this._returnResult({ data: null, error: sessionError });
                }
                if (!session) {
                    return this._returnResult({ data: null, error: new errors_1.AuthSessionMissingError() });
                }
                await (0, fetch_1._request)(this.fetch, 'DELETE', `${this.url}/user/oauth/grants`, {
                    headers: this.headers,
                    jwt: session.access_token,
                    query: { client_id: options.clientId },
                    noResolveJson: true,
                });
                return { data: {}, error: null };
            });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: null, error });
            }
            throw error;
        }
    }
    async fetchJwk(kid, jwks = { keys: [] }) {
        // try fetching from the supplied jwks
        let jwk = jwks.keys.find((key) => key.kid === kid);
        if (jwk) {
            return jwk;
        }
        const now = Date.now();
        // try fetching from cache
        jwk = this.jwks.keys.find((key) => key.kid === kid);
        // jwk exists and jwks isn't stale
        if (jwk && this.jwks_cached_at + constants_1.JWKS_TTL > now) {
            return jwk;
        }
        // jwk isn't cached in memory so we need to fetch it from the well-known endpoint
        const { data, error } = await (0, fetch_1._request)(this.fetch, 'GET', `${this.url}/.well-known/jwks.json`, {
            headers: this.headers,
        });
        if (error) {
            throw error;
        }
        if (!data.keys || data.keys.length === 0) {
            return null;
        }
        this.jwks = data;
        this.jwks_cached_at = now;
        // Find the signing key
        jwk = data.keys.find((key) => key.kid === kid);
        if (!jwk) {
            return null;
        }
        return jwk;
    }
    /**
     * Extracts the JWT claims present in the access token by first verifying the
     * JWT against the server's JSON Web Key Set endpoint
     * `/.well-known/jwks.json` which is often cached, resulting in significantly
     * faster responses. Prefer this method over {@link #getUser} which always
     * sends a request to the Auth server for each JWT.
     *
     * If the project is not using an asymmetric JWT signing key (like ECC or
     * RSA) it always sends a request to the Auth server (similar to {@link
     * #getUser}) to verify the JWT.
     *
     * @param jwt An optional specific JWT you wish to verify, not the one you
     *            can obtain from {@link #getSession}.
     * @param options Various additional options that allow you to customize the
     *                behavior of this method.
     */
    async getClaims(jwt, options = {}) {
        try {
            let token = jwt;
            if (!token) {
                const { data, error } = await this.getSession();
                if (error || !data.session) {
                    return this._returnResult({ data: null, error });
                }
                token = data.session.access_token;
            }
            const { header, payload, signature, raw: { header: rawHeader, payload: rawPayload }, } = (0, helpers_1.decodeJWT)(token);
            if (!(options === null || options === void 0 ? void 0 : options.allowExpired)) {
                // Reject expired JWTs should only happen if jwt argument was passed
                (0, helpers_1.validateExp)(payload.exp);
            }
            const signingKey = !header.alg ||
                header.alg.startsWith('HS') ||
                !header.kid ||
                !('crypto' in globalThis && 'subtle' in globalThis.crypto)
                ? null
                : await this.fetchJwk(header.kid, (options === null || options === void 0 ? void 0 : options.keys) ? { keys: options.keys } : options === null || options === void 0 ? void 0 : options.jwks);
            // If symmetric algorithm or WebCrypto API is unavailable, fallback to getUser()
            if (!signingKey) {
                const { error } = await this.getUser(token);
                if (error) {
                    throw error;
                }
                // getUser succeeds so the claims in the JWT can be trusted
                return {
                    data: {
                        claims: payload,
                        header,
                        signature,
                    },
                    error: null,
                };
            }
            const algorithm = (0, helpers_1.getAlgorithm)(header.alg);
            // Convert JWK to CryptoKey
            const publicKey = await crypto.subtle.importKey('jwk', signingKey, algorithm, true, [
                'verify',
            ]);
            // Verify the signature
            const isValid = await crypto.subtle.verify(algorithm, publicKey, signature, (0, base64url_1.stringToUint8Array)(`${rawHeader}.${rawPayload}`));
            if (!isValid) {
                throw new errors_1.AuthInvalidJwtError('Invalid JWT signature');
            }
            // If verification succeeds, decode and return claims
            return {
                data: {
                    claims: payload,
                    header,
                    signature,
                },
                error: null,
            };
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return this._returnResult({ data: null, error });
            }
            throw error;
        }
    }
}
GoTrueClient.nextInstanceID = {};
exports["default"] = GoTrueClient;
//# sourceMappingURL=GoTrueClient.js.map

/***/ }),

/***/ 9485:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.processLock = exports.lockInternals = exports.NavigatorLockAcquireTimeoutError = exports.navigatorLock = exports.AuthClient = exports.AuthAdminApi = exports.GoTrueClient = exports.GoTrueAdminApi = void 0;
const tslib_1 = __webpack_require__(1915);
const GoTrueAdminApi_1 = tslib_1.__importDefault(__webpack_require__(5529));
exports.GoTrueAdminApi = GoTrueAdminApi_1.default;
const GoTrueClient_1 = tslib_1.__importDefault(__webpack_require__(7405));
exports.GoTrueClient = GoTrueClient_1.default;
const AuthAdminApi_1 = tslib_1.__importDefault(__webpack_require__(5442));
exports.AuthAdminApi = AuthAdminApi_1.default;
const AuthClient_1 = tslib_1.__importDefault(__webpack_require__(5264));
exports.AuthClient = AuthClient_1.default;
tslib_1.__exportStar(__webpack_require__(9012), exports);
tslib_1.__exportStar(__webpack_require__(2268), exports);
var locks_1 = __webpack_require__(5029);
Object.defineProperty(exports, "navigatorLock", ({ enumerable: true, get: function () { return locks_1.navigatorLock; } }));
Object.defineProperty(exports, "NavigatorLockAcquireTimeoutError", ({ enumerable: true, get: function () { return locks_1.NavigatorLockAcquireTimeoutError; } }));
Object.defineProperty(exports, "lockInternals", ({ enumerable: true, get: function () { return locks_1.internals; } }));
Object.defineProperty(exports, "processLock", ({ enumerable: true, get: function () { return locks_1.processLock; } }));
//# sourceMappingURL=index.js.map

/***/ }),

/***/ 7162:
/***/ ((__unused_webpack_module, exports) => {

"use strict";

/**
 * Avoid modifying this file. It's part of
 * https://github.com/supabase-community/base64url-js.  Submit all fixes on
 * that repo!
 */
Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.byteToBase64URL = byteToBase64URL;
exports.byteFromBase64URL = byteFromBase64URL;
exports.stringToBase64URL = stringToBase64URL;
exports.stringFromBase64URL = stringFromBase64URL;
exports.codepointToUTF8 = codepointToUTF8;
exports.stringToUTF8 = stringToUTF8;
exports.stringFromUTF8 = stringFromUTF8;
exports.base64UrlToUint8Array = base64UrlToUint8Array;
exports.stringToUint8Array = stringToUint8Array;
exports.bytesToBase64URL = bytesToBase64URL;
/**
 * An array of characters that encode 6 bits into a Base64-URL alphabet
 * character.
 */
const TO_BASE64URL = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_'.split('');
/**
 * An array of characters that can appear in a Base64-URL encoded string but
 * should be ignored.
 */
const IGNORE_BASE64URL = ' \t\n\r='.split('');
/**
 * An array of 128 numbers that map a Base64-URL character to 6 bits, or if -2
 * used to skip the character, or if -1 used to error out.
 */
const FROM_BASE64URL = (() => {
    const charMap = new Array(128);
    for (let i = 0; i < charMap.length; i += 1) {
        charMap[i] = -1;
    }
    for (let i = 0; i < IGNORE_BASE64URL.length; i += 1) {
        charMap[IGNORE_BASE64URL[i].charCodeAt(0)] = -2;
    }
    for (let i = 0; i < TO_BASE64URL.length; i += 1) {
        charMap[TO_BASE64URL[i].charCodeAt(0)] = i;
    }
    return charMap;
})();
/**
 * Converts a byte to a Base64-URL string.
 *
 * @param byte The byte to convert, or null to flush at the end of the byte sequence.
 * @param state The Base64 conversion state. Pass an initial value of `{ queue: 0, queuedBits: 0 }`.
 * @param emit A function called with the next Base64 character when ready.
 */
function byteToBase64URL(byte, state, emit) {
    if (byte !== null) {
        state.queue = (state.queue << 8) | byte;
        state.queuedBits += 8;
        while (state.queuedBits >= 6) {
            const pos = (state.queue >> (state.queuedBits - 6)) & 63;
            emit(TO_BASE64URL[pos]);
            state.queuedBits -= 6;
        }
    }
    else if (state.queuedBits > 0) {
        state.queue = state.queue << (6 - state.queuedBits);
        state.queuedBits = 6;
        while (state.queuedBits >= 6) {
            const pos = (state.queue >> (state.queuedBits - 6)) & 63;
            emit(TO_BASE64URL[pos]);
            state.queuedBits -= 6;
        }
    }
}
/**
 * Converts a String char code (extracted using `string.charCodeAt(position)`) to a sequence of Base64-URL characters.
 *
 * @param charCode The char code of the JavaScript string.
 * @param state The Base64 state. Pass an initial value of `{ queue: 0, queuedBits: 0 }`.
 * @param emit A function called with the next byte.
 */
function byteFromBase64URL(charCode, state, emit) {
    const bits = FROM_BASE64URL[charCode];
    if (bits > -1) {
        // valid Base64-URL character
        state.queue = (state.queue << 6) | bits;
        state.queuedBits += 6;
        while (state.queuedBits >= 8) {
            emit((state.queue >> (state.queuedBits - 8)) & 0xff);
            state.queuedBits -= 8;
        }
    }
    else if (bits === -2) {
        // ignore spaces, tabs, newlines, =
        return;
    }
    else {
        throw new Error(`Invalid Base64-URL character "${String.fromCharCode(charCode)}"`);
    }
}
/**
 * Converts a JavaScript string (which may include any valid character) into a
 * Base64-URL encoded string. The string is first encoded in UTF-8 which is
 * then encoded as Base64-URL.
 *
 * @param str The string to convert.
 */
function stringToBase64URL(str) {
    const base64 = [];
    const emitter = (char) => {
        base64.push(char);
    };
    const state = { queue: 0, queuedBits: 0 };
    stringToUTF8(str, (byte) => {
        byteToBase64URL(byte, state, emitter);
    });
    byteToBase64URL(null, state, emitter);
    return base64.join('');
}
/**
 * Converts a Base64-URL encoded string into a JavaScript string. It is assumed
 * that the underlying string has been encoded as UTF-8.
 *
 * @param str The Base64-URL encoded string.
 */
function stringFromBase64URL(str) {
    const conv = [];
    const utf8Emit = (codepoint) => {
        conv.push(String.fromCodePoint(codepoint));
    };
    const utf8State = {
        utf8seq: 0,
        codepoint: 0,
    };
    const b64State = { queue: 0, queuedBits: 0 };
    const byteEmit = (byte) => {
        stringFromUTF8(byte, utf8State, utf8Emit);
    };
    for (let i = 0; i < str.length; i += 1) {
        byteFromBase64URL(str.charCodeAt(i), b64State, byteEmit);
    }
    return conv.join('');
}
/**
 * Converts a Unicode codepoint to a multi-byte UTF-8 sequence.
 *
 * @param codepoint The Unicode codepoint.
 * @param emit      Function which will be called for each UTF-8 byte that represents the codepoint.
 */
function codepointToUTF8(codepoint, emit) {
    if (codepoint <= 0x7f) {
        emit(codepoint);
        return;
    }
    else if (codepoint <= 0x7ff) {
        emit(0xc0 | (codepoint >> 6));
        emit(0x80 | (codepoint & 0x3f));
        return;
    }
    else if (codepoint <= 0xffff) {
        emit(0xe0 | (codepoint >> 12));
        emit(0x80 | ((codepoint >> 6) & 0x3f));
        emit(0x80 | (codepoint & 0x3f));
        return;
    }
    else if (codepoint <= 0x10ffff) {
        emit(0xf0 | (codepoint >> 18));
        emit(0x80 | ((codepoint >> 12) & 0x3f));
        emit(0x80 | ((codepoint >> 6) & 0x3f));
        emit(0x80 | (codepoint & 0x3f));
        return;
    }
    throw new Error(`Unrecognized Unicode codepoint: ${codepoint.toString(16)}`);
}
/**
 * Converts a JavaScript string to a sequence of UTF-8 bytes.
 *
 * @param str  The string to convert to UTF-8.
 * @param emit Function which will be called for each UTF-8 byte of the string.
 */
function stringToUTF8(str, emit) {
    for (let i = 0; i < str.length; i += 1) {
        let codepoint = str.charCodeAt(i);
        if (codepoint > 0xd7ff && codepoint <= 0xdbff) {
            // most UTF-16 codepoints are Unicode codepoints, except values in this
            // range where the next UTF-16 codepoint needs to be combined with the
            // current one to get the Unicode codepoint
            const highSurrogate = ((codepoint - 0xd800) * 0x400) & 0xffff;
            const lowSurrogate = (str.charCodeAt(i + 1) - 0xdc00) & 0xffff;
            codepoint = (lowSurrogate | highSurrogate) + 0x10000;
            i += 1;
        }
        codepointToUTF8(codepoint, emit);
    }
}
/**
 * Converts a UTF-8 byte to a Unicode codepoint.
 *
 * @param byte  The UTF-8 byte next in the sequence.
 * @param state The shared state between consecutive UTF-8 bytes in the
 *              sequence, an object with the shape `{ utf8seq: 0, codepoint: 0 }`.
 * @param emit  Function which will be called for each codepoint.
 */
function stringFromUTF8(byte, state, emit) {
    if (state.utf8seq === 0) {
        if (byte <= 0x7f) {
            emit(byte);
            return;
        }
        // count the number of 1 leading bits until you reach 0
        for (let leadingBit = 1; leadingBit < 6; leadingBit += 1) {
            if (((byte >> (7 - leadingBit)) & 1) === 0) {
                state.utf8seq = leadingBit;
                break;
            }
        }
        if (state.utf8seq === 2) {
            state.codepoint = byte & 31;
        }
        else if (state.utf8seq === 3) {
            state.codepoint = byte & 15;
        }
        else if (state.utf8seq === 4) {
            state.codepoint = byte & 7;
        }
        else {
            throw new Error('Invalid UTF-8 sequence');
        }
        state.utf8seq -= 1;
    }
    else if (state.utf8seq > 0) {
        if (byte <= 0x7f) {
            throw new Error('Invalid UTF-8 sequence');
        }
        state.codepoint = (state.codepoint << 6) | (byte & 63);
        state.utf8seq -= 1;
        if (state.utf8seq === 0) {
            emit(state.codepoint);
        }
    }
}
/**
 * Helper functions to convert different types of strings to Uint8Array
 */
function base64UrlToUint8Array(str) {
    const result = [];
    const state = { queue: 0, queuedBits: 0 };
    const onByte = (byte) => {
        result.push(byte);
    };
    for (let i = 0; i < str.length; i += 1) {
        byteFromBase64URL(str.charCodeAt(i), state, onByte);
    }
    return new Uint8Array(result);
}
function stringToUint8Array(str) {
    const result = [];
    stringToUTF8(str, (byte) => result.push(byte));
    return new Uint8Array(result);
}
function bytesToBase64URL(bytes) {
    const result = [];
    const state = { queue: 0, queuedBits: 0 };
    const onChar = (char) => {
        result.push(char);
    };
    bytes.forEach((byte) => byteToBase64URL(byte, state, onChar));
    // always call with `null` after processing all bytes
    byteToBase64URL(null, state, onChar);
    return result.join('');
}
//# sourceMappingURL=base64url.js.map

/***/ }),

/***/ 6883:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.JWKS_TTL = exports.BASE64URL_REGEX = exports.API_VERSIONS = exports.API_VERSION_HEADER_NAME = exports.NETWORK_FAILURE = exports.DEFAULT_HEADERS = exports.AUDIENCE = exports.STORAGE_KEY = exports.GOTRUE_URL = exports.EXPIRY_MARGIN_MS = exports.AUTO_REFRESH_TICK_THRESHOLD = exports.AUTO_REFRESH_TICK_DURATION_MS = void 0;
const version_1 = __webpack_require__(5316);
/** Current session will be checked for refresh at this interval. */
exports.AUTO_REFRESH_TICK_DURATION_MS = 30 * 1000;
/**
 * A token refresh will be attempted this many ticks before the current session expires. */
exports.AUTO_REFRESH_TICK_THRESHOLD = 3;
/*
 * Earliest time before an access token expires that the session should be refreshed.
 */
exports.EXPIRY_MARGIN_MS = exports.AUTO_REFRESH_TICK_THRESHOLD * exports.AUTO_REFRESH_TICK_DURATION_MS;
exports.GOTRUE_URL = 'http://localhost:9999';
exports.STORAGE_KEY = 'supabase.auth.token';
exports.AUDIENCE = '';
exports.DEFAULT_HEADERS = { 'X-Client-Info': `gotrue-js/${version_1.version}` };
exports.NETWORK_FAILURE = {
    MAX_RETRIES: 10,
    RETRY_INTERVAL: 2, // in deciseconds
};
exports.API_VERSION_HEADER_NAME = 'X-Supabase-Api-Version';
exports.API_VERSIONS = {
    '2024-01-01': {
        timestamp: Date.parse('2024-01-01T00:00:00.0Z'),
        name: '2024-01-01',
    },
};
exports.BASE64URL_REGEX = /^([a-z0-9_-]{4})*($|[a-z0-9_-]{3}$|[a-z0-9_-]{2}$)$/i;
exports.JWKS_TTL = 10 * 60 * 1000; // 10 minutes
//# sourceMappingURL=constants.js.map

/***/ }),

/***/ 2268:
/***/ ((__unused_webpack_module, exports) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.AuthInvalidJwtError = exports.AuthWeakPasswordError = exports.AuthRetryableFetchError = exports.AuthPKCECodeVerifierMissingError = exports.AuthPKCEGrantCodeExchangeError = exports.AuthImplicitGrantRedirectError = exports.AuthInvalidCredentialsError = exports.AuthInvalidTokenResponseError = exports.AuthSessionMissingError = exports.CustomAuthError = exports.AuthUnknownError = exports.AuthApiError = exports.AuthError = void 0;
exports.isAuthError = isAuthError;
exports.isAuthApiError = isAuthApiError;
exports.isAuthSessionMissingError = isAuthSessionMissingError;
exports.isAuthImplicitGrantRedirectError = isAuthImplicitGrantRedirectError;
exports.isAuthPKCECodeVerifierMissingError = isAuthPKCECodeVerifierMissingError;
exports.isAuthRetryableFetchError = isAuthRetryableFetchError;
exports.isAuthWeakPasswordError = isAuthWeakPasswordError;
/**
 * Base error thrown by Supabase Auth helpers.
 *
 * @example
 * ```ts
 * import { AuthError } from '@supabase/auth-js'
 *
 * throw new AuthError('Unexpected auth error', 500, 'unexpected')
 * ```
 */
class AuthError extends Error {
    constructor(message, status, code) {
        super(message);
        this.__isAuthError = true;
        this.name = 'AuthError';
        this.status = status;
        this.code = code;
    }
}
exports.AuthError = AuthError;
function isAuthError(error) {
    return typeof error === 'object' && error !== null && '__isAuthError' in error;
}
/**
 * Error returned directly from the GoTrue REST API.
 *
 * @example
 * ```ts
 * import { AuthApiError } from '@supabase/auth-js'
 *
 * throw new AuthApiError('Invalid credentials', 400, 'invalid_credentials')
 * ```
 */
class AuthApiError extends AuthError {
    constructor(message, status, code) {
        super(message, status, code);
        this.name = 'AuthApiError';
        this.status = status;
        this.code = code;
    }
}
exports.AuthApiError = AuthApiError;
function isAuthApiError(error) {
    return isAuthError(error) && error.name === 'AuthApiError';
}
/**
 * Wraps non-standard errors so callers can inspect the root cause.
 *
 * @example
 * ```ts
 * import { AuthUnknownError } from '@supabase/auth-js'
 *
 * try {
 *   await someAuthCall()
 * } catch (err) {
 *   throw new AuthUnknownError('Auth failed', err)
 * }
 * ```
 */
class AuthUnknownError extends AuthError {
    constructor(message, originalError) {
        super(message);
        this.name = 'AuthUnknownError';
        this.originalError = originalError;
    }
}
exports.AuthUnknownError = AuthUnknownError;
/**
 * Flexible error class used to create named auth errors at runtime.
 *
 * @example
 * ```ts
 * import { CustomAuthError } from '@supabase/auth-js'
 *
 * throw new CustomAuthError('My custom auth error', 'MyAuthError', 400, 'custom_code')
 * ```
 */
class CustomAuthError extends AuthError {
    constructor(message, name, status, code) {
        super(message, status, code);
        this.name = name;
        this.status = status;
    }
}
exports.CustomAuthError = CustomAuthError;
/**
 * Error thrown when an operation requires a session but none is present.
 *
 * @example
 * ```ts
 * import { AuthSessionMissingError } from '@supabase/auth-js'
 *
 * throw new AuthSessionMissingError()
 * ```
 */
class AuthSessionMissingError extends CustomAuthError {
    constructor() {
        super('Auth session missing!', 'AuthSessionMissingError', 400, undefined);
    }
}
exports.AuthSessionMissingError = AuthSessionMissingError;
function isAuthSessionMissingError(error) {
    return isAuthError(error) && error.name === 'AuthSessionMissingError';
}
/**
 * Error thrown when the token response is malformed.
 *
 * @example
 * ```ts
 * import { AuthInvalidTokenResponseError } from '@supabase/auth-js'
 *
 * throw new AuthInvalidTokenResponseError()
 * ```
 */
class AuthInvalidTokenResponseError extends CustomAuthError {
    constructor() {
        super('Auth session or user missing', 'AuthInvalidTokenResponseError', 500, undefined);
    }
}
exports.AuthInvalidTokenResponseError = AuthInvalidTokenResponseError;
/**
 * Error thrown when email/password credentials are invalid.
 *
 * @example
 * ```ts
 * import { AuthInvalidCredentialsError } from '@supabase/auth-js'
 *
 * throw new AuthInvalidCredentialsError('Email or password is incorrect')
 * ```
 */
class AuthInvalidCredentialsError extends CustomAuthError {
    constructor(message) {
        super(message, 'AuthInvalidCredentialsError', 400, undefined);
    }
}
exports.AuthInvalidCredentialsError = AuthInvalidCredentialsError;
/**
 * Error thrown when implicit grant redirects contain an error.
 *
 * @example
 * ```ts
 * import { AuthImplicitGrantRedirectError } from '@supabase/auth-js'
 *
 * throw new AuthImplicitGrantRedirectError('OAuth redirect failed', {
 *   error: 'access_denied',
 *   code: 'oauth_error',
 * })
 * ```
 */
class AuthImplicitGrantRedirectError extends CustomAuthError {
    constructor(message, details = null) {
        super(message, 'AuthImplicitGrantRedirectError', 500, undefined);
        this.details = null;
        this.details = details;
    }
    toJSON() {
        return {
            name: this.name,
            message: this.message,
            status: this.status,
            details: this.details,
        };
    }
}
exports.AuthImplicitGrantRedirectError = AuthImplicitGrantRedirectError;
function isAuthImplicitGrantRedirectError(error) {
    return isAuthError(error) && error.name === 'AuthImplicitGrantRedirectError';
}
/**
 * Error thrown during PKCE code exchanges.
 *
 * @example
 * ```ts
 * import { AuthPKCEGrantCodeExchangeError } from '@supabase/auth-js'
 *
 * throw new AuthPKCEGrantCodeExchangeError('PKCE exchange failed')
 * ```
 */
class AuthPKCEGrantCodeExchangeError extends CustomAuthError {
    constructor(message, details = null) {
        super(message, 'AuthPKCEGrantCodeExchangeError', 500, undefined);
        this.details = null;
        this.details = details;
    }
    toJSON() {
        return {
            name: this.name,
            message: this.message,
            status: this.status,
            details: this.details,
        };
    }
}
exports.AuthPKCEGrantCodeExchangeError = AuthPKCEGrantCodeExchangeError;
/**
 * Error thrown when the PKCE code verifier is not found in storage.
 * This typically happens when the auth flow was initiated in a different
 * browser, device, or the storage was cleared.
 *
 * @example
 * ```ts
 * import { AuthPKCECodeVerifierMissingError } from '@supabase/auth-js'
 *
 * throw new AuthPKCECodeVerifierMissingError()
 * ```
 */
class AuthPKCECodeVerifierMissingError extends CustomAuthError {
    constructor() {
        super('PKCE code verifier not found in storage. ' +
            'This can happen if the auth flow was initiated in a different browser or device, ' +
            'or if the storage was cleared. For SSR frameworks (Next.js, SvelteKit, etc.), ' +
            'use @supabase/ssr on both the server and client to store the code verifier in cookies.', 'AuthPKCECodeVerifierMissingError', 400, 'pkce_code_verifier_not_found');
    }
}
exports.AuthPKCECodeVerifierMissingError = AuthPKCECodeVerifierMissingError;
function isAuthPKCECodeVerifierMissingError(error) {
    return isAuthError(error) && error.name === 'AuthPKCECodeVerifierMissingError';
}
/**
 * Error thrown when a transient fetch issue occurs.
 *
 * @example
 * ```ts
 * import { AuthRetryableFetchError } from '@supabase/auth-js'
 *
 * throw new AuthRetryableFetchError('Service temporarily unavailable', 503)
 * ```
 */
class AuthRetryableFetchError extends CustomAuthError {
    constructor(message, status) {
        super(message, 'AuthRetryableFetchError', status, undefined);
    }
}
exports.AuthRetryableFetchError = AuthRetryableFetchError;
function isAuthRetryableFetchError(error) {
    return isAuthError(error) && error.name === 'AuthRetryableFetchError';
}
/**
 * This error is thrown on certain methods when the password used is deemed
 * weak. Inspect the reasons to identify what password strength rules are
 * inadequate.
 */
/**
 * Error thrown when a supplied password is considered weak.
 *
 * @example
 * ```ts
 * import { AuthWeakPasswordError } from '@supabase/auth-js'
 *
 * throw new AuthWeakPasswordError('Password too short', 400, ['min_length'])
 * ```
 */
class AuthWeakPasswordError extends CustomAuthError {
    constructor(message, status, reasons) {
        super(message, 'AuthWeakPasswordError', status, 'weak_password');
        this.reasons = reasons;
    }
}
exports.AuthWeakPasswordError = AuthWeakPasswordError;
function isAuthWeakPasswordError(error) {
    return isAuthError(error) && error.name === 'AuthWeakPasswordError';
}
/**
 * Error thrown when a JWT cannot be verified or parsed.
 *
 * @example
 * ```ts
 * import { AuthInvalidJwtError } from '@supabase/auth-js'
 *
 * throw new AuthInvalidJwtError('Token signature is invalid')
 * ```
 */
class AuthInvalidJwtError extends CustomAuthError {
    constructor(message) {
        super(message, 'AuthInvalidJwtError', 400, 'invalid_jwt');
    }
}
exports.AuthInvalidJwtError = AuthInvalidJwtError;
//# sourceMappingURL=errors.js.map

/***/ }),

/***/ 4928:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.handleError = handleError;
exports._request = _request;
exports._sessionResponse = _sessionResponse;
exports._sessionResponsePassword = _sessionResponsePassword;
exports._userResponse = _userResponse;
exports._ssoResponse = _ssoResponse;
exports._generateLinkResponse = _generateLinkResponse;
exports._noResolveJsonResponse = _noResolveJsonResponse;
const tslib_1 = __webpack_require__(1915);
const constants_1 = __webpack_require__(6883);
const helpers_1 = __webpack_require__(1742);
const errors_1 = __webpack_require__(2268);
const _getErrorMessage = (err) => err.msg || err.message || err.error_description || err.error || JSON.stringify(err);
const NETWORK_ERROR_CODES = [502, 503, 504];
async function handleError(error) {
    var _a;
    if (!(0, helpers_1.looksLikeFetchResponse)(error)) {
        throw new errors_1.AuthRetryableFetchError(_getErrorMessage(error), 0);
    }
    if (NETWORK_ERROR_CODES.includes(error.status)) {
        // status in 500...599 range - server had an error, request might be retryed.
        throw new errors_1.AuthRetryableFetchError(_getErrorMessage(error), error.status);
    }
    let data;
    try {
        data = await error.json();
    }
    catch (e) {
        throw new errors_1.AuthUnknownError(_getErrorMessage(e), e);
    }
    let errorCode = undefined;
    const responseAPIVersion = (0, helpers_1.parseResponseAPIVersion)(error);
    if (responseAPIVersion &&
        responseAPIVersion.getTime() >= constants_1.API_VERSIONS['2024-01-01'].timestamp &&
        typeof data === 'object' &&
        data &&
        typeof data.code === 'string') {
        errorCode = data.code;
    }
    else if (typeof data === 'object' && data && typeof data.error_code === 'string') {
        errorCode = data.error_code;
    }
    if (!errorCode) {
        // Legacy support for weak password errors, when there were no error codes
        if (typeof data === 'object' &&
            data &&
            typeof data.weak_password === 'object' &&
            data.weak_password &&
            Array.isArray(data.weak_password.reasons) &&
            data.weak_password.reasons.length &&
            data.weak_password.reasons.reduce((a, i) => a && typeof i === 'string', true)) {
            throw new errors_1.AuthWeakPasswordError(_getErrorMessage(data), error.status, data.weak_password.reasons);
        }
    }
    else if (errorCode === 'weak_password') {
        throw new errors_1.AuthWeakPasswordError(_getErrorMessage(data), error.status, ((_a = data.weak_password) === null || _a === void 0 ? void 0 : _a.reasons) || []);
    }
    else if (errorCode === 'session_not_found') {
        // The `session_id` inside the JWT does not correspond to a row in the
        // `sessions` table. This usually means the user has signed out, has been
        // deleted, or their session has somehow been terminated.
        throw new errors_1.AuthSessionMissingError();
    }
    throw new errors_1.AuthApiError(_getErrorMessage(data), error.status || 500, errorCode);
}
const _getRequestParams = (method, options, parameters, body) => {
    const params = { method, headers: (options === null || options === void 0 ? void 0 : options.headers) || {} };
    if (method === 'GET') {
        return params;
    }
    params.headers = Object.assign({ 'Content-Type': 'application/json;charset=UTF-8' }, options === null || options === void 0 ? void 0 : options.headers);
    params.body = JSON.stringify(body);
    return Object.assign(Object.assign({}, params), parameters);
};
async function _request(fetcher, method, url, options) {
    var _a;
    const headers = Object.assign({}, options === null || options === void 0 ? void 0 : options.headers);
    if (!headers[constants_1.API_VERSION_HEADER_NAME]) {
        headers[constants_1.API_VERSION_HEADER_NAME] = constants_1.API_VERSIONS['2024-01-01'].name;
    }
    if (options === null || options === void 0 ? void 0 : options.jwt) {
        headers['Authorization'] = `Bearer ${options.jwt}`;
    }
    const qs = (_a = options === null || options === void 0 ? void 0 : options.query) !== null && _a !== void 0 ? _a : {};
    if (options === null || options === void 0 ? void 0 : options.redirectTo) {
        qs['redirect_to'] = options.redirectTo;
    }
    const queryString = Object.keys(qs).length ? '?' + new URLSearchParams(qs).toString() : '';
    const data = await _handleRequest(fetcher, method, url + queryString, {
        headers,
        noResolveJson: options === null || options === void 0 ? void 0 : options.noResolveJson,
    }, {}, options === null || options === void 0 ? void 0 : options.body);
    return (options === null || options === void 0 ? void 0 : options.xform) ? options === null || options === void 0 ? void 0 : options.xform(data) : { data: Object.assign({}, data), error: null };
}
async function _handleRequest(fetcher, method, url, options, parameters, body) {
    const requestParams = _getRequestParams(method, options, parameters, body);
    let result;
    try {
        result = await fetcher(url, Object.assign({}, requestParams));
    }
    catch (e) {
        console.error(e);
        // fetch failed, likely due to a network or CORS error
        throw new errors_1.AuthRetryableFetchError(_getErrorMessage(e), 0);
    }
    if (!result.ok) {
        await handleError(result);
    }
    if (options === null || options === void 0 ? void 0 : options.noResolveJson) {
        return result;
    }
    try {
        return await result.json();
    }
    catch (e) {
        await handleError(e);
    }
}
function _sessionResponse(data) {
    var _a;
    let session = null;
    if (hasSession(data)) {
        session = Object.assign({}, data);
        if (!data.expires_at) {
            session.expires_at = (0, helpers_1.expiresAt)(data.expires_in);
        }
    }
    const user = (_a = data.user) !== null && _a !== void 0 ? _a : data;
    return { data: { session, user }, error: null };
}
function _sessionResponsePassword(data) {
    const response = _sessionResponse(data);
    if (!response.error &&
        data.weak_password &&
        typeof data.weak_password === 'object' &&
        Array.isArray(data.weak_password.reasons) &&
        data.weak_password.reasons.length &&
        data.weak_password.message &&
        typeof data.weak_password.message === 'string' &&
        data.weak_password.reasons.reduce((a, i) => a && typeof i === 'string', true)) {
        response.data.weak_password = data.weak_password;
    }
    return response;
}
function _userResponse(data) {
    var _a;
    const user = (_a = data.user) !== null && _a !== void 0 ? _a : data;
    return { data: { user }, error: null };
}
function _ssoResponse(data) {
    return { data, error: null };
}
function _generateLinkResponse(data) {
    const { action_link, email_otp, hashed_token, redirect_to, verification_type } = data, rest = tslib_1.__rest(data, ["action_link", "email_otp", "hashed_token", "redirect_to", "verification_type"]);
    const properties = {
        action_link,
        email_otp,
        hashed_token,
        redirect_to,
        verification_type,
    };
    const user = Object.assign({}, rest);
    return {
        data: {
            properties,
            user,
        },
        error: null,
    };
}
function _noResolveJsonResponse(data) {
    return data;
}
/**
 * hasSession checks if the response object contains a valid session
 * @param data A response object
 * @returns true if a session is in the response
 */
function hasSession(data) {
    return data.access_token && data.refresh_token && data.expires_in;
}
//# sourceMappingURL=fetch.js.map

/***/ }),

/***/ 1742:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.Deferred = exports.removeItemAsync = exports.getItemAsync = exports.setItemAsync = exports.looksLikeFetchResponse = exports.resolveFetch = exports.supportsLocalStorage = exports.isBrowser = void 0;
exports.expiresAt = expiresAt;
exports.generateCallbackId = generateCallbackId;
exports.parseParametersFromURL = parseParametersFromURL;
exports.decodeJWT = decodeJWT;
exports.sleep = sleep;
exports.retryable = retryable;
exports.generatePKCEVerifier = generatePKCEVerifier;
exports.generatePKCEChallenge = generatePKCEChallenge;
exports.getCodeChallengeAndMethod = getCodeChallengeAndMethod;
exports.parseResponseAPIVersion = parseResponseAPIVersion;
exports.validateExp = validateExp;
exports.getAlgorithm = getAlgorithm;
exports.validateUUID = validateUUID;
exports.userNotAvailableProxy = userNotAvailableProxy;
exports.insecureUserWarningProxy = insecureUserWarningProxy;
exports.deepClone = deepClone;
const constants_1 = __webpack_require__(6883);
const errors_1 = __webpack_require__(2268);
const base64url_1 = __webpack_require__(7162);
function expiresAt(expiresIn) {
    const timeNow = Math.round(Date.now() / 1000);
    return timeNow + expiresIn;
}
/**
 * Generates a unique identifier for internal callback subscriptions.
 *
 * This function uses JavaScript Symbols to create guaranteed-unique identifiers
 * for auth state change callbacks. Symbols are ideal for this use case because:
 * - They are guaranteed unique by the JavaScript runtime
 * - They work in all environments (browser, SSR, Node.js)
 * - They avoid issues with Next.js 16 deterministic rendering requirements
 * - They are perfect for internal, non-serializable identifiers
 *
 * Note: This function is only used for internal subscription management,
 * not for security-critical operations like session tokens.
 */
function generateCallbackId() {
    return Symbol('auth-callback');
}
const isBrowser = () => typeof window !== 'undefined' && typeof document !== 'undefined';
exports.isBrowser = isBrowser;
const localStorageWriteTests = {
    tested: false,
    writable: false,
};
/**
 * Checks whether localStorage is supported on this browser.
 */
const supportsLocalStorage = () => {
    if (!(0, exports.isBrowser)()) {
        return false;
    }
    try {
        if (typeof globalThis.localStorage !== 'object') {
            return false;
        }
    }
    catch (e) {
        // DOM exception when accessing `localStorage`
        return false;
    }
    if (localStorageWriteTests.tested) {
        return localStorageWriteTests.writable;
    }
    const randomKey = `lswt-${Math.random()}${Math.random()}`;
    try {
        globalThis.localStorage.setItem(randomKey, randomKey);
        globalThis.localStorage.removeItem(randomKey);
        localStorageWriteTests.tested = true;
        localStorageWriteTests.writable = true;
    }
    catch (e) {
        // localStorage can't be written to
        // https://www.chromium.org/for-testers/bug-reporting-guidelines/uncaught-securityerror-failed-to-read-the-localstorage-property-from-window-access-is-denied-for-this-document
        localStorageWriteTests.tested = true;
        localStorageWriteTests.writable = false;
    }
    return localStorageWriteTests.writable;
};
exports.supportsLocalStorage = supportsLocalStorage;
/**
 * Extracts parameters encoded in the URL both in the query and fragment.
 */
function parseParametersFromURL(href) {
    const result = {};
    const url = new URL(href);
    if (url.hash && url.hash[0] === '#') {
        try {
            const hashSearchParams = new URLSearchParams(url.hash.substring(1));
            hashSearchParams.forEach((value, key) => {
                result[key] = value;
            });
        }
        catch (e) {
            // hash is not a query string
        }
    }
    // search parameters take precedence over hash parameters
    url.searchParams.forEach((value, key) => {
        result[key] = value;
    });
    return result;
}
const resolveFetch = (customFetch) => {
    if (customFetch) {
        return (...args) => customFetch(...args);
    }
    return (...args) => fetch(...args);
};
exports.resolveFetch = resolveFetch;
const looksLikeFetchResponse = (maybeResponse) => {
    return (typeof maybeResponse === 'object' &&
        maybeResponse !== null &&
        'status' in maybeResponse &&
        'ok' in maybeResponse &&
        'json' in maybeResponse &&
        typeof maybeResponse.json === 'function');
};
exports.looksLikeFetchResponse = looksLikeFetchResponse;
// Storage helpers
const setItemAsync = async (storage, key, data) => {
    await storage.setItem(key, JSON.stringify(data));
};
exports.setItemAsync = setItemAsync;
const getItemAsync = async (storage, key) => {
    const value = await storage.getItem(key);
    if (!value) {
        return null;
    }
    try {
        return JSON.parse(value);
    }
    catch (_a) {
        return value;
    }
};
exports.getItemAsync = getItemAsync;
const removeItemAsync = async (storage, key) => {
    await storage.removeItem(key);
};
exports.removeItemAsync = removeItemAsync;
/**
 * A deferred represents some asynchronous work that is not yet finished, which
 * may or may not culminate in a value.
 * Taken from: https://github.com/mike-north/types/blob/master/src/async.ts
 */
class Deferred {
    constructor() {
        // eslint-disable-next-line @typescript-eslint/no-extra-semi
        ;
        this.promise = new Deferred.promiseConstructor((res, rej) => {
            // eslint-disable-next-line @typescript-eslint/no-extra-semi
            ;
            this.resolve = res;
            this.reject = rej;
        });
    }
}
exports.Deferred = Deferred;
Deferred.promiseConstructor = Promise;
function decodeJWT(token) {
    const parts = token.split('.');
    if (parts.length !== 3) {
        throw new errors_1.AuthInvalidJwtError('Invalid JWT structure');
    }
    // Regex checks for base64url format
    for (let i = 0; i < parts.length; i++) {
        if (!constants_1.BASE64URL_REGEX.test(parts[i])) {
            throw new errors_1.AuthInvalidJwtError('JWT not in base64url format');
        }
    }
    const data = {
        // using base64url lib
        header: JSON.parse((0, base64url_1.stringFromBase64URL)(parts[0])),
        payload: JSON.parse((0, base64url_1.stringFromBase64URL)(parts[1])),
        signature: (0, base64url_1.base64UrlToUint8Array)(parts[2]),
        raw: {
            header: parts[0],
            payload: parts[1],
        },
    };
    return data;
}
/**
 * Creates a promise that resolves to null after some time.
 */
async function sleep(time) {
    return await new Promise((accept) => {
        setTimeout(() => accept(null), time);
    });
}
/**
 * Converts the provided async function into a retryable function. Each result
 * or thrown error is sent to the isRetryable function which should return true
 * if the function should run again.
 */
function retryable(fn, isRetryable) {
    const promise = new Promise((accept, reject) => {
        // eslint-disable-next-line @typescript-eslint/no-extra-semi
        ;
        (async () => {
            for (let attempt = 0; attempt < Infinity; attempt++) {
                try {
                    const result = await fn(attempt);
                    if (!isRetryable(attempt, null, result)) {
                        accept(result);
                        return;
                    }
                }
                catch (e) {
                    if (!isRetryable(attempt, e)) {
                        reject(e);
                        return;
                    }
                }
            }
        })();
    });
    return promise;
}
function dec2hex(dec) {
    return ('0' + dec.toString(16)).substr(-2);
}
// Functions below taken from: https://stackoverflow.com/questions/63309409/creating-a-code-verifier-and-challenge-for-pkce-auth-on-spotify-api-in-reactjs
function generatePKCEVerifier() {
    const verifierLength = 56;
    const array = new Uint32Array(verifierLength);
    if (typeof crypto === 'undefined') {
        const charSet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~';
        const charSetLen = charSet.length;
        let verifier = '';
        for (let i = 0; i < verifierLength; i++) {
            verifier += charSet.charAt(Math.floor(Math.random() * charSetLen));
        }
        return verifier;
    }
    crypto.getRandomValues(array);
    return Array.from(array, dec2hex).join('');
}
async function sha256(randomString) {
    const encoder = new TextEncoder();
    const encodedData = encoder.encode(randomString);
    const hash = await crypto.subtle.digest('SHA-256', encodedData);
    const bytes = new Uint8Array(hash);
    return Array.from(bytes)
        .map((c) => String.fromCharCode(c))
        .join('');
}
async function generatePKCEChallenge(verifier) {
    const hasCryptoSupport = typeof crypto !== 'undefined' &&
        typeof crypto.subtle !== 'undefined' &&
        typeof TextEncoder !== 'undefined';
    if (!hasCryptoSupport) {
        console.warn('WebCrypto API is not supported. Code challenge method will default to use plain instead of sha256.');
        return verifier;
    }
    const hashed = await sha256(verifier);
    return btoa(hashed).replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '');
}
async function getCodeChallengeAndMethod(storage, storageKey, isPasswordRecovery = false) {
    const codeVerifier = generatePKCEVerifier();
    let storedCodeVerifier = codeVerifier;
    if (isPasswordRecovery) {
        storedCodeVerifier += '/PASSWORD_RECOVERY';
    }
    await (0, exports.setItemAsync)(storage, `${storageKey}-code-verifier`, storedCodeVerifier);
    const codeChallenge = await generatePKCEChallenge(codeVerifier);
    const codeChallengeMethod = codeVerifier === codeChallenge ? 'plain' : 's256';
    return [codeChallenge, codeChallengeMethod];
}
/** Parses the API version which is 2YYY-MM-DD. */
const API_VERSION_REGEX = /^2[0-9]{3}-(0[1-9]|1[0-2])-(0[1-9]|1[0-9]|2[0-9]|3[0-1])$/i;
function parseResponseAPIVersion(response) {
    const apiVersion = response.headers.get(constants_1.API_VERSION_HEADER_NAME);
    if (!apiVersion) {
        return null;
    }
    if (!apiVersion.match(API_VERSION_REGEX)) {
        return null;
    }
    try {
        const date = new Date(`${apiVersion}T00:00:00.0Z`);
        return date;
    }
    catch (e) {
        return null;
    }
}
function validateExp(exp) {
    if (!exp) {
        throw new Error('Missing exp claim');
    }
    const timeNow = Math.floor(Date.now() / 1000);
    if (exp <= timeNow) {
        throw new Error('JWT has expired');
    }
}
function getAlgorithm(alg) {
    switch (alg) {
        case 'RS256':
            return {
                name: 'RSASSA-PKCS1-v1_5',
                hash: { name: 'SHA-256' },
            };
        case 'ES256':
            return {
                name: 'ECDSA',
                namedCurve: 'P-256',
                hash: { name: 'SHA-256' },
            };
        default:
            throw new Error('Invalid alg claim');
    }
}
const UUID_REGEX = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/;
function validateUUID(str) {
    if (!UUID_REGEX.test(str)) {
        throw new Error('@supabase/auth-js: Expected parameter to be UUID but is not');
    }
}
function userNotAvailableProxy() {
    const proxyTarget = {};
    return new Proxy(proxyTarget, {
        get: (target, prop) => {
            if (prop === '__isUserNotAvailableProxy') {
                return true;
            }
            // Preventative check for common problematic symbols during cloning/inspection
            // These symbols might be accessed by structuredClone or other internal mechanisms.
            if (typeof prop === 'symbol') {
                const sProp = prop.toString();
                if (sProp === 'Symbol(Symbol.toPrimitive)' ||
                    sProp === 'Symbol(Symbol.toStringTag)' ||
                    sProp === 'Symbol(util.inspect.custom)') {
                    // Node.js util.inspect
                    return undefined;
                }
            }
            throw new Error(`@supabase/auth-js: client was created with userStorage option and there was no user stored in the user storage. Accessing the "${prop}" property of the session object is not supported. Please use getUser() instead.`);
        },
        set: (_target, prop) => {
            throw new Error(`@supabase/auth-js: client was created with userStorage option and there was no user stored in the user storage. Setting the "${prop}" property of the session object is not supported. Please use getUser() to fetch a user object you can manipulate.`);
        },
        deleteProperty: (_target, prop) => {
            throw new Error(`@supabase/auth-js: client was created with userStorage option and there was no user stored in the user storage. Deleting the "${prop}" property of the session object is not supported. Please use getUser() to fetch a user object you can manipulate.`);
        },
    });
}
/**
 * Creates a proxy around a user object that warns when properties are accessed on the server.
 * This is used to alert developers that using user data from getSession() on the server is insecure.
 *
 * @param user The actual user object to wrap
 * @param suppressWarningRef An object with a 'value' property that controls warning suppression
 * @returns A proxied user object that warns on property access
 */
function insecureUserWarningProxy(user, suppressWarningRef) {
    return new Proxy(user, {
        get: (target, prop, receiver) => {
            // Allow internal checks without warning
            if (prop === '__isInsecureUserWarningProxy') {
                return true;
            }
            // Preventative check for common problematic symbols during cloning/inspection
            // These symbols might be accessed by structuredClone or other internal mechanisms
            if (typeof prop === 'symbol') {
                const sProp = prop.toString();
                if (sProp === 'Symbol(Symbol.toPrimitive)' ||
                    sProp === 'Symbol(Symbol.toStringTag)' ||
                    sProp === 'Symbol(util.inspect.custom)' ||
                    sProp === 'Symbol(nodejs.util.inspect.custom)') {
                    // Return the actual value for these symbols to allow proper inspection
                    return Reflect.get(target, prop, receiver);
                }
            }
            // Emit warning on first property access
            if (!suppressWarningRef.value && typeof prop === 'string') {
                console.warn('Using the user object as returned from supabase.auth.getSession() or from some supabase.auth.onAuthStateChange() events could be insecure! This value comes directly from the storage medium (usually cookies on the server) and may not be authentic. Use supabase.auth.getUser() instead which authenticates the data by contacting the Supabase Auth server.');
                suppressWarningRef.value = true;
            }
            return Reflect.get(target, prop, receiver);
        },
    });
}
/**
 * Deep clones a JSON-serializable object using JSON.parse(JSON.stringify(obj)).
 * Note: Only works for JSON-safe data.
 */
function deepClone(obj) {
    return JSON.parse(JSON.stringify(obj));
}
//# sourceMappingURL=helpers.js.map

/***/ }),

/***/ 1030:
/***/ ((__unused_webpack_module, exports) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.memoryLocalStorageAdapter = memoryLocalStorageAdapter;
/**
 * Returns a localStorage-like object that stores the key-value pairs in
 * memory.
 */
function memoryLocalStorageAdapter(store = {}) {
    return {
        getItem: (key) => {
            return store[key] || null;
        },
        setItem: (key, value) => {
            store[key] = value;
        },
        removeItem: (key) => {
            delete store[key];
        },
    };
}
//# sourceMappingURL=local-storage.js.map

/***/ }),

/***/ 5029:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.ProcessLockAcquireTimeoutError = exports.NavigatorLockAcquireTimeoutError = exports.LockAcquireTimeoutError = exports.internals = void 0;
exports.navigatorLock = navigatorLock;
exports.processLock = processLock;
const helpers_1 = __webpack_require__(1742);
/**
 * @experimental
 */
exports.internals = {
    /**
     * @experimental
     */
    debug: !!(globalThis &&
        (0, helpers_1.supportsLocalStorage)() &&
        globalThis.localStorage &&
        globalThis.localStorage.getItem('supabase.gotrue-js.locks.debug') === 'true'),
};
/**
 * An error thrown when a lock cannot be acquired after some amount of time.
 *
 * Use the {@link #isAcquireTimeout} property instead of checking with `instanceof`.
 *
 * @example
 * ```ts
 * import { LockAcquireTimeoutError } from '@supabase/auth-js'
 *
 * class CustomLockError extends LockAcquireTimeoutError {
 *   constructor() {
 *     super('Lock timed out')
 *   }
 * }
 * ```
 */
class LockAcquireTimeoutError extends Error {
    constructor(message) {
        super(message);
        this.isAcquireTimeout = true;
    }
}
exports.LockAcquireTimeoutError = LockAcquireTimeoutError;
/**
 * Error thrown when the browser Navigator Lock API fails to acquire a lock.
 *
 * @example
 * ```ts
 * import { NavigatorLockAcquireTimeoutError } from '@supabase/auth-js'
 *
 * throw new NavigatorLockAcquireTimeoutError('Lock timed out')
 * ```
 */
class NavigatorLockAcquireTimeoutError extends LockAcquireTimeoutError {
}
exports.NavigatorLockAcquireTimeoutError = NavigatorLockAcquireTimeoutError;
/**
 * Error thrown when the process-level lock helper cannot acquire a lock.
 *
 * @example
 * ```ts
 * import { ProcessLockAcquireTimeoutError } from '@supabase/auth-js'
 *
 * throw new ProcessLockAcquireTimeoutError('Lock timed out')
 * ```
 */
class ProcessLockAcquireTimeoutError extends LockAcquireTimeoutError {
}
exports.ProcessLockAcquireTimeoutError = ProcessLockAcquireTimeoutError;
/**
 * Implements a global exclusive lock using the Navigator LockManager API. It
 * is available on all browsers released after 2022-03-15 with Safari being the
 * last one to release support. If the API is not available, this function will
 * throw. Make sure you check availablility before configuring {@link
 * GoTrueClient}.
 *
 * You can turn on debugging by setting the `supabase.gotrue-js.locks.debug`
 * local storage item to `true`.
 *
 * Internals:
 *
 * Since the LockManager API does not preserve stack traces for the async
 * function passed in the `request` method, a trick is used where acquiring the
 * lock releases a previously started promise to run the operation in the `fn`
 * function. The lock waits for that promise to finish (with or without error),
 * while the function will finally wait for the result anyway.
 *
 * @param name Name of the lock to be acquired.
 * @param acquireTimeout If negative, no timeout. If 0 an error is thrown if
 *                       the lock can't be acquired without waiting. If positive, the lock acquire
 *                       will time out after so many milliseconds. An error is
 *                       a timeout if it has `isAcquireTimeout` set to true.
 * @param fn The operation to run once the lock is acquired.
 * @example
 * ```ts
 * await navigatorLock('sync-user', 1000, async () => {
 *   await refreshSession()
 * })
 * ```
 */
async function navigatorLock(name, acquireTimeout, fn) {
    if (exports.internals.debug) {
        console.log('@supabase/gotrue-js: navigatorLock: acquire lock', name, acquireTimeout);
    }
    const abortController = new globalThis.AbortController();
    if (acquireTimeout > 0) {
        setTimeout(() => {
            abortController.abort();
            if (exports.internals.debug) {
                console.log('@supabase/gotrue-js: navigatorLock acquire timed out', name);
            }
        }, acquireTimeout);
    }
    // MDN article: https://developer.mozilla.org/en-US/docs/Web/API/LockManager/request
    // Wrapping navigator.locks.request() with a plain Promise is done as some
    // libraries like zone.js patch the Promise object to track the execution
    // context. However, it appears that most browsers use an internal promise
    // implementation when using the navigator.locks.request() API causing them
    // to lose context and emit confusing log messages or break certain features.
    // This wrapping is believed to help zone.js track the execution context
    // better.
    await Promise.resolve();
    try {
        return await globalThis.navigator.locks.request(name, acquireTimeout === 0
            ? {
                mode: 'exclusive',
                ifAvailable: true,
            }
            : {
                mode: 'exclusive',
                signal: abortController.signal,
            }, async (lock) => {
            if (lock) {
                if (exports.internals.debug) {
                    console.log('@supabase/gotrue-js: navigatorLock: acquired', name, lock.name);
                }
                try {
                    return await fn();
                }
                finally {
                    if (exports.internals.debug) {
                        console.log('@supabase/gotrue-js: navigatorLock: released', name, lock.name);
                    }
                }
            }
            else {
                if (acquireTimeout === 0) {
                    if (exports.internals.debug) {
                        console.log('@supabase/gotrue-js: navigatorLock: not immediately available', name);
                    }
                    throw new NavigatorLockAcquireTimeoutError(`Acquiring an exclusive Navigator LockManager lock "${name}" immediately failed`);
                }
                else {
                    if (exports.internals.debug) {
                        try {
                            const result = await globalThis.navigator.locks.query();
                            console.log('@supabase/gotrue-js: Navigator LockManager state', JSON.stringify(result, null, '  '));
                        }
                        catch (e) {
                            console.warn('@supabase/gotrue-js: Error when querying Navigator LockManager state', e);
                        }
                    }
                    // Browser is not following the Navigator LockManager spec, it
                    // returned a null lock when we didn't use ifAvailable. So we can
                    // pretend the lock is acquired in the name of backward compatibility
                    // and user experience and just run the function.
                    console.warn('@supabase/gotrue-js: Navigator LockManager returned a null lock when using #request without ifAvailable set to true, it appears this browser is not following the LockManager spec https://developer.mozilla.org/en-US/docs/Web/API/LockManager/request');
                    return await fn();
                }
            }
        });
    }
    catch (e) {
        if ((e === null || e === void 0 ? void 0 : e.name) === 'AbortError' && acquireTimeout > 0) {
            // The lock acquisition was aborted because the timeout fired while the
            // request was still pending. This typically means another lock holder is
            // not releasing the lock, possibly due to React Strict Mode's
            // double-mount/unmount behavior or a component unmounting mid-operation,
            // leaving an orphaned lock.
            //
            // Recovery: use { steal: true } to forcefully acquire the lock. Per the
            // Web Locks API spec, this releases any currently held lock with the same
            // name and grants the request immediately, preempting any queued requests.
            // The previous holder's callback continues running to completion but no
            // longer holds the lock for exclusion purposes.
            //
            // See: https://github.com/supabase/supabase/issues/42505
            if (exports.internals.debug) {
                console.log('@supabase/gotrue-js: navigatorLock: acquire timeout, recovering by stealing lock', name);
            }
            console.warn(`@supabase/gotrue-js: Lock "${name}" was not released within ${acquireTimeout}ms. ` +
                'This may indicate an orphaned lock from a component unmount (e.g., React Strict Mode). ' +
                'Forcefully acquiring the lock to recover.');
            return await Promise.resolve().then(() => globalThis.navigator.locks.request(name, {
                mode: 'exclusive',
                steal: true,
            }, async (lock) => {
                if (lock) {
                    if (exports.internals.debug) {
                        console.log('@supabase/gotrue-js: navigatorLock: recovered (stolen)', name, lock.name);
                    }
                    try {
                        return await fn();
                    }
                    finally {
                        if (exports.internals.debug) {
                            console.log('@supabase/gotrue-js: navigatorLock: released (stolen)', name, lock.name);
                        }
                    }
                }
                else {
                    // This should not happen with steal: true, but handle gracefully.
                    console.warn('@supabase/gotrue-js: Navigator LockManager returned null lock even with steal: true');
                    return await fn();
                }
            }));
        }
        throw e;
    }
}
const PROCESS_LOCKS = {};
/**
 * Implements a global exclusive lock that works only in the current process.
 * Useful for environments like React Native or other non-browser
 * single-process (i.e. no concept of "tabs") environments.
 *
 * Use {@link #navigatorLock} in browser environments.
 *
 * @param name Name of the lock to be acquired.
 * @param acquireTimeout If negative, no timeout. If 0 an error is thrown if
 *                       the lock can't be acquired without waiting. If positive, the lock acquire
 *                       will time out after so many milliseconds. An error is
 *                       a timeout if it has `isAcquireTimeout` set to true.
 * @param fn The operation to run once the lock is acquired.
 * @example
 * ```ts
 * await processLock('migrate', 5000, async () => {
 *   await runMigration()
 * })
 * ```
 */
async function processLock(name, acquireTimeout, fn) {
    var _a;
    const previousOperation = (_a = PROCESS_LOCKS[name]) !== null && _a !== void 0 ? _a : Promise.resolve();
    // Wrap previousOperation to handle errors without using .catch()
    // This avoids Firefox content script security errors
    const previousOperationHandled = (async () => {
        try {
            await previousOperation;
            return null;
        }
        catch (e) {
            // ignore error of previous operation that we're waiting to finish
            return null;
        }
    })();
    const currentOperation = (async () => {
        let timeoutId = null;
        try {
            // Wait for either previous operation or timeout
            const timeoutPromise = acquireTimeout >= 0
                ? new Promise((_, reject) => {
                    timeoutId = setTimeout(() => {
                        console.warn(`@supabase/gotrue-js: Lock "${name}" acquisition timed out after ${acquireTimeout}ms. ` +
                            'This may be caused by another operation holding the lock. ' +
                            'Consider increasing lockAcquireTimeout or checking for stuck operations.');
                        reject(new ProcessLockAcquireTimeoutError(`Acquiring process lock with name "${name}" timed out`));
                    }, acquireTimeout);
                })
                : null;
            await Promise.race([previousOperationHandled, timeoutPromise].filter((x) => x));
            // If we reach here, previousOperationHandled won the race
            // Clear the timeout to prevent false warnings
            if (timeoutId !== null) {
                clearTimeout(timeoutId);
            }
        }
        catch (e) {
            // Clear the timeout on error path as well
            if (timeoutId !== null) {
                clearTimeout(timeoutId);
            }
            // Re-throw timeout errors, ignore others
            if (e && e.isAcquireTimeout) {
                throw e;
            }
            // Fall through to run fn() - previous operation finished with error
        }
        // Previous operations finished and we didn't get a race on the acquire
        // timeout, so the current operation can finally start
        return await fn();
    })();
    PROCESS_LOCKS[name] = (async () => {
        try {
            return await currentOperation;
        }
        catch (e) {
            if (e && e.isAcquireTimeout) {
                // if the current operation timed out, it doesn't mean that the previous
                // operation finished, so we need continue waiting for it to finish
                try {
                    await previousOperation;
                }
                catch (prevError) {
                    // Ignore previous operation errors
                }
                return null;
            }
            throw e;
        }
    })();
    // finally wait for the current operation to finish successfully, with an
    // error or with an acquire timeout error
    return await currentOperation;
}
//# sourceMappingURL=locks.js.map

/***/ }),

/***/ 3965:
/***/ ((__unused_webpack_module, exports) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.polyfillGlobalThis = polyfillGlobalThis;
/**
 * https://mathiasbynens.be/notes/globalthis
 */
function polyfillGlobalThis() {
    if (typeof globalThis === 'object')
        return;
    try {
        Object.defineProperty(Object.prototype, '__magic__', {
            get: function () {
                return this;
            },
            configurable: true,
        });
        // @ts-expect-error 'Allow access to magic'
        __magic__.globalThis = __magic__;
        // @ts-expect-error 'Allow access to magic'
        delete Object.prototype.__magic__;
    }
    catch (e) {
        if (typeof self !== 'undefined') {
            // @ts-expect-error 'Allow access to globals'
            self.globalThis = self;
        }
    }
}
//# sourceMappingURL=polyfills.js.map

/***/ }),

/***/ 9012:
/***/ ((__unused_webpack_module, exports) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.SIGN_OUT_SCOPES = void 0;
const WeakPasswordReasons = (/* unused pure expression or super */ null && (['length', 'characters', 'pwned']));
const AMRMethods = (/* unused pure expression or super */ null && ([
    'password',
    'otp',
    'oauth',
    'totp',
    'mfa/totp',
    'mfa/phone',
    'mfa/webauthn',
    'anonymous',
    'sso/saml',
    'magiclink',
    'web3',
    'oauth_provider/authorization_code',
]));
const FactorTypes = (/* unused pure expression or super */ null && (['totp', 'phone', 'webauthn']));
const FactorVerificationStatuses = (/* unused pure expression or super */ null && (['verified', 'unverified']));
const MFATOTPChannels = (/* unused pure expression or super */ null && (['sms', 'whatsapp']));
exports.SIGN_OUT_SCOPES = ['global', 'local', 'others'];
//# sourceMappingURL=types.js.map

/***/ }),

/***/ 5316:
/***/ ((__unused_webpack_module, exports) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.version = void 0;
// Generated automatically during releases by scripts/update-version-files.ts
// This file provides runtime access to the package version for:
// - HTTP request headers (e.g., X-Client-Info header for API requests)
// - Debugging and support (identifying which version is running)
// - Telemetry and logging (version reporting in errors/analytics)
// - Ensuring build artifacts match the published package version
exports.version = '2.98.0';
//# sourceMappingURL=version.js.map

/***/ }),

/***/ 4368:
/***/ ((__unused_webpack_module, exports) => {

"use strict";

// types and functions copied over from viem so this library doesn't depend on it
Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.getAddress = getAddress;
exports.fromHex = fromHex;
exports.toHex = toHex;
exports.createSiweMessage = createSiweMessage;
function getAddress(address) {
    if (!/^0x[a-fA-F0-9]{40}$/.test(address)) {
        throw new Error(`@supabase/auth-js: Address "${address}" is invalid.`);
    }
    return address.toLowerCase();
}
function fromHex(hex) {
    return parseInt(hex, 16);
}
function toHex(value) {
    const bytes = new TextEncoder().encode(value);
    const hex = Array.from(bytes, (byte) => byte.toString(16).padStart(2, '0')).join('');
    return ('0x' + hex);
}
/**
 * Creates EIP-4361 formatted message.
 */
function createSiweMessage(parameters) {
    var _a;
    const { chainId, domain, expirationTime, issuedAt = new Date(), nonce, notBefore, requestId, resources, scheme, uri, version, } = parameters;
    // Validate fields
    {
        if (!Number.isInteger(chainId))
            throw new Error(`@supabase/auth-js: Invalid SIWE message field "chainId". Chain ID must be a EIP-155 chain ID. Provided value: ${chainId}`);
        if (!domain)
            throw new Error(`@supabase/auth-js: Invalid SIWE message field "domain". Domain must be provided.`);
        if (nonce && nonce.length < 8)
            throw new Error(`@supabase/auth-js: Invalid SIWE message field "nonce". Nonce must be at least 8 characters. Provided value: ${nonce}`);
        if (!uri)
            throw new Error(`@supabase/auth-js: Invalid SIWE message field "uri". URI must be provided.`);
        if (version !== '1')
            throw new Error(`@supabase/auth-js: Invalid SIWE message field "version". Version must be '1'. Provided value: ${version}`);
        if ((_a = parameters.statement) === null || _a === void 0 ? void 0 : _a.includes('\n'))
            throw new Error(`@supabase/auth-js: Invalid SIWE message field "statement". Statement must not include '\\n'. Provided value: ${parameters.statement}`);
    }
    // Construct message
    const address = getAddress(parameters.address);
    const origin = scheme ? `${scheme}://${domain}` : domain;
    const statement = parameters.statement ? `${parameters.statement}\n` : '';
    const prefix = `${origin} wants you to sign in with your Ethereum account:\n${address}\n\n${statement}`;
    let suffix = `URI: ${uri}\nVersion: ${version}\nChain ID: ${chainId}${nonce ? `\nNonce: ${nonce}` : ''}\nIssued At: ${issuedAt.toISOString()}`;
    if (expirationTime)
        suffix += `\nExpiration Time: ${expirationTime.toISOString()}`;
    if (notBefore)
        suffix += `\nNot Before: ${notBefore.toISOString()}`;
    if (requestId)
        suffix += `\nRequest ID: ${requestId}`;
    if (resources) {
        let content = '\nResources:';
        for (const resource of resources) {
            if (!resource || typeof resource !== 'string')
                throw new Error(`@supabase/auth-js: Invalid SIWE message field "resources". Every resource must be a valid string. Provided value: ${resource}`);
            content += `\n- ${resource}`;
        }
        suffix += content;
    }
    return `${prefix}\n${suffix}`;
}
//# sourceMappingURL=ethereum.js.map

/***/ }),

/***/ 3098:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {

"use strict";

/* eslint-disable @typescript-eslint/ban-ts-comment */
Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.WebAuthnUnknownError = exports.WebAuthnError = void 0;
exports.isWebAuthnError = isWebAuthnError;
exports.identifyRegistrationError = identifyRegistrationError;
exports.identifyAuthenticationError = identifyAuthenticationError;
const webauthn_1 = __webpack_require__(6025);
/**
 * A custom Error used to return a more nuanced error detailing _why_ one of the eight documented
 * errors in the spec was raised after calling `navigator.credentials.create()` or
 * `navigator.credentials.get()`:
 *
 * - `AbortError`
 * - `ConstraintError`
 * - `InvalidStateError`
 * - `NotAllowedError`
 * - `NotSupportedError`
 * - `SecurityError`
 * - `TypeError`
 * - `UnknownError`
 *
 * Error messages were determined through investigation of the spec to determine under which
 * scenarios a given error would be raised.
 */
class WebAuthnError extends Error {
    constructor({ message, code, cause, name, }) {
        var _a;
        // @ts-ignore: help Rollup understand that `cause` is okay to set
        super(message, { cause });
        this.__isWebAuthnError = true;
        this.name = (_a = name !== null && name !== void 0 ? name : (cause instanceof Error ? cause.name : undefined)) !== null && _a !== void 0 ? _a : 'Unknown Error';
        this.code = code;
    }
}
exports.WebAuthnError = WebAuthnError;
/**
 * Error class for unknown WebAuthn errors.
 * Wraps unexpected errors that don't match known WebAuthn error conditions.
 */
class WebAuthnUnknownError extends WebAuthnError {
    constructor(message, originalError) {
        super({
            code: 'ERROR_PASSTHROUGH_SEE_CAUSE_PROPERTY',
            cause: originalError,
            message,
        });
        this.name = 'WebAuthnUnknownError';
        this.originalError = originalError;
    }
}
exports.WebAuthnUnknownError = WebAuthnUnknownError;
/**
 * Type guard to check if an error is a WebAuthnError.
 * @param {unknown} error - The error to check
 * @returns {boolean} True if the error is a WebAuthnError
 */
function isWebAuthnError(error) {
    return typeof error === 'object' && error !== null && '__isWebAuthnError' in error;
}
/**
 * Attempt to intuit _why_ an error was raised after calling `navigator.credentials.create()`.
 * Maps browser errors to specific WebAuthn error codes for better debugging.
 * @param {Object} params - Error identification parameters
 * @param {Error} params.error - The error thrown by the browser
 * @param {CredentialCreationOptions} params.options - The options passed to credentials.create()
 * @returns {WebAuthnError} A WebAuthnError with a specific error code
 * @see {@link https://w3c.github.io/webauthn/#sctn-createCredential W3C WebAuthn Spec - Create Credential}
 */
function identifyRegistrationError({ error, options, }) {
    var _a, _b, _c;
    const { publicKey } = options;
    if (!publicKey) {
        throw Error('options was missing required publicKey property');
    }
    if (error.name === 'AbortError') {
        if (options.signal instanceof AbortSignal) {
            // https://www.w3.org/TR/webauthn-2/#sctn-createCredential (Step 16)
            return new WebAuthnError({
                message: 'Registration ceremony was sent an abort signal',
                code: 'ERROR_CEREMONY_ABORTED',
                cause: error,
            });
        }
    }
    else if (error.name === 'ConstraintError') {
        if (((_a = publicKey.authenticatorSelection) === null || _a === void 0 ? void 0 : _a.requireResidentKey) === true) {
            // https://www.w3.org/TR/webauthn-2/#sctn-op-make-cred (Step 4)
            return new WebAuthnError({
                message: 'Discoverable credentials were required but no available authenticator supported it',
                code: 'ERROR_AUTHENTICATOR_MISSING_DISCOVERABLE_CREDENTIAL_SUPPORT',
                cause: error,
            });
        }
        else if (
        // @ts-ignore: `mediation` doesn't yet exist on CredentialCreationOptions but it's possible as of Sept 2024
        options.mediation === 'conditional' &&
            ((_b = publicKey.authenticatorSelection) === null || _b === void 0 ? void 0 : _b.userVerification) === 'required') {
            // https://w3c.github.io/webauthn/#sctn-createCredential (Step 22.4)
            return new WebAuthnError({
                message: 'User verification was required during automatic registration but it could not be performed',
                code: 'ERROR_AUTO_REGISTER_USER_VERIFICATION_FAILURE',
                cause: error,
            });
        }
        else if (((_c = publicKey.authenticatorSelection) === null || _c === void 0 ? void 0 : _c.userVerification) === 'required') {
            // https://www.w3.org/TR/webauthn-2/#sctn-op-make-cred (Step 5)
            return new WebAuthnError({
                message: 'User verification was required but no available authenticator supported it',
                code: 'ERROR_AUTHENTICATOR_MISSING_USER_VERIFICATION_SUPPORT',
                cause: error,
            });
        }
    }
    else if (error.name === 'InvalidStateError') {
        // https://www.w3.org/TR/webauthn-2/#sctn-createCredential (Step 20)
        // https://www.w3.org/TR/webauthn-2/#sctn-op-make-cred (Step 3)
        return new WebAuthnError({
            message: 'The authenticator was previously registered',
            code: 'ERROR_AUTHENTICATOR_PREVIOUSLY_REGISTERED',
            cause: error,
        });
    }
    else if (error.name === 'NotAllowedError') {
        /**
         * Pass the error directly through. Platforms are overloading this error beyond what the spec
         * defines and we don't want to overwrite potentially useful error messages.
         */
        return new WebAuthnError({
            message: error.message,
            code: 'ERROR_PASSTHROUGH_SEE_CAUSE_PROPERTY',
            cause: error,
        });
    }
    else if (error.name === 'NotSupportedError') {
        const validPubKeyCredParams = publicKey.pubKeyCredParams.filter((param) => param.type === 'public-key');
        if (validPubKeyCredParams.length === 0) {
            // https://www.w3.org/TR/webauthn-2/#sctn-createCredential (Step 10)
            return new WebAuthnError({
                message: 'No entry in pubKeyCredParams was of type "public-key"',
                code: 'ERROR_MALFORMED_PUBKEYCREDPARAMS',
                cause: error,
            });
        }
        // https://www.w3.org/TR/webauthn-2/#sctn-op-make-cred (Step 2)
        return new WebAuthnError({
            message: 'No available authenticator supported any of the specified pubKeyCredParams algorithms',
            code: 'ERROR_AUTHENTICATOR_NO_SUPPORTED_PUBKEYCREDPARAMS_ALG',
            cause: error,
        });
    }
    else if (error.name === 'SecurityError') {
        const effectiveDomain = window.location.hostname;
        if (!(0, webauthn_1.isValidDomain)(effectiveDomain)) {
            // https://www.w3.org/TR/webauthn-2/#sctn-createCredential (Step 7)
            return new WebAuthnError({
                message: `${window.location.hostname} is an invalid domain`,
                code: 'ERROR_INVALID_DOMAIN',
                cause: error,
            });
        }
        else if (publicKey.rp.id !== effectiveDomain) {
            // https://www.w3.org/TR/webauthn-2/#sctn-createCredential (Step 8)
            return new WebAuthnError({
                message: `The RP ID "${publicKey.rp.id}" is invalid for this domain`,
                code: 'ERROR_INVALID_RP_ID',
                cause: error,
            });
        }
    }
    else if (error.name === 'TypeError') {
        if (publicKey.user.id.byteLength < 1 || publicKey.user.id.byteLength > 64) {
            // https://www.w3.org/TR/webauthn-2/#sctn-createCredential (Step 5)
            return new WebAuthnError({
                message: 'User ID was not between 1 and 64 characters',
                code: 'ERROR_INVALID_USER_ID_LENGTH',
                cause: error,
            });
        }
    }
    else if (error.name === 'UnknownError') {
        // https://www.w3.org/TR/webauthn-2/#sctn-op-make-cred (Step 1)
        // https://www.w3.org/TR/webauthn-2/#sctn-op-make-cred (Step 8)
        return new WebAuthnError({
            message: 'The authenticator was unable to process the specified options, or could not create a new credential',
            code: 'ERROR_AUTHENTICATOR_GENERAL_ERROR',
            cause: error,
        });
    }
    return new WebAuthnError({
        message: 'a Non-Webauthn related error has occurred',
        code: 'ERROR_PASSTHROUGH_SEE_CAUSE_PROPERTY',
        cause: error,
    });
}
/**
 * Attempt to intuit _why_ an error was raised after calling `navigator.credentials.get()`.
 * Maps browser errors to specific WebAuthn error codes for better debugging.
 * @param {Object} params - Error identification parameters
 * @param {Error} params.error - The error thrown by the browser
 * @param {CredentialRequestOptions} params.options - The options passed to credentials.get()
 * @returns {WebAuthnError} A WebAuthnError with a specific error code
 * @see {@link https://w3c.github.io/webauthn/#sctn-getAssertion W3C WebAuthn Spec - Get Assertion}
 */
function identifyAuthenticationError({ error, options, }) {
    const { publicKey } = options;
    if (!publicKey) {
        throw Error('options was missing required publicKey property');
    }
    if (error.name === 'AbortError') {
        if (options.signal instanceof AbortSignal) {
            // https://www.w3.org/TR/webauthn-2/#sctn-createCredential (Step 16)
            return new WebAuthnError({
                message: 'Authentication ceremony was sent an abort signal',
                code: 'ERROR_CEREMONY_ABORTED',
                cause: error,
            });
        }
    }
    else if (error.name === 'NotAllowedError') {
        /**
         * Pass the error directly through. Platforms are overloading this error beyond what the spec
         * defines and we don't want to overwrite potentially useful error messages.
         */
        return new WebAuthnError({
            message: error.message,
            code: 'ERROR_PASSTHROUGH_SEE_CAUSE_PROPERTY',
            cause: error,
        });
    }
    else if (error.name === 'SecurityError') {
        const effectiveDomain = window.location.hostname;
        if (!(0, webauthn_1.isValidDomain)(effectiveDomain)) {
            // https://www.w3.org/TR/webauthn-2/#sctn-discover-from-external-source (Step 5)
            return new WebAuthnError({
                message: `${window.location.hostname} is an invalid domain`,
                code: 'ERROR_INVALID_DOMAIN',
                cause: error,
            });
        }
        else if (publicKey.rpId !== effectiveDomain) {
            // https://www.w3.org/TR/webauthn-2/#sctn-discover-from-external-source (Step 6)
            return new WebAuthnError({
                message: `The RP ID "${publicKey.rpId}" is invalid for this domain`,
                code: 'ERROR_INVALID_RP_ID',
                cause: error,
            });
        }
    }
    else if (error.name === 'UnknownError') {
        // https://www.w3.org/TR/webauthn-2/#sctn-op-get-assertion (Step 1)
        // https://www.w3.org/TR/webauthn-2/#sctn-op-get-assertion (Step 12)
        return new WebAuthnError({
            message: 'The authenticator was unable to process the specified options, or could not create a new assertion signature',
            code: 'ERROR_AUTHENTICATOR_GENERAL_ERROR',
            cause: error,
        });
    }
    return new WebAuthnError({
        message: 'a Non-Webauthn related error has occurred',
        code: 'ERROR_PASSTHROUGH_SEE_CAUSE_PROPERTY',
        cause: error,
    });
}
//# sourceMappingURL=webauthn.errors.js.map

/***/ }),

/***/ 6025:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.WebAuthnApi = exports.DEFAULT_REQUEST_OPTIONS = exports.DEFAULT_CREATION_OPTIONS = exports.webAuthnAbortService = exports.WebAuthnAbortService = exports.identifyAuthenticationError = exports.identifyRegistrationError = exports.isWebAuthnError = exports.WebAuthnError = void 0;
exports.deserializeCredentialCreationOptions = deserializeCredentialCreationOptions;
exports.deserializeCredentialRequestOptions = deserializeCredentialRequestOptions;
exports.serializeCredentialCreationResponse = serializeCredentialCreationResponse;
exports.serializeCredentialRequestResponse = serializeCredentialRequestResponse;
exports.isValidDomain = isValidDomain;
exports.createCredential = createCredential;
exports.getCredential = getCredential;
exports.mergeCredentialCreationOptions = mergeCredentialCreationOptions;
exports.mergeCredentialRequestOptions = mergeCredentialRequestOptions;
const tslib_1 = __webpack_require__(1915);
const base64url_1 = __webpack_require__(7162);
const errors_1 = __webpack_require__(2268);
const helpers_1 = __webpack_require__(1742);
const webauthn_errors_1 = __webpack_require__(3098);
Object.defineProperty(exports, "identifyAuthenticationError", ({ enumerable: true, get: function () { return webauthn_errors_1.identifyAuthenticationError; } }));
Object.defineProperty(exports, "identifyRegistrationError", ({ enumerable: true, get: function () { return webauthn_errors_1.identifyRegistrationError; } }));
Object.defineProperty(exports, "isWebAuthnError", ({ enumerable: true, get: function () { return webauthn_errors_1.isWebAuthnError; } }));
Object.defineProperty(exports, "WebAuthnError", ({ enumerable: true, get: function () { return webauthn_errors_1.WebAuthnError; } }));
/**
 * WebAuthn abort service to manage ceremony cancellation.
 * Ensures only one WebAuthn ceremony is active at a time to prevent "operation already in progress" errors.
 *
 * @experimental This class is experimental and may change in future releases
 * @see {@link https://w3c.github.io/webauthn/#sctn-automation-webdriver-capability W3C WebAuthn Spec - Aborting Ceremonies}
 */
class WebAuthnAbortService {
    /**
     * Create an abort signal for a new WebAuthn operation.
     * Automatically cancels any existing operation.
     *
     * @returns {AbortSignal} Signal to pass to navigator.credentials.create() or .get()
     * @see {@link https://developer.mozilla.org/en-US/docs/Web/API/AbortSignal MDN - AbortSignal}
     */
    createNewAbortSignal() {
        // Abort any existing calls to navigator.credentials.create() or navigator.credentials.get()
        if (this.controller) {
            const abortError = new Error('Cancelling existing WebAuthn API call for new one');
            abortError.name = 'AbortError';
            this.controller.abort(abortError);
        }
        const newController = new AbortController();
        this.controller = newController;
        return newController.signal;
    }
    /**
     * Manually cancel the current WebAuthn operation.
     * Useful for cleaning up when user cancels or navigates away.
     *
     * @see {@link https://developer.mozilla.org/en-US/docs/Web/API/AbortController/abort MDN - AbortController.abort}
     */
    cancelCeremony() {
        if (this.controller) {
            const abortError = new Error('Manually cancelling existing WebAuthn API call');
            abortError.name = 'AbortError';
            this.controller.abort(abortError);
            this.controller = undefined;
        }
    }
}
exports.WebAuthnAbortService = WebAuthnAbortService;
/**
 * Singleton instance to ensure only one WebAuthn ceremony is active at a time.
 * This prevents "operation already in progress" errors when retrying WebAuthn operations.
 *
 * @experimental This instance is experimental and may change in future releases
 */
exports.webAuthnAbortService = new WebAuthnAbortService();
/**
 * Convert base64url encoded strings in WebAuthn credential creation options to ArrayBuffers
 * as required by the WebAuthn browser API.
 * Supports both native WebAuthn Level 3 parseCreationOptionsFromJSON and manual fallback.
 *
 * @param {ServerCredentialCreationOptions} options - JSON options from server with base64url encoded fields
 * @returns {PublicKeyCredentialCreationOptionsFuture} Options ready for navigator.credentials.create()
 * @see {@link https://w3c.github.io/webauthn/#sctn-parseCreationOptionsFromJSON W3C WebAuthn Spec - parseCreationOptionsFromJSON}
 */
function deserializeCredentialCreationOptions(options) {
    if (!options) {
        throw new Error('Credential creation options are required');
    }
    // Check if the native parseCreationOptionsFromJSON method is available
    if (typeof PublicKeyCredential !== 'undefined' &&
        'parseCreationOptionsFromJSON' in PublicKeyCredential &&
        typeof PublicKeyCredential
            .parseCreationOptionsFromJSON === 'function') {
        // Use the native WebAuthn Level 3 method
        return PublicKeyCredential.parseCreationOptionsFromJSON(
        /** we assert the options here as typescript still doesn't know about future webauthn types */
        options);
    }
    // Fallback to manual parsing for browsers that don't support the native method
    // Destructure to separate fields that need transformation
    const { challenge: challengeStr, user: userOpts, excludeCredentials } = options, restOptions = tslib_1.__rest(options
    // Convert challenge from base64url to ArrayBuffer
    , ["challenge", "user", "excludeCredentials"]);
    // Convert challenge from base64url to ArrayBuffer
    const challenge = (0, base64url_1.base64UrlToUint8Array)(challengeStr).buffer;
    // Convert user.id from base64url to ArrayBuffer
    const user = Object.assign(Object.assign({}, userOpts), { id: (0, base64url_1.base64UrlToUint8Array)(userOpts.id).buffer });
    // Build the result object
    const result = Object.assign(Object.assign({}, restOptions), { challenge,
        user });
    // Only add excludeCredentials if it exists
    if (excludeCredentials && excludeCredentials.length > 0) {
        result.excludeCredentials = new Array(excludeCredentials.length);
        for (let i = 0; i < excludeCredentials.length; i++) {
            const cred = excludeCredentials[i];
            result.excludeCredentials[i] = Object.assign(Object.assign({}, cred), { id: (0, base64url_1.base64UrlToUint8Array)(cred.id).buffer, type: cred.type || 'public-key', 
                // Cast transports to handle future transport types like "cable"
                transports: cred.transports });
        }
    }
    return result;
}
/**
 * Convert base64url encoded strings in WebAuthn credential request options to ArrayBuffers
 * as required by the WebAuthn browser API.
 * Supports both native WebAuthn Level 3 parseRequestOptionsFromJSON and manual fallback.
 *
 * @param {ServerCredentialRequestOptions} options - JSON options from server with base64url encoded fields
 * @returns {PublicKeyCredentialRequestOptionsFuture} Options ready for navigator.credentials.get()
 * @see {@link https://w3c.github.io/webauthn/#sctn-parseRequestOptionsFromJSON W3C WebAuthn Spec - parseRequestOptionsFromJSON}
 */
function deserializeCredentialRequestOptions(options) {
    if (!options) {
        throw new Error('Credential request options are required');
    }
    // Check if the native parseRequestOptionsFromJSON method is available
    if (typeof PublicKeyCredential !== 'undefined' &&
        'parseRequestOptionsFromJSON' in PublicKeyCredential &&
        typeof PublicKeyCredential
            .parseRequestOptionsFromJSON === 'function') {
        // Use the native WebAuthn Level 3 method
        return PublicKeyCredential.parseRequestOptionsFromJSON(options);
    }
    // Fallback to manual parsing for browsers that don't support the native method
    // Destructure to separate fields that need transformation
    const { challenge: challengeStr, allowCredentials } = options, restOptions = tslib_1.__rest(options
    // Convert challenge from base64url to ArrayBuffer
    , ["challenge", "allowCredentials"]);
    // Convert challenge from base64url to ArrayBuffer
    const challenge = (0, base64url_1.base64UrlToUint8Array)(challengeStr).buffer;
    // Build the result object
    const result = Object.assign(Object.assign({}, restOptions), { challenge });
    // Only add allowCredentials if it exists
    if (allowCredentials && allowCredentials.length > 0) {
        result.allowCredentials = new Array(allowCredentials.length);
        for (let i = 0; i < allowCredentials.length; i++) {
            const cred = allowCredentials[i];
            result.allowCredentials[i] = Object.assign(Object.assign({}, cred), { id: (0, base64url_1.base64UrlToUint8Array)(cred.id).buffer, type: cred.type || 'public-key', 
                // Cast transports to handle future transport types like "cable"
                transports: cred.transports });
        }
    }
    return result;
}
/**
 * Convert a registration/enrollment credential response to server format.
 * Serializes binary fields to base64url for JSON transmission.
 * Supports both native WebAuthn Level 3 toJSON and manual fallback.
 *
 * @param {RegistrationCredential} credential - Credential from navigator.credentials.create()
 * @returns {RegistrationResponseJSON} JSON-serializable credential for server
 * @see {@link https://w3c.github.io/webauthn/#dom-publickeycredential-tojson W3C WebAuthn Spec - toJSON}
 */
function serializeCredentialCreationResponse(credential) {
    var _a;
    // Check if the credential instance has the toJSON method
    if ('toJSON' in credential && typeof credential.toJSON === 'function') {
        // Use the native WebAuthn Level 3 method
        return credential.toJSON();
    }
    const credentialWithAttachment = credential;
    return {
        id: credential.id,
        rawId: credential.id,
        response: {
            attestationObject: (0, base64url_1.bytesToBase64URL)(new Uint8Array(credential.response.attestationObject)),
            clientDataJSON: (0, base64url_1.bytesToBase64URL)(new Uint8Array(credential.response.clientDataJSON)),
        },
        type: 'public-key',
        clientExtensionResults: credential.getClientExtensionResults(),
        // Convert null to undefined and cast to AuthenticatorAttachment type
        authenticatorAttachment: ((_a = credentialWithAttachment.authenticatorAttachment) !== null && _a !== void 0 ? _a : undefined),
    };
}
/**
 * Convert an authentication/verification credential response to server format.
 * Serializes binary fields to base64url for JSON transmission.
 * Supports both native WebAuthn Level 3 toJSON and manual fallback.
 *
 * @param {AuthenticationCredential} credential - Credential from navigator.credentials.get()
 * @returns {AuthenticationResponseJSON} JSON-serializable credential for server
 * @see {@link https://w3c.github.io/webauthn/#dom-publickeycredential-tojson W3C WebAuthn Spec - toJSON}
 */
function serializeCredentialRequestResponse(credential) {
    var _a;
    // Check if the credential instance has the toJSON method
    if ('toJSON' in credential && typeof credential.toJSON === 'function') {
        // Use the native WebAuthn Level 3 method
        return credential.toJSON();
    }
    // Fallback to manual conversion for browsers that don't support toJSON
    // Access authenticatorAttachment via type assertion to handle TypeScript version differences
    // @simplewebauthn/types includes this property but base TypeScript 4.7.4 doesn't
    const credentialWithAttachment = credential;
    const clientExtensionResults = credential.getClientExtensionResults();
    const assertionResponse = credential.response;
    return {
        id: credential.id,
        rawId: credential.id, // W3C spec expects rawId to match id for JSON format
        response: {
            authenticatorData: (0, base64url_1.bytesToBase64URL)(new Uint8Array(assertionResponse.authenticatorData)),
            clientDataJSON: (0, base64url_1.bytesToBase64URL)(new Uint8Array(assertionResponse.clientDataJSON)),
            signature: (0, base64url_1.bytesToBase64URL)(new Uint8Array(assertionResponse.signature)),
            userHandle: assertionResponse.userHandle
                ? (0, base64url_1.bytesToBase64URL)(new Uint8Array(assertionResponse.userHandle))
                : undefined,
        },
        type: 'public-key',
        clientExtensionResults,
        // Convert null to undefined and cast to AuthenticatorAttachment type
        authenticatorAttachment: ((_a = credentialWithAttachment.authenticatorAttachment) !== null && _a !== void 0 ? _a : undefined),
    };
}
/**
 * A simple test to determine if a hostname is a properly-formatted domain name.
 * Considers localhost valid for development environments.
 *
 * A "valid domain" is defined here: https://url.spec.whatwg.org/#valid-domain
 *
 * Regex sourced from here:
 * https://www.oreilly.com/library/view/regular-expressions-cookbook/9781449327453/ch08s15.html
 *
 * @param {string} hostname - The hostname to validate
 * @returns {boolean} True if valid domain or localhost
 * @see {@link https://url.spec.whatwg.org/#valid-domain WHATWG URL Spec - Valid Domain}
 */
function isValidDomain(hostname) {
    return (
    // Consider localhost valid as well since it's okay wrt Secure Contexts
    hostname === 'localhost' || /^([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}$/i.test(hostname));
}
/**
 * Determine if the browser is capable of WebAuthn.
 * Checks for necessary Web APIs: PublicKeyCredential and Credential Management.
 *
 * @returns {boolean} True if browser supports WebAuthn
 * @see {@link https://developer.mozilla.org/en-US/docs/Web/API/PublicKeyCredential#browser_compatibility MDN - PublicKeyCredential Browser Compatibility}
 */
function browserSupportsWebAuthn() {
    var _a, _b;
    return !!((0, helpers_1.isBrowser)() &&
        'PublicKeyCredential' in window &&
        window.PublicKeyCredential &&
        'credentials' in navigator &&
        typeof ((_a = navigator === null || navigator === void 0 ? void 0 : navigator.credentials) === null || _a === void 0 ? void 0 : _a.create) === 'function' &&
        typeof ((_b = navigator === null || navigator === void 0 ? void 0 : navigator.credentials) === null || _b === void 0 ? void 0 : _b.get) === 'function');
}
/**
 * Create a WebAuthn credential using the browser's credentials API.
 * Wraps navigator.credentials.create() with error handling.
 *
 * @param {CredentialCreationOptions} options - Options including publicKey parameters
 * @returns {Promise<RequestResult<RegistrationCredential, WebAuthnError>>} Created credential or error
 * @see {@link https://w3c.github.io/webauthn/#sctn-createCredential W3C WebAuthn Spec - Create Credential}
 * @see {@link https://developer.mozilla.org/en-US/docs/Web/API/CredentialsContainer/create MDN - credentials.create}
 */
async function createCredential(options) {
    try {
        const response = await navigator.credentials.create(
        /** we assert the type here until typescript types are updated */
        options);
        if (!response) {
            return {
                data: null,
                error: new webauthn_errors_1.WebAuthnUnknownError('Empty credential response', response),
            };
        }
        if (!(response instanceof PublicKeyCredential)) {
            return {
                data: null,
                error: new webauthn_errors_1.WebAuthnUnknownError('Browser returned unexpected credential type', response),
            };
        }
        return { data: response, error: null };
    }
    catch (err) {
        return {
            data: null,
            error: (0, webauthn_errors_1.identifyRegistrationError)({
                error: err,
                options,
            }),
        };
    }
}
/**
 * Get a WebAuthn credential using the browser's credentials API.
 * Wraps navigator.credentials.get() with error handling.
 *
 * @param {CredentialRequestOptions} options - Options including publicKey parameters
 * @returns {Promise<RequestResult<AuthenticationCredential, WebAuthnError>>} Retrieved credential or error
 * @see {@link https://w3c.github.io/webauthn/#sctn-getAssertion W3C WebAuthn Spec - Get Assertion}
 * @see {@link https://developer.mozilla.org/en-US/docs/Web/API/CredentialsContainer/get MDN - credentials.get}
 */
async function getCredential(options) {
    try {
        const response = await navigator.credentials.get(
        /** we assert the type here until typescript types are updated */
        options);
        if (!response) {
            return {
                data: null,
                error: new webauthn_errors_1.WebAuthnUnknownError('Empty credential response', response),
            };
        }
        if (!(response instanceof PublicKeyCredential)) {
            return {
                data: null,
                error: new webauthn_errors_1.WebAuthnUnknownError('Browser returned unexpected credential type', response),
            };
        }
        return { data: response, error: null };
    }
    catch (err) {
        return {
            data: null,
            error: (0, webauthn_errors_1.identifyAuthenticationError)({
                error: err,
                options,
            }),
        };
    }
}
exports.DEFAULT_CREATION_OPTIONS = {
    hints: ['security-key'],
    authenticatorSelection: {
        authenticatorAttachment: 'cross-platform',
        requireResidentKey: false,
        /** set to preferred because older yubikeys don't have PIN/Biometric */
        userVerification: 'preferred',
        residentKey: 'discouraged',
    },
    attestation: 'direct',
};
exports.DEFAULT_REQUEST_OPTIONS = {
    /** set to preferred because older yubikeys don't have PIN/Biometric */
    userVerification: 'preferred',
    hints: ['security-key'],
    attestation: 'direct',
};
function deepMerge(...sources) {
    const isObject = (val) => val !== null && typeof val === 'object' && !Array.isArray(val);
    const isArrayBufferLike = (val) => val instanceof ArrayBuffer || ArrayBuffer.isView(val);
    const result = {};
    for (const source of sources) {
        if (!source)
            continue;
        for (const key in source) {
            const value = source[key];
            if (value === undefined)
                continue;
            if (Array.isArray(value)) {
                // preserve array reference, including unions like AuthenticatorTransport[]
                result[key] = value;
            }
            else if (isArrayBufferLike(value)) {
                result[key] = value;
            }
            else if (isObject(value)) {
                const existing = result[key];
                if (isObject(existing)) {
                    result[key] = deepMerge(existing, value);
                }
                else {
                    result[key] = deepMerge(value);
                }
            }
            else {
                result[key] = value;
            }
        }
    }
    return result;
}
/**
 * Merges WebAuthn credential creation options with overrides.
 * Sets sensible defaults for authenticator selection and extensions.
 *
 * @param {PublicKeyCredentialCreationOptionsFuture} baseOptions - The base options from the server
 * @param {PublicKeyCredentialCreationOptionsFuture} overrides - Optional overrides to apply
 * @param {string} friendlyName - Optional friendly name for the credential
 * @returns {PublicKeyCredentialCreationOptionsFuture} Merged credential creation options
 * @see {@link https://w3c.github.io/webauthn/#dictdef-authenticatorselectioncriteria W3C WebAuthn Spec - AuthenticatorSelectionCriteria}
 */
function mergeCredentialCreationOptions(baseOptions, overrides) {
    return deepMerge(exports.DEFAULT_CREATION_OPTIONS, baseOptions, overrides || {});
}
/**
 * Merges WebAuthn credential request options with overrides.
 * Sets sensible defaults for user verification and hints.
 *
 * @param {PublicKeyCredentialRequestOptionsFuture} baseOptions - The base options from the server
 * @param {PublicKeyCredentialRequestOptionsFuture} overrides - Optional overrides to apply
 * @returns {PublicKeyCredentialRequestOptionsFuture} Merged credential request options
 * @see {@link https://w3c.github.io/webauthn/#dictdef-publickeycredentialrequestoptions W3C WebAuthn Spec - PublicKeyCredentialRequestOptions}
 */
function mergeCredentialRequestOptions(baseOptions, overrides) {
    return deepMerge(exports.DEFAULT_REQUEST_OPTIONS, baseOptions, overrides || {});
}
/**
 * WebAuthn API wrapper for Supabase Auth.
 * Provides methods for enrolling, challenging, verifying, authenticating, and registering WebAuthn credentials.
 *
 * @experimental This API is experimental and may change in future releases
 * @see {@link https://w3c.github.io/webauthn/ W3C WebAuthn Specification}
 * @see {@link https://developer.mozilla.org/en-US/docs/Web/API/Web_Authentication_API MDN - Web Authentication API}
 */
class WebAuthnApi {
    constructor(client) {
        this.client = client;
        // Bind all methods so they can be destructured
        this.enroll = this._enroll.bind(this);
        this.challenge = this._challenge.bind(this);
        this.verify = this._verify.bind(this);
        this.authenticate = this._authenticate.bind(this);
        this.register = this._register.bind(this);
    }
    /**
     * Enroll a new WebAuthn factor.
     * Creates an unverified WebAuthn factor that must be verified with a credential.
     *
     * @experimental This method is experimental and may change in future releases
     * @param {Omit<MFAEnrollWebauthnParams, 'factorType'>} params - Enrollment parameters (friendlyName required)
     * @returns {Promise<AuthMFAEnrollWebauthnResponse>} Enrolled factor details or error
     * @see {@link https://w3c.github.io/webauthn/#sctn-registering-a-new-credential W3C WebAuthn Spec - Registering a New Credential}
     */
    async _enroll(params) {
        return this.client.mfa.enroll(Object.assign(Object.assign({}, params), { factorType: 'webauthn' }));
    }
    /**
     * Challenge for WebAuthn credential creation or authentication.
     * Combines server challenge with browser credential operations.
     * Handles both registration (create) and authentication (request) flows.
     *
     * @experimental This method is experimental and may change in future releases
     * @param {MFAChallengeWebauthnParams & { friendlyName?: string; signal?: AbortSignal }} params - Challenge parameters including factorId
     * @param {Object} overrides - Allows you to override the parameters passed to navigator.credentials
     * @param {PublicKeyCredentialCreationOptionsFuture} overrides.create - Override options for credential creation
     * @param {PublicKeyCredentialRequestOptionsFuture} overrides.request - Override options for credential request
     * @returns {Promise<RequestResult>} Challenge response with credential or error
     * @see {@link https://w3c.github.io/webauthn/#sctn-credential-creation W3C WebAuthn Spec - Credential Creation}
     * @see {@link https://w3c.github.io/webauthn/#sctn-verifying-assertion W3C WebAuthn Spec - Verifying Assertion}
     */
    async _challenge({ factorId, webauthn, friendlyName, signal, }, overrides) {
        var _a;
        try {
            // Get challenge from server using the client's MFA methods
            const { data: challengeResponse, error: challengeError } = await this.client.mfa.challenge({
                factorId,
                webauthn,
            });
            if (!challengeResponse) {
                return { data: null, error: challengeError };
            }
            const abortSignal = signal !== null && signal !== void 0 ? signal : exports.webAuthnAbortService.createNewAbortSignal();
            /** webauthn will fail if either of the name/displayname are blank */
            if (challengeResponse.webauthn.type === 'create') {
                const { user } = challengeResponse.webauthn.credential_options.publicKey;
                if (!user.name) {
                    // Preserve original format: use friendlyName if provided, otherwise fetch fallback
                    // This maintains backward compatibility with the ${user.id}:${name} format
                    const nameToUse = friendlyName;
                    if (!nameToUse) {
                        // Only fetch user data if friendlyName is not provided (bug fix for null friendlyName)
                        const currentUser = await this.client.getUser();
                        const userData = currentUser.data.user;
                        const fallbackName = ((_a = userData === null || userData === void 0 ? void 0 : userData.user_metadata) === null || _a === void 0 ? void 0 : _a.name) || (userData === null || userData === void 0 ? void 0 : userData.email) || (userData === null || userData === void 0 ? void 0 : userData.id) || 'User';
                        user.name = `${user.id}:${fallbackName}`;
                    }
                    else {
                        user.name = `${user.id}:${nameToUse}`;
                    }
                }
                if (!user.displayName) {
                    user.displayName = user.name;
                }
            }
            switch (challengeResponse.webauthn.type) {
                case 'create': {
                    const options = mergeCredentialCreationOptions(challengeResponse.webauthn.credential_options.publicKey, overrides === null || overrides === void 0 ? void 0 : overrides.create);
                    const { data, error } = await createCredential({
                        publicKey: options,
                        signal: abortSignal,
                    });
                    if (data) {
                        return {
                            data: {
                                factorId,
                                challengeId: challengeResponse.id,
                                webauthn: {
                                    type: challengeResponse.webauthn.type,
                                    credential_response: data,
                                },
                            },
                            error: null,
                        };
                    }
                    return { data: null, error };
                }
                case 'request': {
                    const options = mergeCredentialRequestOptions(challengeResponse.webauthn.credential_options.publicKey, overrides === null || overrides === void 0 ? void 0 : overrides.request);
                    const { data, error } = await getCredential(Object.assign(Object.assign({}, challengeResponse.webauthn.credential_options), { publicKey: options, signal: abortSignal }));
                    if (data) {
                        return {
                            data: {
                                factorId,
                                challengeId: challengeResponse.id,
                                webauthn: {
                                    type: challengeResponse.webauthn.type,
                                    credential_response: data,
                                },
                            },
                            error: null,
                        };
                    }
                    return { data: null, error };
                }
            }
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return { data: null, error };
            }
            return {
                data: null,
                error: new errors_1.AuthUnknownError('Unexpected error in challenge', error),
            };
        }
    }
    /**
     * Verify a WebAuthn credential with the server.
     * Completes the WebAuthn ceremony by sending the credential to the server for verification.
     *
     * @experimental This method is experimental and may change in future releases
     * @param {Object} params - Verification parameters
     * @param {string} params.challengeId - ID of the challenge being verified
     * @param {string} params.factorId - ID of the WebAuthn factor
     * @param {MFAVerifyWebauthnParams<T>['webauthn']} params.webauthn - WebAuthn credential response
     * @returns {Promise<AuthMFAVerifyResponse>} Verification result with session or error
     * @see {@link https://w3c.github.io/webauthn/#sctn-verifying-assertion W3C WebAuthn Spec - Verifying an Authentication Assertion}
     * */
    async _verify({ challengeId, factorId, webauthn, }) {
        return this.client.mfa.verify({
            factorId,
            challengeId,
            webauthn: webauthn,
        });
    }
    /**
     * Complete WebAuthn authentication flow.
     * Performs challenge and verification in a single operation for existing credentials.
     *
     * @experimental This method is experimental and may change in future releases
     * @param {Object} params - Authentication parameters
     * @param {string} params.factorId - ID of the WebAuthn factor to authenticate with
     * @param {Object} params.webauthn - WebAuthn configuration
     * @param {string} params.webauthn.rpId - Relying Party ID (defaults to current hostname)
     * @param {string[]} params.webauthn.rpOrigins - Allowed origins (defaults to current origin)
     * @param {AbortSignal} params.webauthn.signal - Optional abort signal
     * @param {PublicKeyCredentialRequestOptionsFuture} overrides - Override options for navigator.credentials.get
     * @returns {Promise<RequestResult<AuthMFAVerifyResponseData, WebAuthnError | AuthError>>} Authentication result
     * @see {@link https://w3c.github.io/webauthn/#sctn-authentication W3C WebAuthn Spec - Authentication Ceremony}
     * @see {@link https://developer.mozilla.org/en-US/docs/Web/API/PublicKeyCredentialRequestOptions MDN - PublicKeyCredentialRequestOptions}
     */
    async _authenticate({ factorId, webauthn: { rpId = typeof window !== 'undefined' ? window.location.hostname : undefined, rpOrigins = typeof window !== 'undefined' ? [window.location.origin] : undefined, signal, } = {}, }, overrides) {
        if (!rpId) {
            return {
                data: null,
                error: new errors_1.AuthError('rpId is required for WebAuthn authentication'),
            };
        }
        try {
            if (!browserSupportsWebAuthn()) {
                return {
                    data: null,
                    error: new errors_1.AuthUnknownError('Browser does not support WebAuthn', null),
                };
            }
            // Get challenge and credential
            const { data: challengeResponse, error: challengeError } = await this.challenge({
                factorId,
                webauthn: { rpId, rpOrigins },
                signal,
            }, { request: overrides });
            if (!challengeResponse) {
                return { data: null, error: challengeError };
            }
            const { webauthn } = challengeResponse;
            // Verify credential
            return this._verify({
                factorId,
                challengeId: challengeResponse.challengeId,
                webauthn: {
                    type: webauthn.type,
                    rpId,
                    rpOrigins,
                    credential_response: webauthn.credential_response,
                },
            });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return { data: null, error };
            }
            return {
                data: null,
                error: new errors_1.AuthUnknownError('Unexpected error in authenticate', error),
            };
        }
    }
    /**
     * Complete WebAuthn registration flow.
     * Performs enrollment, challenge, and verification in a single operation for new credentials.
     *
     * @experimental This method is experimental and may change in future releases
     * @param {Object} params - Registration parameters
     * @param {string} params.friendlyName - User-friendly name for the credential
     * @param {string} params.rpId - Relying Party ID (defaults to current hostname)
     * @param {string[]} params.rpOrigins - Allowed origins (defaults to current origin)
     * @param {AbortSignal} params.signal - Optional abort signal
     * @param {PublicKeyCredentialCreationOptionsFuture} overrides - Override options for navigator.credentials.create
     * @returns {Promise<RequestResult<AuthMFAVerifyResponseData, WebAuthnError | AuthError>>} Registration result
     * @see {@link https://w3c.github.io/webauthn/#sctn-registering-a-new-credential W3C WebAuthn Spec - Registration Ceremony}
     * @see {@link https://developer.mozilla.org/en-US/docs/Web/API/PublicKeyCredentialCreationOptions MDN - PublicKeyCredentialCreationOptions}
     */
    async _register({ friendlyName, webauthn: { rpId = typeof window !== 'undefined' ? window.location.hostname : undefined, rpOrigins = typeof window !== 'undefined' ? [window.location.origin] : undefined, signal, } = {}, }, overrides) {
        if (!rpId) {
            return {
                data: null,
                error: new errors_1.AuthError('rpId is required for WebAuthn registration'),
            };
        }
        try {
            if (!browserSupportsWebAuthn()) {
                return {
                    data: null,
                    error: new errors_1.AuthUnknownError('Browser does not support WebAuthn', null),
                };
            }
            // Enroll factor
            const { data: factor, error: enrollError } = await this._enroll({
                friendlyName,
            });
            if (!factor) {
                await this.client.mfa
                    .listFactors()
                    .then((factors) => {
                    var _a;
                    return (_a = factors.data) === null || _a === void 0 ? void 0 : _a.all.find((v) => v.factor_type === 'webauthn' &&
                        v.friendly_name === friendlyName &&
                        v.status !== 'unverified');
                })
                    .then((factor) => (factor ? this.client.mfa.unenroll({ factorId: factor === null || factor === void 0 ? void 0 : factor.id }) : void 0));
                return { data: null, error: enrollError };
            }
            // Get challenge and create credential
            const { data: challengeResponse, error: challengeError } = await this._challenge({
                factorId: factor.id,
                friendlyName: factor.friendly_name,
                webauthn: { rpId, rpOrigins },
                signal,
            }, {
                create: overrides,
            });
            if (!challengeResponse) {
                return { data: null, error: challengeError };
            }
            return this._verify({
                factorId: factor.id,
                challengeId: challengeResponse.challengeId,
                webauthn: {
                    rpId,
                    rpOrigins,
                    type: challengeResponse.webauthn.type,
                    credential_response: challengeResponse.webauthn.credential_response,
                },
            });
        }
        catch (error) {
            if ((0, errors_1.isAuthError)(error)) {
                return { data: null, error };
            }
            return {
                data: null,
                error: new errors_1.AuthUnknownError('Unexpected error in register', error),
            };
        }
    }
}
exports.WebAuthnApi = WebAuthnApi;
//# sourceMappingURL=webauthn.js.map

/***/ }),

/***/ 4226:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.FunctionsClient = void 0;
const tslib_1 = __webpack_require__(1915);
const helper_1 = __webpack_require__(1233);
const types_1 = __webpack_require__(2816);
/**
 * Client for invoking Supabase Edge Functions.
 */
class FunctionsClient {
    /**
     * Creates a new Functions client bound to an Edge Functions URL.
     *
     * @example
     * ```ts
     * import { FunctionsClient, FunctionRegion } from '@supabase/functions-js'
     *
     * const functions = new FunctionsClient('https://xyzcompany.supabase.co/functions/v1', {
     *   headers: { apikey: 'public-anon-key' },
     *   region: FunctionRegion.UsEast1,
     * })
     * ```
     */
    constructor(url, { headers = {}, customFetch, region = types_1.FunctionRegion.Any, } = {}) {
        this.url = url;
        this.headers = headers;
        this.region = region;
        this.fetch = (0, helper_1.resolveFetch)(customFetch);
    }
    /**
     * Updates the authorization header
     * @param token - the new jwt token sent in the authorisation header
     * @example
     * ```ts
     * functions.setAuth(session.access_token)
     * ```
     */
    setAuth(token) {
        this.headers.Authorization = `Bearer ${token}`;
    }
    /**
     * Invokes a function
     * @param functionName - The name of the Function to invoke.
     * @param options - Options for invoking the Function.
     * @example
     * ```ts
     * const { data, error } = await functions.invoke('hello-world', {
     *   body: { name: 'Ada' },
     * })
     * ```
     */
    invoke(functionName_1) {
        return tslib_1.__awaiter(this, arguments, void 0, function* (functionName, options = {}) {
            var _a;
            let timeoutId;
            let timeoutController;
            try {
                const { headers, method, body: functionArgs, signal, timeout } = options;
                let _headers = {};
                let { region } = options;
                if (!region) {
                    region = this.region;
                }
                // Add region as query parameter using URL API
                const url = new URL(`${this.url}/${functionName}`);
                if (region && region !== 'any') {
                    _headers['x-region'] = region;
                    url.searchParams.set('forceFunctionRegion', region);
                }
                let body;
                if (functionArgs &&
                    ((headers && !Object.prototype.hasOwnProperty.call(headers, 'Content-Type')) || !headers)) {
                    if ((typeof Blob !== 'undefined' && functionArgs instanceof Blob) ||
                        functionArgs instanceof ArrayBuffer) {
                        // will work for File as File inherits Blob
                        // also works for ArrayBuffer as it is the same underlying structure as a Blob
                        _headers['Content-Type'] = 'application/octet-stream';
                        body = functionArgs;
                    }
                    else if (typeof functionArgs === 'string') {
                        // plain string
                        _headers['Content-Type'] = 'text/plain';
                        body = functionArgs;
                    }
                    else if (typeof FormData !== 'undefined' && functionArgs instanceof FormData) {
                        // don't set content-type headers
                        // Request will automatically add the right boundary value
                        body = functionArgs;
                    }
                    else {
                        // default, assume this is JSON
                        _headers['Content-Type'] = 'application/json';
                        body = JSON.stringify(functionArgs);
                    }
                }
                else {
                    if (functionArgs &&
                        typeof functionArgs !== 'string' &&
                        !(typeof Blob !== 'undefined' && functionArgs instanceof Blob) &&
                        !(functionArgs instanceof ArrayBuffer) &&
                        !(typeof FormData !== 'undefined' && functionArgs instanceof FormData)) {
                        body = JSON.stringify(functionArgs);
                    }
                    else {
                        body = functionArgs;
                    }
                }
                // Handle timeout by creating an AbortController
                let effectiveSignal = signal;
                if (timeout) {
                    timeoutController = new AbortController();
                    timeoutId = setTimeout(() => timeoutController.abort(), timeout);
                    // If user provided their own signal, we need to respect both
                    if (signal) {
                        effectiveSignal = timeoutController.signal;
                        // If the user's signal is aborted, abort our timeout controller too
                        signal.addEventListener('abort', () => timeoutController.abort());
                    }
                    else {
                        effectiveSignal = timeoutController.signal;
                    }
                }
                const response = yield this.fetch(url.toString(), {
                    method: method || 'POST',
                    // headers priority is (high to low):
                    // 1. invoke-level headers
                    // 2. client-level headers
                    // 3. default Content-Type header
                    headers: Object.assign(Object.assign(Object.assign({}, _headers), this.headers), headers),
                    body,
                    signal: effectiveSignal,
                }).catch((fetchError) => {
                    throw new types_1.FunctionsFetchError(fetchError);
                });
                const isRelayError = response.headers.get('x-relay-error');
                if (isRelayError && isRelayError === 'true') {
                    throw new types_1.FunctionsRelayError(response);
                }
                if (!response.ok) {
                    throw new types_1.FunctionsHttpError(response);
                }
                let responseType = ((_a = response.headers.get('Content-Type')) !== null && _a !== void 0 ? _a : 'text/plain').split(';')[0].trim();
                let data;
                if (responseType === 'application/json') {
                    data = yield response.json();
                }
                else if (responseType === 'application/octet-stream' ||
                    responseType === 'application/pdf') {
                    data = yield response.blob();
                }
                else if (responseType === 'text/event-stream') {
                    data = response;
                }
                else if (responseType === 'multipart/form-data') {
                    data = yield response.formData();
                }
                else {
                    // default to text
                    data = yield response.text();
                }
                return { data, error: null, response };
            }
            catch (error) {
                return {
                    data: null,
                    error,
                    response: error instanceof types_1.FunctionsHttpError || error instanceof types_1.FunctionsRelayError
                        ? error.context
                        : undefined,
                };
            }
            finally {
                // Clear the timeout if it was set
                if (timeoutId) {
                    clearTimeout(timeoutId);
                }
            }
        });
    }
}
exports.FunctionsClient = FunctionsClient;
//# sourceMappingURL=FunctionsClient.js.map

/***/ }),

/***/ 1233:
/***/ ((__unused_webpack_module, exports) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.resolveFetch = void 0;
const resolveFetch = (customFetch) => {
    if (customFetch) {
        return (...args) => customFetch(...args);
    }
    return (...args) => fetch(...args);
};
exports.resolveFetch = resolveFetch;
//# sourceMappingURL=helper.js.map

/***/ }),

/***/ 6927:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {

"use strict";
var __webpack_unused_export__;

__webpack_unused_export__ = ({ value: true });
__webpack_unused_export__ = __webpack_unused_export__ = __webpack_unused_export__ = __webpack_unused_export__ = __webpack_unused_export__ = exports.bE = void 0;
var FunctionsClient_1 = __webpack_require__(4226);
Object.defineProperty(exports, "bE", ({ enumerable: true, get: function () { return FunctionsClient_1.FunctionsClient; } }));
var types_1 = __webpack_require__(2816);
__webpack_unused_export__ = ({ enumerable: true, get: function () { return types_1.FunctionsError; } });
__webpack_unused_export__ = ({ enumerable: true, get: function () { return types_1.FunctionsFetchError; } });
__webpack_unused_export__ = ({ enumerable: true, get: function () { return types_1.FunctionsHttpError; } });
__webpack_unused_export__ = ({ enumerable: true, get: function () { return types_1.FunctionsRelayError; } });
__webpack_unused_export__ = ({ enumerable: true, get: function () { return types_1.FunctionRegion; } });
//# sourceMappingURL=index.js.map

/***/ }),

/***/ 2816:
/***/ ((__unused_webpack_module, exports) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.FunctionRegion = exports.FunctionsHttpError = exports.FunctionsRelayError = exports.FunctionsFetchError = exports.FunctionsError = void 0;
/**
 * Base error for Supabase Edge Function invocations.
 *
 * @example
 * ```ts
 * import { FunctionsError } from '@supabase/functions-js'
 *
 * throw new FunctionsError('Unexpected error invoking function', 'FunctionsError', {
 *   requestId: 'abc123',
 * })
 * ```
 */
class FunctionsError extends Error {
    constructor(message, name = 'FunctionsError', context) {
        super(message);
        this.name = name;
        this.context = context;
    }
}
exports.FunctionsError = FunctionsError;
/**
 * Error thrown when the network request to an Edge Function fails.
 *
 * @example
 * ```ts
 * import { FunctionsFetchError } from '@supabase/functions-js'
 *
 * throw new FunctionsFetchError({ requestId: 'abc123' })
 * ```
 */
class FunctionsFetchError extends FunctionsError {
    constructor(context) {
        super('Failed to send a request to the Edge Function', 'FunctionsFetchError', context);
    }
}
exports.FunctionsFetchError = FunctionsFetchError;
/**
 * Error thrown when the Supabase relay cannot reach the Edge Function.
 *
 * @example
 * ```ts
 * import { FunctionsRelayError } from '@supabase/functions-js'
 *
 * throw new FunctionsRelayError({ region: 'us-east-1' })
 * ```
 */
class FunctionsRelayError extends FunctionsError {
    constructor(context) {
        super('Relay Error invoking the Edge Function', 'FunctionsRelayError', context);
    }
}
exports.FunctionsRelayError = FunctionsRelayError;
/**
 * Error thrown when the Edge Function returns a non-2xx status code.
 *
 * @example
 * ```ts
 * import { FunctionsHttpError } from '@supabase/functions-js'
 *
 * throw new FunctionsHttpError({ status: 500 })
 * ```
 */
class FunctionsHttpError extends FunctionsError {
    constructor(context) {
        super('Edge Function returned a non-2xx status code', 'FunctionsHttpError', context);
    }
}
exports.FunctionsHttpError = FunctionsHttpError;
// Define the enum for the 'region' property
var FunctionRegion;
(function (FunctionRegion) {
    FunctionRegion["Any"] = "any";
    FunctionRegion["ApNortheast1"] = "ap-northeast-1";
    FunctionRegion["ApNortheast2"] = "ap-northeast-2";
    FunctionRegion["ApSouth1"] = "ap-south-1";
    FunctionRegion["ApSoutheast1"] = "ap-southeast-1";
    FunctionRegion["ApSoutheast2"] = "ap-southeast-2";
    FunctionRegion["CaCentral1"] = "ca-central-1";
    FunctionRegion["EuCentral1"] = "eu-central-1";
    FunctionRegion["EuWest1"] = "eu-west-1";
    FunctionRegion["EuWest2"] = "eu-west-2";
    FunctionRegion["EuWest3"] = "eu-west-3";
    FunctionRegion["SaEast1"] = "sa-east-1";
    FunctionRegion["UsEast1"] = "us-east-1";
    FunctionRegion["UsWest1"] = "us-west-1";
    FunctionRegion["UsWest2"] = "us-west-2";
})(FunctionRegion || (exports.FunctionRegion = FunctionRegion = {}));
//# sourceMappingURL=types.js.map

/***/ }),

/***/ 7974:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.REALTIME_CHANNEL_STATES = exports.REALTIME_SUBSCRIBE_STATES = exports.REALTIME_LISTEN_TYPES = exports.REALTIME_POSTGRES_CHANGES_LISTEN_EVENT = void 0;
const tslib_1 = __webpack_require__(1915);
const constants_1 = __webpack_require__(6218);
const push_1 = tslib_1.__importDefault(__webpack_require__(3917));
const timer_1 = tslib_1.__importDefault(__webpack_require__(8503));
const RealtimePresence_1 = tslib_1.__importDefault(__webpack_require__(7590));
const Transformers = tslib_1.__importStar(__webpack_require__(1921));
const transformers_1 = __webpack_require__(1921);
var REALTIME_POSTGRES_CHANGES_LISTEN_EVENT;
(function (REALTIME_POSTGRES_CHANGES_LISTEN_EVENT) {
    REALTIME_POSTGRES_CHANGES_LISTEN_EVENT["ALL"] = "*";
    REALTIME_POSTGRES_CHANGES_LISTEN_EVENT["INSERT"] = "INSERT";
    REALTIME_POSTGRES_CHANGES_LISTEN_EVENT["UPDATE"] = "UPDATE";
    REALTIME_POSTGRES_CHANGES_LISTEN_EVENT["DELETE"] = "DELETE";
})(REALTIME_POSTGRES_CHANGES_LISTEN_EVENT || (exports.REALTIME_POSTGRES_CHANGES_LISTEN_EVENT = REALTIME_POSTGRES_CHANGES_LISTEN_EVENT = {}));
var REALTIME_LISTEN_TYPES;
(function (REALTIME_LISTEN_TYPES) {
    REALTIME_LISTEN_TYPES["BROADCAST"] = "broadcast";
    REALTIME_LISTEN_TYPES["PRESENCE"] = "presence";
    REALTIME_LISTEN_TYPES["POSTGRES_CHANGES"] = "postgres_changes";
    REALTIME_LISTEN_TYPES["SYSTEM"] = "system";
})(REALTIME_LISTEN_TYPES || (exports.REALTIME_LISTEN_TYPES = REALTIME_LISTEN_TYPES = {}));
var REALTIME_SUBSCRIBE_STATES;
(function (REALTIME_SUBSCRIBE_STATES) {
    REALTIME_SUBSCRIBE_STATES["SUBSCRIBED"] = "SUBSCRIBED";
    REALTIME_SUBSCRIBE_STATES["TIMED_OUT"] = "TIMED_OUT";
    REALTIME_SUBSCRIBE_STATES["CLOSED"] = "CLOSED";
    REALTIME_SUBSCRIBE_STATES["CHANNEL_ERROR"] = "CHANNEL_ERROR";
})(REALTIME_SUBSCRIBE_STATES || (exports.REALTIME_SUBSCRIBE_STATES = REALTIME_SUBSCRIBE_STATES = {}));
exports.REALTIME_CHANNEL_STATES = constants_1.CHANNEL_STATES;
/** A channel is the basic building block of Realtime
 * and narrows the scope of data flow to subscribed clients.
 * You can think of a channel as a chatroom where participants are able to see who's online
 * and send and receive messages.
 */
class RealtimeChannel {
    /**
     * Creates a channel that can broadcast messages, sync presence, and listen to Postgres changes.
     *
     * The topic determines which realtime stream you are subscribing to. Config options let you
     * enable acknowledgement for broadcasts, presence tracking, or private channels.
     *
     * @example
     * ```ts
     * import RealtimeClient from '@supabase/realtime-js'
     *
     * const client = new RealtimeClient('https://xyzcompany.supabase.co/realtime/v1', {
     *   params: { apikey: 'public-anon-key' },
     * })
     * const channel = new RealtimeChannel('realtime:public:messages', { config: {} }, client)
     * ```
     */
    constructor(
    /** Topic name can be any string. */
    topic, params = { config: {} }, socket) {
        var _a, _b;
        this.topic = topic;
        this.params = params;
        this.socket = socket;
        this.bindings = {};
        this.state = constants_1.CHANNEL_STATES.closed;
        this.joinedOnce = false;
        this.pushBuffer = [];
        this.subTopic = topic.replace(/^realtime:/i, '');
        this.params.config = Object.assign({
            broadcast: { ack: false, self: false },
            presence: { key: '', enabled: false },
            private: false,
        }, params.config);
        this.timeout = this.socket.timeout;
        this.joinPush = new push_1.default(this, constants_1.CHANNEL_EVENTS.join, this.params, this.timeout);
        this.rejoinTimer = new timer_1.default(() => this._rejoinUntilConnected(), this.socket.reconnectAfterMs);
        this.joinPush.receive('ok', () => {
            this.state = constants_1.CHANNEL_STATES.joined;
            this.rejoinTimer.reset();
            this.pushBuffer.forEach((pushEvent) => pushEvent.send());
            this.pushBuffer = [];
        });
        this._onClose(() => {
            this.rejoinTimer.reset();
            this.socket.log('channel', `close ${this.topic} ${this._joinRef()}`);
            this.state = constants_1.CHANNEL_STATES.closed;
            this.socket._remove(this);
        });
        this._onError((reason) => {
            if (this._isLeaving() || this._isClosed()) {
                return;
            }
            this.socket.log('channel', `error ${this.topic}`, reason);
            this.state = constants_1.CHANNEL_STATES.errored;
            this.rejoinTimer.scheduleTimeout();
        });
        this.joinPush.receive('timeout', () => {
            if (!this._isJoining()) {
                return;
            }
            this.socket.log('channel', `timeout ${this.topic}`, this.joinPush.timeout);
            this.state = constants_1.CHANNEL_STATES.errored;
            this.rejoinTimer.scheduleTimeout();
        });
        this.joinPush.receive('error', (reason) => {
            if (this._isLeaving() || this._isClosed()) {
                return;
            }
            this.socket.log('channel', `error ${this.topic}`, reason);
            this.state = constants_1.CHANNEL_STATES.errored;
            this.rejoinTimer.scheduleTimeout();
        });
        this._on(constants_1.CHANNEL_EVENTS.reply, {}, (payload, ref) => {
            this._trigger(this._replyEventName(ref), payload);
        });
        this.presence = new RealtimePresence_1.default(this);
        this.broadcastEndpointURL = (0, transformers_1.httpEndpointURL)(this.socket.endPoint);
        this.private = this.params.config.private || false;
        if (!this.private && ((_b = (_a = this.params.config) === null || _a === void 0 ? void 0 : _a.broadcast) === null || _b === void 0 ? void 0 : _b.replay)) {
            throw `tried to use replay on public channel '${this.topic}'. It must be a private channel.`;
        }
    }
    /** Subscribe registers your client with the server */
    subscribe(callback, timeout = this.timeout) {
        var _a, _b, _c;
        if (!this.socket.isConnected()) {
            this.socket.connect();
        }
        if (this.state == constants_1.CHANNEL_STATES.closed) {
            const { config: { broadcast, presence, private: isPrivate }, } = this.params;
            const postgres_changes = (_b = (_a = this.bindings.postgres_changes) === null || _a === void 0 ? void 0 : _a.map((r) => r.filter)) !== null && _b !== void 0 ? _b : [];
            const presence_enabled = (!!this.bindings[REALTIME_LISTEN_TYPES.PRESENCE] &&
                this.bindings[REALTIME_LISTEN_TYPES.PRESENCE].length > 0) ||
                ((_c = this.params.config.presence) === null || _c === void 0 ? void 0 : _c.enabled) === true;
            const accessTokenPayload = {};
            const config = {
                broadcast,
                presence: Object.assign(Object.assign({}, presence), { enabled: presence_enabled }),
                postgres_changes,
                private: isPrivate,
            };
            if (this.socket.accessTokenValue) {
                accessTokenPayload.access_token = this.socket.accessTokenValue;
            }
            this._onError((e) => callback === null || callback === void 0 ? void 0 : callback(REALTIME_SUBSCRIBE_STATES.CHANNEL_ERROR, e));
            this._onClose(() => callback === null || callback === void 0 ? void 0 : callback(REALTIME_SUBSCRIBE_STATES.CLOSED));
            this.updateJoinPayload(Object.assign({ config }, accessTokenPayload));
            this.joinedOnce = true;
            this._rejoin(timeout);
            this.joinPush
                .receive('ok', async ({ postgres_changes }) => {
                var _a;
                // Only refresh auth if using callback-based tokens
                if (!this.socket._isManualToken()) {
                    this.socket.setAuth();
                }
                if (postgres_changes === undefined) {
                    callback === null || callback === void 0 ? void 0 : callback(REALTIME_SUBSCRIBE_STATES.SUBSCRIBED);
                    return;
                }
                else {
                    const clientPostgresBindings = this.bindings.postgres_changes;
                    const bindingsLen = (_a = clientPostgresBindings === null || clientPostgresBindings === void 0 ? void 0 : clientPostgresBindings.length) !== null && _a !== void 0 ? _a : 0;
                    const newPostgresBindings = [];
                    for (let i = 0; i < bindingsLen; i++) {
                        const clientPostgresBinding = clientPostgresBindings[i];
                        const { filter: { event, schema, table, filter }, } = clientPostgresBinding;
                        const serverPostgresFilter = postgres_changes && postgres_changes[i];
                        if (serverPostgresFilter &&
                            serverPostgresFilter.event === event &&
                            RealtimeChannel.isFilterValueEqual(serverPostgresFilter.schema, schema) &&
                            RealtimeChannel.isFilterValueEqual(serverPostgresFilter.table, table) &&
                            RealtimeChannel.isFilterValueEqual(serverPostgresFilter.filter, filter)) {
                            newPostgresBindings.push(Object.assign(Object.assign({}, clientPostgresBinding), { id: serverPostgresFilter.id }));
                        }
                        else {
                            this.unsubscribe();
                            this.state = constants_1.CHANNEL_STATES.errored;
                            callback === null || callback === void 0 ? void 0 : callback(REALTIME_SUBSCRIBE_STATES.CHANNEL_ERROR, new Error('mismatch between server and client bindings for postgres changes'));
                            return;
                        }
                    }
                    this.bindings.postgres_changes = newPostgresBindings;
                    callback && callback(REALTIME_SUBSCRIBE_STATES.SUBSCRIBED);
                    return;
                }
            })
                .receive('error', (error) => {
                this.state = constants_1.CHANNEL_STATES.errored;
                callback === null || callback === void 0 ? void 0 : callback(REALTIME_SUBSCRIBE_STATES.CHANNEL_ERROR, new Error(JSON.stringify(Object.values(error).join(', ') || 'error')));
                return;
            })
                .receive('timeout', () => {
                callback === null || callback === void 0 ? void 0 : callback(REALTIME_SUBSCRIBE_STATES.TIMED_OUT);
                return;
            });
        }
        return this;
    }
    /**
     * Returns the current presence state for this channel.
     *
     * The shape is a map keyed by presence key (for example a user id) where each entry contains the
     * tracked metadata for that user.
     */
    presenceState() {
        return this.presence.state;
    }
    /**
     * Sends the supplied payload to the presence tracker so other subscribers can see that this
     * client is online. Use `untrack` to stop broadcasting presence for the same key.
     */
    async track(payload, opts = {}) {
        return await this.send({
            type: 'presence',
            event: 'track',
            payload,
        }, opts.timeout || this.timeout);
    }
    /**
     * Removes the current presence state for this client.
     */
    async untrack(opts = {}) {
        return await this.send({
            type: 'presence',
            event: 'untrack',
        }, opts);
    }
    on(type, filter, callback) {
        if (this.state === constants_1.CHANNEL_STATES.joined && type === REALTIME_LISTEN_TYPES.PRESENCE) {
            this.socket.log('channel', `resubscribe to ${this.topic} due to change in presence callbacks on joined channel`);
            this.unsubscribe().then(async () => await this.subscribe());
        }
        return this._on(type, filter, callback);
    }
    /**
     * Sends a broadcast message explicitly via REST API.
     *
     * This method always uses the REST API endpoint regardless of WebSocket connection state.
     * Useful when you want to guarantee REST delivery or when gradually migrating from implicit REST fallback.
     *
     * @param event The name of the broadcast event
     * @param payload Payload to be sent (required)
     * @param opts Options including timeout
     * @returns Promise resolving to object with success status, and error details if failed
     */
    async httpSend(event, payload, opts = {}) {
        var _a;
        if (payload === undefined || payload === null) {
            return Promise.reject('Payload is required for httpSend()');
        }
        const headers = {
            apikey: this.socket.apiKey ? this.socket.apiKey : '',
            'Content-Type': 'application/json',
        };
        if (this.socket.accessTokenValue) {
            headers['Authorization'] = `Bearer ${this.socket.accessTokenValue}`;
        }
        const options = {
            method: 'POST',
            headers,
            body: JSON.stringify({
                messages: [
                    {
                        topic: this.subTopic,
                        event,
                        payload: payload,
                        private: this.private,
                    },
                ],
            }),
        };
        const response = await this._fetchWithTimeout(this.broadcastEndpointURL, options, (_a = opts.timeout) !== null && _a !== void 0 ? _a : this.timeout);
        if (response.status === 202) {
            return { success: true };
        }
        let errorMessage = response.statusText;
        try {
            const errorBody = await response.json();
            errorMessage = errorBody.error || errorBody.message || errorMessage;
        }
        catch (_b) { }
        return Promise.reject(new Error(errorMessage));
    }
    /**
     * Sends a message into the channel.
     *
     * @param args Arguments to send to channel
     * @param args.type The type of event to send
     * @param args.event The name of the event being sent
     * @param args.payload Payload to be sent
     * @param opts Options to be used during the send process
     */
    async send(args, opts = {}) {
        var _a, _b;
        if (!this._canPush() && args.type === 'broadcast') {
            console.warn('Realtime send() is automatically falling back to REST API. ' +
                'This behavior will be deprecated in the future. ' +
                'Please use httpSend() explicitly for REST delivery.');
            const { event, payload: endpoint_payload } = args;
            const headers = {
                apikey: this.socket.apiKey ? this.socket.apiKey : '',
                'Content-Type': 'application/json',
            };
            if (this.socket.accessTokenValue) {
                headers['Authorization'] = `Bearer ${this.socket.accessTokenValue}`;
            }
            const options = {
                method: 'POST',
                headers,
                body: JSON.stringify({
                    messages: [
                        {
                            topic: this.subTopic,
                            event,
                            payload: endpoint_payload,
                            private: this.private,
                        },
                    ],
                }),
            };
            try {
                const response = await this._fetchWithTimeout(this.broadcastEndpointURL, options, (_a = opts.timeout) !== null && _a !== void 0 ? _a : this.timeout);
                await ((_b = response.body) === null || _b === void 0 ? void 0 : _b.cancel());
                return response.ok ? 'ok' : 'error';
            }
            catch (error) {
                if (error.name === 'AbortError') {
                    return 'timed out';
                }
                else {
                    return 'error';
                }
            }
        }
        else {
            return new Promise((resolve) => {
                var _a, _b, _c;
                const push = this._push(args.type, args, opts.timeout || this.timeout);
                if (args.type === 'broadcast' && !((_c = (_b = (_a = this.params) === null || _a === void 0 ? void 0 : _a.config) === null || _b === void 0 ? void 0 : _b.broadcast) === null || _c === void 0 ? void 0 : _c.ack)) {
                    resolve('ok');
                }
                push.receive('ok', () => resolve('ok'));
                push.receive('error', () => resolve('error'));
                push.receive('timeout', () => resolve('timed out'));
            });
        }
    }
    /**
     * Updates the payload that will be sent the next time the channel joins (reconnects).
     * Useful for rotating access tokens or updating config without re-creating the channel.
     */
    updateJoinPayload(payload) {
        this.joinPush.updatePayload(payload);
    }
    /**
     * Leaves the channel.
     *
     * Unsubscribes from server events, and instructs channel to terminate on server.
     * Triggers onClose() hooks.
     *
     * To receive leave acknowledgements, use the a `receive` hook to bind to the server ack, ie:
     * channel.unsubscribe().receive("ok", () => alert("left!") )
     */
    unsubscribe(timeout = this.timeout) {
        this.state = constants_1.CHANNEL_STATES.leaving;
        const onClose = () => {
            this.socket.log('channel', `leave ${this.topic}`);
            this._trigger(constants_1.CHANNEL_EVENTS.close, 'leave', this._joinRef());
        };
        this.joinPush.destroy();
        let leavePush = null;
        return new Promise((resolve) => {
            leavePush = new push_1.default(this, constants_1.CHANNEL_EVENTS.leave, {}, timeout);
            leavePush
                .receive('ok', () => {
                onClose();
                resolve('ok');
            })
                .receive('timeout', () => {
                onClose();
                resolve('timed out');
            })
                .receive('error', () => {
                resolve('error');
            });
            leavePush.send();
            if (!this._canPush()) {
                leavePush.trigger('ok', {});
            }
        }).finally(() => {
            leavePush === null || leavePush === void 0 ? void 0 : leavePush.destroy();
        });
    }
    /**
     * Teardown the channel.
     *
     * Destroys and stops related timers.
     */
    teardown() {
        this.pushBuffer.forEach((push) => push.destroy());
        this.pushBuffer = [];
        this.rejoinTimer.reset();
        this.joinPush.destroy();
        this.state = constants_1.CHANNEL_STATES.closed;
        this.bindings = {};
    }
    /** @internal */
    async _fetchWithTimeout(url, options, timeout) {
        const controller = new AbortController();
        const id = setTimeout(() => controller.abort(), timeout);
        const response = await this.socket.fetch(url, Object.assign(Object.assign({}, options), { signal: controller.signal }));
        clearTimeout(id);
        return response;
    }
    /** @internal */
    _push(event, payload, timeout = this.timeout) {
        if (!this.joinedOnce) {
            throw `tried to push '${event}' to '${this.topic}' before joining. Use channel.subscribe() before pushing events`;
        }
        let pushEvent = new push_1.default(this, event, payload, timeout);
        if (this._canPush()) {
            pushEvent.send();
        }
        else {
            this._addToPushBuffer(pushEvent);
        }
        return pushEvent;
    }
    /** @internal */
    _addToPushBuffer(pushEvent) {
        pushEvent.startTimeout();
        this.pushBuffer.push(pushEvent);
        // Enforce buffer size limit
        if (this.pushBuffer.length > constants_1.MAX_PUSH_BUFFER_SIZE) {
            const removedPush = this.pushBuffer.shift();
            if (removedPush) {
                removedPush.destroy();
                this.socket.log('channel', `discarded push due to buffer overflow: ${removedPush.event}`, removedPush.payload);
            }
        }
    }
    /**
     * Overridable message hook
     *
     * Receives all events for specialized message handling before dispatching to the channel callbacks.
     * Must return the payload, modified or unmodified.
     *
     * @internal
     */
    _onMessage(_event, payload, _ref) {
        return payload;
    }
    /** @internal */
    _isMember(topic) {
        return this.topic === topic;
    }
    /** @internal */
    _joinRef() {
        return this.joinPush.ref;
    }
    /** @internal */
    _trigger(type, payload, ref) {
        var _a, _b;
        const typeLower = type.toLocaleLowerCase();
        const { close, error, leave, join } = constants_1.CHANNEL_EVENTS;
        const events = [close, error, leave, join];
        if (ref && events.indexOf(typeLower) >= 0 && ref !== this._joinRef()) {
            return;
        }
        let handledPayload = this._onMessage(typeLower, payload, ref);
        if (payload && !handledPayload) {
            throw 'channel onMessage callbacks must return the payload, modified or unmodified';
        }
        if (['insert', 'update', 'delete'].includes(typeLower)) {
            (_a = this.bindings.postgres_changes) === null || _a === void 0 ? void 0 : _a.filter((bind) => {
                var _a, _b, _c;
                return ((_a = bind.filter) === null || _a === void 0 ? void 0 : _a.event) === '*' || ((_c = (_b = bind.filter) === null || _b === void 0 ? void 0 : _b.event) === null || _c === void 0 ? void 0 : _c.toLocaleLowerCase()) === typeLower;
            }).map((bind) => bind.callback(handledPayload, ref));
        }
        else {
            (_b = this.bindings[typeLower]) === null || _b === void 0 ? void 0 : _b.filter((bind) => {
                var _a, _b, _c, _d, _e, _f;
                if (['broadcast', 'presence', 'postgres_changes'].includes(typeLower)) {
                    if ('id' in bind) {
                        const bindId = bind.id;
                        const bindEvent = (_a = bind.filter) === null || _a === void 0 ? void 0 : _a.event;
                        return (bindId &&
                            ((_b = payload.ids) === null || _b === void 0 ? void 0 : _b.includes(bindId)) &&
                            (bindEvent === '*' ||
                                (bindEvent === null || bindEvent === void 0 ? void 0 : bindEvent.toLocaleLowerCase()) === ((_c = payload.data) === null || _c === void 0 ? void 0 : _c.type.toLocaleLowerCase())));
                    }
                    else {
                        const bindEvent = (_e = (_d = bind === null || bind === void 0 ? void 0 : bind.filter) === null || _d === void 0 ? void 0 : _d.event) === null || _e === void 0 ? void 0 : _e.toLocaleLowerCase();
                        return bindEvent === '*' || bindEvent === ((_f = payload === null || payload === void 0 ? void 0 : payload.event) === null || _f === void 0 ? void 0 : _f.toLocaleLowerCase());
                    }
                }
                else {
                    return bind.type.toLocaleLowerCase() === typeLower;
                }
            }).map((bind) => {
                if (typeof handledPayload === 'object' && 'ids' in handledPayload) {
                    const postgresChanges = handledPayload.data;
                    const { schema, table, commit_timestamp, type, errors } = postgresChanges;
                    const enrichedPayload = {
                        schema: schema,
                        table: table,
                        commit_timestamp: commit_timestamp,
                        eventType: type,
                        new: {},
                        old: {},
                        errors: errors,
                    };
                    handledPayload = Object.assign(Object.assign({}, enrichedPayload), this._getPayloadRecords(postgresChanges));
                }
                bind.callback(handledPayload, ref);
            });
        }
    }
    /** @internal */
    _isClosed() {
        return this.state === constants_1.CHANNEL_STATES.closed;
    }
    /** @internal */
    _isJoined() {
        return this.state === constants_1.CHANNEL_STATES.joined;
    }
    /** @internal */
    _isJoining() {
        return this.state === constants_1.CHANNEL_STATES.joining;
    }
    /** @internal */
    _isLeaving() {
        return this.state === constants_1.CHANNEL_STATES.leaving;
    }
    /** @internal */
    _replyEventName(ref) {
        return `chan_reply_${ref}`;
    }
    /** @internal */
    _on(type, filter, callback) {
        const typeLower = type.toLocaleLowerCase();
        const binding = {
            type: typeLower,
            filter: filter,
            callback: callback,
        };
        if (this.bindings[typeLower]) {
            this.bindings[typeLower].push(binding);
        }
        else {
            this.bindings[typeLower] = [binding];
        }
        return this;
    }
    /** @internal */
    _off(type, filter) {
        const typeLower = type.toLocaleLowerCase();
        if (this.bindings[typeLower]) {
            this.bindings[typeLower] = this.bindings[typeLower].filter((bind) => {
                var _a;
                return !(((_a = bind.type) === null || _a === void 0 ? void 0 : _a.toLocaleLowerCase()) === typeLower &&
                    RealtimeChannel.isEqual(bind.filter, filter));
            });
        }
        return this;
    }
    /** @internal */
    static isEqual(obj1, obj2) {
        if (Object.keys(obj1).length !== Object.keys(obj2).length) {
            return false;
        }
        for (const k in obj1) {
            if (obj1[k] !== obj2[k]) {
                return false;
            }
        }
        return true;
    }
    /**
     * Compares two optional filter values for equality.
     * Treats undefined, null, and empty string as equivalent empty values.
     * @internal
     */
    static isFilterValueEqual(serverValue, clientValue) {
        const normalizedServer = serverValue !== null && serverValue !== void 0 ? serverValue : undefined;
        const normalizedClient = clientValue !== null && clientValue !== void 0 ? clientValue : undefined;
        return normalizedServer === normalizedClient;
    }
    /** @internal */
    _rejoinUntilConnected() {
        this.rejoinTimer.scheduleTimeout();
        if (this.socket.isConnected()) {
            this._rejoin();
        }
    }
    /**
     * Registers a callback that will be executed when the channel closes.
     *
     * @internal
     */
    _onClose(callback) {
        this._on(constants_1.CHANNEL_EVENTS.close, {}, callback);
    }
    /**
     * Registers a callback that will be executed when the channel encounteres an error.
     *
     * @internal
     */
    _onError(callback) {
        this._on(constants_1.CHANNEL_EVENTS.error, {}, (reason) => callback(reason));
    }
    /**
     * Returns `true` if the socket is connected and the channel has been joined.
     *
     * @internal
     */
    _canPush() {
        return this.socket.isConnected() && this._isJoined();
    }
    /** @internal */
    _rejoin(timeout = this.timeout) {
        if (this._isLeaving()) {
            return;
        }
        this.socket._leaveOpenTopic(this.topic);
        this.state = constants_1.CHANNEL_STATES.joining;
        this.joinPush.resend(timeout);
    }
    /** @internal */
    _getPayloadRecords(payload) {
        const records = {
            new: {},
            old: {},
        };
        if (payload.type === 'INSERT' || payload.type === 'UPDATE') {
            records.new = Transformers.convertChangeData(payload.columns, payload.record);
        }
        if (payload.type === 'UPDATE' || payload.type === 'DELETE') {
            records.old = Transformers.convertChangeData(payload.columns, payload.old_record);
        }
        return records;
    }
}
exports["default"] = RealtimeChannel;
//# sourceMappingURL=RealtimeChannel.js.map

/***/ }),

/***/ 9230:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({ value: true }));
const tslib_1 = __webpack_require__(1915);
const websocket_factory_1 = tslib_1.__importDefault(__webpack_require__(2643));
const constants_1 = __webpack_require__(6218);
const serializer_1 = tslib_1.__importDefault(__webpack_require__(3148));
const timer_1 = tslib_1.__importDefault(__webpack_require__(8503));
const transformers_1 = __webpack_require__(1921);
const RealtimeChannel_1 = tslib_1.__importDefault(__webpack_require__(7974));
const noop = () => { };
// Connection-related constants
const CONNECTION_TIMEOUTS = {
    HEARTBEAT_INTERVAL: 25000,
    RECONNECT_DELAY: 10,
    HEARTBEAT_TIMEOUT_FALLBACK: 100,
};
const RECONNECT_INTERVALS = [1000, 2000, 5000, 10000];
const DEFAULT_RECONNECT_FALLBACK = 10000;
const WORKER_SCRIPT = `
  addEventListener("message", (e) => {
    if (e.data.event === "start") {
      setInterval(() => postMessage({ event: "keepAlive" }), e.data.interval);
    }
  });`;
class RealtimeClient {
    /**
     * Initializes the Socket.
     *
     * @param endPoint The string WebSocket endpoint, ie, "ws://example.com/socket", "wss://example.com", "/socket" (inherited host & protocol)
     * @param httpEndpoint The string HTTP endpoint, ie, "https://example.com", "/" (inherited host & protocol)
     * @param options.transport The Websocket Transport, for example WebSocket. This can be a custom implementation
     * @param options.timeout The default timeout in milliseconds to trigger push timeouts.
     * @param options.params The optional params to pass when connecting.
     * @param options.headers Deprecated: headers cannot be set on websocket connections and this option will be removed in the future.
     * @param options.heartbeatIntervalMs The millisec interval to send a heartbeat message.
     * @param options.heartbeatCallback The optional function to handle heartbeat status and latency.
     * @param options.logger The optional function for specialized logging, ie: logger: (kind, msg, data) => { console.log(`${kind}: ${msg}`, data) }
     * @param options.logLevel Sets the log level for Realtime
     * @param options.encode The function to encode outgoing messages. Defaults to JSON: (payload, callback) => callback(JSON.stringify(payload))
     * @param options.decode The function to decode incoming messages. Defaults to Serializer's decode.
     * @param options.reconnectAfterMs he optional function that returns the millsec reconnect interval. Defaults to stepped backoff off.
     * @param options.worker Use Web Worker to set a side flow. Defaults to false.
     * @param options.workerUrl The URL of the worker script. Defaults to https://realtime.supabase.com/worker.js that includes a heartbeat event call to keep the connection alive.
     * @param options.vsn The protocol version to use when connecting. Supported versions are "1.0.0" and "2.0.0". Defaults to "2.0.0".
     * @example
     * ```ts
     * import RealtimeClient from '@supabase/realtime-js'
     *
     * const client = new RealtimeClient('https://xyzcompany.supabase.co/realtime/v1', {
     *   params: { apikey: 'public-anon-key' },
     * })
     * client.connect()
     * ```
     */
    constructor(endPoint, options) {
        var _a;
        this.accessTokenValue = null;
        this.apiKey = null;
        this._manuallySetToken = false;
        this.channels = new Array();
        this.endPoint = '';
        this.httpEndpoint = '';
        /** @deprecated headers cannot be set on websocket connections */
        this.headers = {};
        this.params = {};
        this.timeout = constants_1.DEFAULT_TIMEOUT;
        this.transport = null;
        this.heartbeatIntervalMs = CONNECTION_TIMEOUTS.HEARTBEAT_INTERVAL;
        this.heartbeatTimer = undefined;
        this.pendingHeartbeatRef = null;
        this.heartbeatCallback = noop;
        this.ref = 0;
        this.reconnectTimer = null;
        this.vsn = constants_1.DEFAULT_VSN;
        this.logger = noop;
        this.conn = null;
        this.sendBuffer = [];
        this.serializer = new serializer_1.default();
        this.stateChangeCallbacks = {
            open: [],
            close: [],
            error: [],
            message: [],
        };
        this.accessToken = null;
        this._connectionState = 'disconnected';
        this._wasManualDisconnect = false;
        this._authPromise = null;
        this._heartbeatSentAt = null;
        /**
         * Use either custom fetch, if provided, or default fetch to make HTTP requests
         *
         * @internal
         */
        this._resolveFetch = (customFetch) => {
            if (customFetch) {
                return (...args) => customFetch(...args);
            }
            return (...args) => fetch(...args);
        };
        // Validate required parameters
        if (!((_a = options === null || options === void 0 ? void 0 : options.params) === null || _a === void 0 ? void 0 : _a.apikey)) {
            throw new Error('API key is required to connect to Realtime');
        }
        this.apiKey = options.params.apikey;
        // Initialize endpoint URLs
        this.endPoint = `${endPoint}/${constants_1.TRANSPORTS.websocket}`;
        this.httpEndpoint = (0, transformers_1.httpEndpointURL)(endPoint);
        this._initializeOptions(options);
        this._setupReconnectionTimer();
        this.fetch = this._resolveFetch(options === null || options === void 0 ? void 0 : options.fetch);
    }
    /**
     * Connects the socket, unless already connected.
     */
    connect() {
        // Skip if already connecting, disconnecting, or connected
        if (this.isConnecting() ||
            this.isDisconnecting() ||
            (this.conn !== null && this.isConnected())) {
            return;
        }
        this._setConnectionState('connecting');
        // Trigger auth if needed and not already in progress
        // This ensures auth is called for standalone RealtimeClient usage
        // while avoiding race conditions with SupabaseClient's immediate setAuth call
        if (this.accessToken && !this._authPromise) {
            this._setAuthSafely('connect');
        }
        // Establish WebSocket connection
        if (this.transport) {
            // Use custom transport if provided
            this.conn = new this.transport(this.endpointURL());
        }
        else {
            // Try to use native WebSocket
            try {
                this.conn = websocket_factory_1.default.createWebSocket(this.endpointURL());
            }
            catch (error) {
                this._setConnectionState('disconnected');
                const errorMessage = error.message;
                // Provide helpful error message based on environment
                if (errorMessage.includes('Node.js')) {
                    throw new Error(`${errorMessage}\n\n` +
                        'To use Realtime in Node.js, you need to provide a WebSocket implementation:\n\n' +
                        'Option 1: Use Node.js 22+ which has native WebSocket support\n' +
                        'Option 2: Install and provide the "ws" package:\n\n' +
                        '  npm install ws\n\n' +
                        '  import ws from "ws"\n' +
                        '  const client = new RealtimeClient(url, {\n' +
                        '    ...options,\n' +
                        '    transport: ws\n' +
                        '  })');
                }
                throw new Error(`WebSocket not available: ${errorMessage}`);
            }
        }
        this._setupConnectionHandlers();
    }
    /**
     * Returns the URL of the websocket.
     * @returns string The URL of the websocket.
     */
    endpointURL() {
        return this._appendParams(this.endPoint, Object.assign({}, this.params, { vsn: this.vsn }));
    }
    /**
     * Disconnects the socket.
     *
     * @param code A numeric status code to send on disconnect.
     * @param reason A custom reason for the disconnect.
     */
    disconnect(code, reason) {
        if (this.isDisconnecting()) {
            return;
        }
        this._setConnectionState('disconnecting', true);
        if (this.conn) {
            // Setup fallback timer to prevent hanging in disconnecting state
            const fallbackTimer = setTimeout(() => {
                this._setConnectionState('disconnected');
            }, 100);
            this.conn.onclose = () => {
                clearTimeout(fallbackTimer);
                this._setConnectionState('disconnected');
            };
            // Close the WebSocket connection if close method exists
            if (typeof this.conn.close === 'function') {
                if (code) {
                    this.conn.close(code, reason !== null && reason !== void 0 ? reason : '');
                }
                else {
                    this.conn.close();
                }
            }
            this._teardownConnection();
        }
        else {
            this._setConnectionState('disconnected');
        }
    }
    /**
     * Returns all created channels
     */
    getChannels() {
        return this.channels;
    }
    /**
     * Unsubscribes and removes a single channel
     * @param channel A RealtimeChannel instance
     */
    async removeChannel(channel) {
        const status = await channel.unsubscribe();
        if (this.channels.length === 0) {
            this.disconnect();
        }
        return status;
    }
    /**
     * Unsubscribes and removes all channels
     */
    async removeAllChannels() {
        const values_1 = await Promise.all(this.channels.map((channel) => channel.unsubscribe()));
        this.channels = [];
        this.disconnect();
        return values_1;
    }
    /**
     * Logs the message.
     *
     * For customized logging, `this.logger` can be overridden.
     */
    log(kind, msg, data) {
        this.logger(kind, msg, data);
    }
    /**
     * Returns the current state of the socket.
     */
    connectionState() {
        switch (this.conn && this.conn.readyState) {
            case constants_1.SOCKET_STATES.connecting:
                return constants_1.CONNECTION_STATE.Connecting;
            case constants_1.SOCKET_STATES.open:
                return constants_1.CONNECTION_STATE.Open;
            case constants_1.SOCKET_STATES.closing:
                return constants_1.CONNECTION_STATE.Closing;
            default:
                return constants_1.CONNECTION_STATE.Closed;
        }
    }
    /**
     * Returns `true` is the connection is open.
     */
    isConnected() {
        return this.connectionState() === constants_1.CONNECTION_STATE.Open;
    }
    /**
     * Returns `true` if the connection is currently connecting.
     */
    isConnecting() {
        return this._connectionState === 'connecting';
    }
    /**
     * Returns `true` if the connection is currently disconnecting.
     */
    isDisconnecting() {
        return this._connectionState === 'disconnecting';
    }
    /**
     * Creates (or reuses) a {@link RealtimeChannel} for the provided topic.
     *
     * Topics are automatically prefixed with `realtime:` to match the Realtime service.
     * If a channel with the same topic already exists it will be returned instead of creating
     * a duplicate connection.
     */
    channel(topic, params = { config: {} }) {
        const realtimeTopic = `realtime:${topic}`;
        const exists = this.getChannels().find((c) => c.topic === realtimeTopic);
        if (!exists) {
            const chan = new RealtimeChannel_1.default(`realtime:${topic}`, params, this);
            this.channels.push(chan);
            return chan;
        }
        else {
            return exists;
        }
    }
    /**
     * Push out a message if the socket is connected.
     *
     * If the socket is not connected, the message gets enqueued within a local buffer, and sent out when a connection is next established.
     */
    push(data) {
        const { topic, event, payload, ref } = data;
        const callback = () => {
            this.encode(data, (result) => {
                var _a;
                (_a = this.conn) === null || _a === void 0 ? void 0 : _a.send(result);
            });
        };
        this.log('push', `${topic} ${event} (${ref})`, payload);
        if (this.isConnected()) {
            callback();
        }
        else {
            this.sendBuffer.push(callback);
        }
    }
    /**
     * Sets the JWT access token used for channel subscription authorization and Realtime RLS.
     *
     * If param is null it will use the `accessToken` callback function or the token set on the client.
     *
     * On callback used, it will set the value of the token internal to the client.
     *
     * When a token is explicitly provided, it will be preserved across channel operations
     * (including removeChannel and resubscribe). The `accessToken` callback will not be
     * invoked until `setAuth()` is called without arguments.
     *
     * @param token A JWT string to override the token set on the client.
     *
     * @example
     * // Use a manual token (preserved across resubscribes, ignores accessToken callback)
     * client.realtime.setAuth('my-custom-jwt')
     *
     * // Switch back to using the accessToken callback
     * client.realtime.setAuth()
     */
    async setAuth(token = null) {
        this._authPromise = this._performAuth(token);
        try {
            await this._authPromise;
        }
        finally {
            this._authPromise = null;
        }
    }
    /**
     * Returns true if the current access token was explicitly set via setAuth(token),
     * false if it was obtained via the accessToken callback.
     * @internal
     */
    _isManualToken() {
        return this._manuallySetToken;
    }
    /**
     * Sends a heartbeat message if the socket is connected.
     */
    async sendHeartbeat() {
        var _a;
        if (!this.isConnected()) {
            try {
                this.heartbeatCallback('disconnected');
            }
            catch (e) {
                this.log('error', 'error in heartbeat callback', e);
            }
            return;
        }
        // Handle heartbeat timeout and force reconnection if needed
        if (this.pendingHeartbeatRef) {
            this.pendingHeartbeatRef = null;
            this._heartbeatSentAt = null;
            this.log('transport', 'heartbeat timeout. Attempting to re-establish connection');
            try {
                this.heartbeatCallback('timeout');
            }
            catch (e) {
                this.log('error', 'error in heartbeat callback', e);
            }
            // Force reconnection after heartbeat timeout
            this._wasManualDisconnect = false;
            (_a = this.conn) === null || _a === void 0 ? void 0 : _a.close(constants_1.WS_CLOSE_NORMAL, 'heartbeat timeout');
            setTimeout(() => {
                var _a;
                if (!this.isConnected()) {
                    (_a = this.reconnectTimer) === null || _a === void 0 ? void 0 : _a.scheduleTimeout();
                }
            }, CONNECTION_TIMEOUTS.HEARTBEAT_TIMEOUT_FALLBACK);
            return;
        }
        // Send heartbeat message to server
        this._heartbeatSentAt = Date.now();
        this.pendingHeartbeatRef = this._makeRef();
        this.push({
            topic: 'phoenix',
            event: 'heartbeat',
            payload: {},
            ref: this.pendingHeartbeatRef,
        });
        try {
            this.heartbeatCallback('sent');
        }
        catch (e) {
            this.log('error', 'error in heartbeat callback', e);
        }
        this._setAuthSafely('heartbeat');
    }
    /**
     * Sets a callback that receives lifecycle events for internal heartbeat messages.
     * Useful for instrumenting connection health (e.g. sent/ok/timeout/disconnected).
     */
    onHeartbeat(callback) {
        this.heartbeatCallback = callback;
    }
    /**
     * Flushes send buffer
     */
    flushSendBuffer() {
        if (this.isConnected() && this.sendBuffer.length > 0) {
            this.sendBuffer.forEach((callback) => callback());
            this.sendBuffer = [];
        }
    }
    /**
     * Return the next message ref, accounting for overflows
     *
     * @internal
     */
    _makeRef() {
        let newRef = this.ref + 1;
        if (newRef === this.ref) {
            this.ref = 0;
        }
        else {
            this.ref = newRef;
        }
        return this.ref.toString();
    }
    /**
     * Unsubscribe from channels with the specified topic.
     *
     * @internal
     */
    _leaveOpenTopic(topic) {
        let dupChannel = this.channels.find((c) => c.topic === topic && (c._isJoined() || c._isJoining()));
        if (dupChannel) {
            this.log('transport', `leaving duplicate topic "${topic}"`);
            dupChannel.unsubscribe();
        }
    }
    /**
     * Removes a subscription from the socket.
     *
     * @param channel An open subscription.
     *
     * @internal
     */
    _remove(channel) {
        this.channels = this.channels.filter((c) => c.topic !== channel.topic);
    }
    /** @internal */
    _onConnMessage(rawMessage) {
        this.decode(rawMessage.data, (msg) => {
            // Handle heartbeat responses
            if (msg.topic === 'phoenix' &&
                msg.event === 'phx_reply' &&
                msg.ref &&
                msg.ref === this.pendingHeartbeatRef) {
                const latency = this._heartbeatSentAt ? Date.now() - this._heartbeatSentAt : undefined;
                try {
                    this.heartbeatCallback(msg.payload.status === 'ok' ? 'ok' : 'error', latency);
                }
                catch (e) {
                    this.log('error', 'error in heartbeat callback', e);
                }
                this._heartbeatSentAt = null;
                this.pendingHeartbeatRef = null;
            }
            // Log incoming message
            const { topic, event, payload, ref } = msg;
            const refString = ref ? `(${ref})` : '';
            const status = payload.status || '';
            this.log('receive', `${status} ${topic} ${event} ${refString}`.trim(), payload);
            // Route message to appropriate channels
            this.channels
                .filter((channel) => channel._isMember(topic))
                .forEach((channel) => channel._trigger(event, payload, ref));
            this._triggerStateCallbacks('message', msg);
        });
    }
    /**
     * Clear specific timer
     * @internal
     */
    _clearTimer(timer) {
        var _a;
        if (timer === 'heartbeat' && this.heartbeatTimer) {
            clearInterval(this.heartbeatTimer);
            this.heartbeatTimer = undefined;
        }
        else if (timer === 'reconnect') {
            (_a = this.reconnectTimer) === null || _a === void 0 ? void 0 : _a.reset();
        }
    }
    /**
     * Clear all timers
     * @internal
     */
    _clearAllTimers() {
        this._clearTimer('heartbeat');
        this._clearTimer('reconnect');
    }
    /**
     * Setup connection handlers for WebSocket events
     * @internal
     */
    _setupConnectionHandlers() {
        if (!this.conn)
            return;
        // Set binary type if supported (browsers and most WebSocket implementations)
        if ('binaryType' in this.conn) {
            ;
            this.conn.binaryType = 'arraybuffer';
        }
        this.conn.onopen = () => this._onConnOpen();
        this.conn.onerror = (error) => this._onConnError(error);
        this.conn.onmessage = (event) => this._onConnMessage(event);
        this.conn.onclose = (event) => this._onConnClose(event);
        if (this.conn.readyState === constants_1.SOCKET_STATES.open) {
            this._onConnOpen();
        }
    }
    /**
     * Teardown connection and cleanup resources
     * @internal
     */
    _teardownConnection() {
        if (this.conn) {
            if (this.conn.readyState === constants_1.SOCKET_STATES.open ||
                this.conn.readyState === constants_1.SOCKET_STATES.connecting) {
                try {
                    this.conn.close();
                }
                catch (e) {
                    this.log('error', 'Error closing connection', e);
                }
            }
            this.conn.onopen = null;
            this.conn.onerror = null;
            this.conn.onmessage = null;
            this.conn.onclose = null;
            this.conn = null;
        }
        this._clearAllTimers();
        this._terminateWorker();
        this.channels.forEach((channel) => channel.teardown());
    }
    /** @internal */
    _onConnOpen() {
        this._setConnectionState('connected');
        this.log('transport', `connected to ${this.endpointURL()}`);
        // Wait for any pending auth operations before flushing send buffer
        // This ensures channel join messages include the correct access token
        const authPromise = this._authPromise ||
            (this.accessToken && !this.accessTokenValue ? this.setAuth() : Promise.resolve());
        authPromise
            .then(() => {
            // When subscribe() is called before the accessToken callback has
            // resolved (common on React Native / Expo where token storage is
            // async), the phx_join payload captured at subscribe()-time will
            // have no access_token.  By this point auth has settled and
            // this.accessTokenValue holds the real JWT.
            //
            // The stale join messages sitting in sendBuffer captured the old
            // (token-less) payload in a closure, so we cannot simply flush
            // them.  Instead we:
            //   1. Patch each channel's joinPush payload with the real token
            //   2. Drop the stale buffered messages
            //   3. Re-send the join for any channel still in "joining" state
            //
            // On browsers this is a harmless no-op: accessTokenValue was
            // already set synchronously before subscribe() ran, so the join
            // payload already had the correct token.
            if (this.accessTokenValue) {
                this.channels.forEach((channel) => {
                    channel.updateJoinPayload({ access_token: this.accessTokenValue });
                });
                this.sendBuffer = [];
                this.channels.forEach((channel) => {
                    if (channel._isJoining()) {
                        channel.joinPush.sent = false;
                        channel.joinPush.send();
                    }
                });
            }
            this.flushSendBuffer();
        })
            .catch((e) => {
            this.log('error', 'error waiting for auth on connect', e);
            // Proceed anyway to avoid hanging connections
            this.flushSendBuffer();
        });
        this._clearTimer('reconnect');
        if (!this.worker) {
            this._startHeartbeat();
        }
        else {
            if (!this.workerRef) {
                this._startWorkerHeartbeat();
            }
        }
        this._triggerStateCallbacks('open');
    }
    /** @internal */
    _startHeartbeat() {
        this.heartbeatTimer && clearInterval(this.heartbeatTimer);
        this.heartbeatTimer = setInterval(() => this.sendHeartbeat(), this.heartbeatIntervalMs);
    }
    /** @internal */
    _startWorkerHeartbeat() {
        if (this.workerUrl) {
            this.log('worker', `starting worker for from ${this.workerUrl}`);
        }
        else {
            this.log('worker', `starting default worker`);
        }
        const objectUrl = this._workerObjectUrl(this.workerUrl);
        this.workerRef = new Worker(objectUrl);
        this.workerRef.onerror = (error) => {
            this.log('worker', 'worker error', error.message);
            this._terminateWorker();
        };
        this.workerRef.onmessage = (event) => {
            if (event.data.event === 'keepAlive') {
                this.sendHeartbeat();
            }
        };
        this.workerRef.postMessage({
            event: 'start',
            interval: this.heartbeatIntervalMs,
        });
    }
    /**
     * Terminate the Web Worker and clear the reference
     * @internal
     */
    _terminateWorker() {
        if (this.workerRef) {
            this.log('worker', 'terminating worker');
            this.workerRef.terminate();
            this.workerRef = undefined;
        }
    }
    /** @internal */
    _onConnClose(event) {
        var _a;
        this._setConnectionState('disconnected');
        this.log('transport', 'close', event);
        this._triggerChanError();
        this._clearTimer('heartbeat');
        // Only schedule reconnection if it wasn't a manual disconnect
        if (!this._wasManualDisconnect) {
            (_a = this.reconnectTimer) === null || _a === void 0 ? void 0 : _a.scheduleTimeout();
        }
        this._triggerStateCallbacks('close', event);
    }
    /** @internal */
    _onConnError(error) {
        this._setConnectionState('disconnected');
        this.log('transport', `${error}`);
        this._triggerChanError();
        this._triggerStateCallbacks('error', error);
        try {
            this.heartbeatCallback('error');
        }
        catch (e) {
            this.log('error', 'error in heartbeat callback', e);
        }
    }
    /** @internal */
    _triggerChanError() {
        this.channels.forEach((channel) => channel._trigger(constants_1.CHANNEL_EVENTS.error));
    }
    /** @internal */
    _appendParams(url, params) {
        if (Object.keys(params).length === 0) {
            return url;
        }
        const prefix = url.match(/\?/) ? '&' : '?';
        const query = new URLSearchParams(params);
        return `${url}${prefix}${query}`;
    }
    _workerObjectUrl(url) {
        let result_url;
        if (url) {
            result_url = url;
        }
        else {
            const blob = new Blob([WORKER_SCRIPT], { type: 'application/javascript' });
            result_url = URL.createObjectURL(blob);
        }
        return result_url;
    }
    /**
     * Set connection state with proper state management
     * @internal
     */
    _setConnectionState(state, manual = false) {
        this._connectionState = state;
        if (state === 'connecting') {
            this._wasManualDisconnect = false;
        }
        else if (state === 'disconnecting') {
            this._wasManualDisconnect = manual;
        }
    }
    /**
     * Perform the actual auth operation
     * @internal
     */
    async _performAuth(token = null) {
        let tokenToSend;
        let isManualToken = false;
        if (token) {
            tokenToSend = token;
            // Track if this is a manually-provided token
            isManualToken = true;
        }
        else if (this.accessToken) {
            // Call the accessToken callback to get fresh token
            try {
                tokenToSend = await this.accessToken();
            }
            catch (e) {
                this.log('error', 'Error fetching access token from callback', e);
                // Fall back to cached value if callback fails
                tokenToSend = this.accessTokenValue;
            }
        }
        else {
            tokenToSend = this.accessTokenValue;
        }
        // Track whether this token was manually set or fetched via callback
        if (isManualToken) {
            this._manuallySetToken = true;
        }
        else if (this.accessToken) {
            // If we used the callback, clear the manual flag
            this._manuallySetToken = false;
        }
        if (this.accessTokenValue != tokenToSend) {
            this.accessTokenValue = tokenToSend;
            this.channels.forEach((channel) => {
                const payload = {
                    access_token: tokenToSend,
                    version: constants_1.DEFAULT_VERSION,
                };
                tokenToSend && channel.updateJoinPayload(payload);
                if (channel.joinedOnce && channel._isJoined()) {
                    channel._push(constants_1.CHANNEL_EVENTS.access_token, {
                        access_token: tokenToSend,
                    });
                }
            });
        }
    }
    /**
     * Wait for any in-flight auth operations to complete
     * @internal
     */
    async _waitForAuthIfNeeded() {
        if (this._authPromise) {
            await this._authPromise;
        }
    }
    /**
     * Safely call setAuth with standardized error handling
     * @internal
     */
    _setAuthSafely(context = 'general') {
        // Only refresh auth if using callback-based tokens
        if (!this._isManualToken()) {
            this.setAuth().catch((e) => {
                this.log('error', `Error setting auth in ${context}`, e);
            });
        }
    }
    /**
     * Trigger state change callbacks with proper error handling
     * @internal
     */
    _triggerStateCallbacks(event, data) {
        try {
            this.stateChangeCallbacks[event].forEach((callback) => {
                try {
                    callback(data);
                }
                catch (e) {
                    this.log('error', `error in ${event} callback`, e);
                }
            });
        }
        catch (e) {
            this.log('error', `error triggering ${event} callbacks`, e);
        }
    }
    /**
     * Setup reconnection timer with proper configuration
     * @internal
     */
    _setupReconnectionTimer() {
        this.reconnectTimer = new timer_1.default(async () => {
            setTimeout(async () => {
                await this._waitForAuthIfNeeded();
                if (!this.isConnected()) {
                    this.connect();
                }
            }, CONNECTION_TIMEOUTS.RECONNECT_DELAY);
        }, this.reconnectAfterMs);
    }
    /**
     * Initialize client options with defaults
     * @internal
     */
    _initializeOptions(options) {
        var _a, _b, _c, _d, _e, _f, _g, _h, _j, _k, _l, _m;
        // Set defaults
        this.transport = (_a = options === null || options === void 0 ? void 0 : options.transport) !== null && _a !== void 0 ? _a : null;
        this.timeout = (_b = options === null || options === void 0 ? void 0 : options.timeout) !== null && _b !== void 0 ? _b : constants_1.DEFAULT_TIMEOUT;
        this.heartbeatIntervalMs =
            (_c = options === null || options === void 0 ? void 0 : options.heartbeatIntervalMs) !== null && _c !== void 0 ? _c : CONNECTION_TIMEOUTS.HEARTBEAT_INTERVAL;
        this.worker = (_d = options === null || options === void 0 ? void 0 : options.worker) !== null && _d !== void 0 ? _d : false;
        this.accessToken = (_e = options === null || options === void 0 ? void 0 : options.accessToken) !== null && _e !== void 0 ? _e : null;
        this.heartbeatCallback = (_f = options === null || options === void 0 ? void 0 : options.heartbeatCallback) !== null && _f !== void 0 ? _f : noop;
        this.vsn = (_g = options === null || options === void 0 ? void 0 : options.vsn) !== null && _g !== void 0 ? _g : constants_1.DEFAULT_VSN;
        // Handle special cases
        if (options === null || options === void 0 ? void 0 : options.params)
            this.params = options.params;
        if (options === null || options === void 0 ? void 0 : options.logger)
            this.logger = options.logger;
        if ((options === null || options === void 0 ? void 0 : options.logLevel) || (options === null || options === void 0 ? void 0 : options.log_level)) {
            this.logLevel = options.logLevel || options.log_level;
            this.params = Object.assign(Object.assign({}, this.params), { log_level: this.logLevel });
        }
        // Set up functions with defaults
        this.reconnectAfterMs =
            (_h = options === null || options === void 0 ? void 0 : options.reconnectAfterMs) !== null && _h !== void 0 ? _h : ((tries) => {
                return RECONNECT_INTERVALS[tries - 1] || DEFAULT_RECONNECT_FALLBACK;
            });
        switch (this.vsn) {
            case constants_1.VSN_1_0_0:
                this.encode =
                    (_j = options === null || options === void 0 ? void 0 : options.encode) !== null && _j !== void 0 ? _j : ((payload, callback) => {
                        return callback(JSON.stringify(payload));
                    });
                this.decode =
                    (_k = options === null || options === void 0 ? void 0 : options.decode) !== null && _k !== void 0 ? _k : ((payload, callback) => {
                        return callback(JSON.parse(payload));
                    });
                break;
            case constants_1.VSN_2_0_0:
                this.encode = (_l = options === null || options === void 0 ? void 0 : options.encode) !== null && _l !== void 0 ? _l : this.serializer.encode.bind(this.serializer);
                this.decode = (_m = options === null || options === void 0 ? void 0 : options.decode) !== null && _m !== void 0 ? _m : this.serializer.decode.bind(this.serializer);
                break;
            default:
                throw new Error(`Unsupported serializer version: ${this.vsn}`);
        }
        // Handle worker setup
        if (this.worker) {
            if (typeof window !== 'undefined' && !window.Worker) {
                throw new Error('Web Worker is not supported');
            }
            this.workerUrl = options === null || options === void 0 ? void 0 : options.workerUrl;
        }
    }
}
exports["default"] = RealtimeClient;
//# sourceMappingURL=RealtimeClient.js.map

/***/ }),

/***/ 7590:
/***/ ((__unused_webpack_module, exports) => {

"use strict";

/*
  This file draws heavily from https://github.com/phoenixframework/phoenix/blob/d344ec0a732ab4ee204215b31de69cf4be72e3bf/assets/js/phoenix/presence.js
  License: https://github.com/phoenixframework/phoenix/blob/d344ec0a732ab4ee204215b31de69cf4be72e3bf/LICENSE.md
*/
Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.REALTIME_PRESENCE_LISTEN_EVENTS = void 0;
var REALTIME_PRESENCE_LISTEN_EVENTS;
(function (REALTIME_PRESENCE_LISTEN_EVENTS) {
    REALTIME_PRESENCE_LISTEN_EVENTS["SYNC"] = "sync";
    REALTIME_PRESENCE_LISTEN_EVENTS["JOIN"] = "join";
    REALTIME_PRESENCE_LISTEN_EVENTS["LEAVE"] = "leave";
})(REALTIME_PRESENCE_LISTEN_EVENTS || (exports.REALTIME_PRESENCE_LISTEN_EVENTS = REALTIME_PRESENCE_LISTEN_EVENTS = {}));
class RealtimePresence {
    /**
     * Creates a Presence helper that keeps the local presence state in sync with the server.
     *
     * @param channel - The realtime channel to bind to.
     * @param opts - Optional custom event names, e.g. `{ events: { state: 'state', diff: 'diff' } }`.
     *
     * @example
     * ```ts
     * const presence = new RealtimePresence(channel)
     *
     * channel.on('presence', ({ event, key }) => {
     *   console.log(`Presence ${event} on ${key}`)
     * })
     * ```
     */
    constructor(channel, opts) {
        this.channel = channel;
        this.state = {};
        this.pendingDiffs = [];
        this.joinRef = null;
        this.enabled = false;
        this.caller = {
            onJoin: () => { },
            onLeave: () => { },
            onSync: () => { },
        };
        const events = (opts === null || opts === void 0 ? void 0 : opts.events) || {
            state: 'presence_state',
            diff: 'presence_diff',
        };
        this.channel._on(events.state, {}, (newState) => {
            const { onJoin, onLeave, onSync } = this.caller;
            this.joinRef = this.channel._joinRef();
            this.state = RealtimePresence.syncState(this.state, newState, onJoin, onLeave);
            this.pendingDiffs.forEach((diff) => {
                this.state = RealtimePresence.syncDiff(this.state, diff, onJoin, onLeave);
            });
            this.pendingDiffs = [];
            onSync();
        });
        this.channel._on(events.diff, {}, (diff) => {
            const { onJoin, onLeave, onSync } = this.caller;
            if (this.inPendingSyncState()) {
                this.pendingDiffs.push(diff);
            }
            else {
                this.state = RealtimePresence.syncDiff(this.state, diff, onJoin, onLeave);
                onSync();
            }
        });
        this.onJoin((key, currentPresences, newPresences) => {
            this.channel._trigger('presence', {
                event: 'join',
                key,
                currentPresences,
                newPresences,
            });
        });
        this.onLeave((key, currentPresences, leftPresences) => {
            this.channel._trigger('presence', {
                event: 'leave',
                key,
                currentPresences,
                leftPresences,
            });
        });
        this.onSync(() => {
            this.channel._trigger('presence', { event: 'sync' });
        });
    }
    /**
     * Used to sync the list of presences on the server with the
     * client's state.
     *
     * An optional `onJoin` and `onLeave` callback can be provided to
     * react to changes in the client's local presences across
     * disconnects and reconnects with the server.
     *
     * @internal
     */
    static syncState(currentState, newState, onJoin, onLeave) {
        const state = this.cloneDeep(currentState);
        const transformedState = this.transformState(newState);
        const joins = {};
        const leaves = {};
        this.map(state, (key, presences) => {
            if (!transformedState[key]) {
                leaves[key] = presences;
            }
        });
        this.map(transformedState, (key, newPresences) => {
            const currentPresences = state[key];
            if (currentPresences) {
                const newPresenceRefs = newPresences.map((m) => m.presence_ref);
                const curPresenceRefs = currentPresences.map((m) => m.presence_ref);
                const joinedPresences = newPresences.filter((m) => curPresenceRefs.indexOf(m.presence_ref) < 0);
                const leftPresences = currentPresences.filter((m) => newPresenceRefs.indexOf(m.presence_ref) < 0);
                if (joinedPresences.length > 0) {
                    joins[key] = joinedPresences;
                }
                if (leftPresences.length > 0) {
                    leaves[key] = leftPresences;
                }
            }
            else {
                joins[key] = newPresences;
            }
        });
        return this.syncDiff(state, { joins, leaves }, onJoin, onLeave);
    }
    /**
     * Used to sync a diff of presence join and leave events from the
     * server, as they happen.
     *
     * Like `syncState`, `syncDiff` accepts optional `onJoin` and
     * `onLeave` callbacks to react to a user joining or leaving from a
     * device.
     *
     * @internal
     */
    static syncDiff(state, diff, onJoin, onLeave) {
        const { joins, leaves } = {
            joins: this.transformState(diff.joins),
            leaves: this.transformState(diff.leaves),
        };
        if (!onJoin) {
            onJoin = () => { };
        }
        if (!onLeave) {
            onLeave = () => { };
        }
        this.map(joins, (key, newPresences) => {
            var _a;
            const currentPresences = (_a = state[key]) !== null && _a !== void 0 ? _a : [];
            state[key] = this.cloneDeep(newPresences);
            if (currentPresences.length > 0) {
                const joinedPresenceRefs = state[key].map((m) => m.presence_ref);
                const curPresences = currentPresences.filter((m) => joinedPresenceRefs.indexOf(m.presence_ref) < 0);
                state[key].unshift(...curPresences);
            }
            onJoin(key, currentPresences, newPresences);
        });
        this.map(leaves, (key, leftPresences) => {
            let currentPresences = state[key];
            if (!currentPresences)
                return;
            const presenceRefsToRemove = leftPresences.map((m) => m.presence_ref);
            currentPresences = currentPresences.filter((m) => presenceRefsToRemove.indexOf(m.presence_ref) < 0);
            state[key] = currentPresences;
            onLeave(key, currentPresences, leftPresences);
            if (currentPresences.length === 0)
                delete state[key];
        });
        return state;
    }
    /** @internal */
    static map(obj, func) {
        return Object.getOwnPropertyNames(obj).map((key) => func(key, obj[key]));
    }
    /**
     * Remove 'metas' key
     * Change 'phx_ref' to 'presence_ref'
     * Remove 'phx_ref' and 'phx_ref_prev'
     *
     * @example
     * // returns {
     *  abc123: [
     *    { presence_ref: '2', user_id: 1 },
     *    { presence_ref: '3', user_id: 2 }
     *  ]
     * }
     * RealtimePresence.transformState({
     *  abc123: {
     *    metas: [
     *      { phx_ref: '2', phx_ref_prev: '1' user_id: 1 },
     *      { phx_ref: '3', user_id: 2 }
     *    ]
     *  }
     * })
     *
     * @internal
     */
    static transformState(state) {
        state = this.cloneDeep(state);
        return Object.getOwnPropertyNames(state).reduce((newState, key) => {
            const presences = state[key];
            if ('metas' in presences) {
                newState[key] = presences.metas.map((presence) => {
                    presence['presence_ref'] = presence['phx_ref'];
                    delete presence['phx_ref'];
                    delete presence['phx_ref_prev'];
                    return presence;
                });
            }
            else {
                newState[key] = presences;
            }
            return newState;
        }, {});
    }
    /** @internal */
    static cloneDeep(obj) {
        return JSON.parse(JSON.stringify(obj));
    }
    /** @internal */
    onJoin(callback) {
        this.caller.onJoin = callback;
    }
    /** @internal */
    onLeave(callback) {
        this.caller.onLeave = callback;
    }
    /** @internal */
    onSync(callback) {
        this.caller.onSync = callback;
    }
    /** @internal */
    inPendingSyncState() {
        return !this.joinRef || this.joinRef !== this.channel._joinRef();
    }
}
exports["default"] = RealtimePresence;
//# sourceMappingURL=RealtimePresence.js.map

/***/ }),

/***/ 9626:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {

"use strict";
var __webpack_unused_export__;

__webpack_unused_export__ = ({ value: true });
__webpack_unused_export__ = __webpack_unused_export__ = __webpack_unused_export__ = __webpack_unused_export__ = __webpack_unused_export__ = __webpack_unused_export__ = exports.VH = __webpack_unused_export__ = __webpack_unused_export__ = void 0;
const tslib_1 = __webpack_require__(1915);
const RealtimeClient_1 = tslib_1.__importDefault(__webpack_require__(9230));
exports.VH = RealtimeClient_1.default;
const RealtimeChannel_1 = tslib_1.__importStar(__webpack_require__(7974));
__webpack_unused_export__ = RealtimeChannel_1.default;
__webpack_unused_export__ = ({ enumerable: true, get: function () { return RealtimeChannel_1.REALTIME_LISTEN_TYPES; } });
__webpack_unused_export__ = ({ enumerable: true, get: function () { return RealtimeChannel_1.REALTIME_POSTGRES_CHANGES_LISTEN_EVENT; } });
__webpack_unused_export__ = ({ enumerable: true, get: function () { return RealtimeChannel_1.REALTIME_SUBSCRIBE_STATES; } });
__webpack_unused_export__ = ({ enumerable: true, get: function () { return RealtimeChannel_1.REALTIME_CHANNEL_STATES; } });
const RealtimePresence_1 = tslib_1.__importStar(__webpack_require__(7590));
__webpack_unused_export__ = RealtimePresence_1.default;
__webpack_unused_export__ = ({ enumerable: true, get: function () { return RealtimePresence_1.REALTIME_PRESENCE_LISTEN_EVENTS; } });
const websocket_factory_1 = tslib_1.__importDefault(__webpack_require__(2643));
__webpack_unused_export__ = websocket_factory_1.default;
//# sourceMappingURL=index.js.map

/***/ }),

/***/ 6218:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.CONNECTION_STATE = exports.TRANSPORTS = exports.CHANNEL_EVENTS = exports.CHANNEL_STATES = exports.SOCKET_STATES = exports.MAX_PUSH_BUFFER_SIZE = exports.WS_CLOSE_NORMAL = exports.DEFAULT_TIMEOUT = exports.VERSION = exports.DEFAULT_VSN = exports.VSN_2_0_0 = exports.VSN_1_0_0 = exports.DEFAULT_VERSION = void 0;
const version_1 = __webpack_require__(152);
exports.DEFAULT_VERSION = `realtime-js/${version_1.version}`;
exports.VSN_1_0_0 = '1.0.0';
exports.VSN_2_0_0 = '2.0.0';
exports.DEFAULT_VSN = exports.VSN_2_0_0;
exports.VERSION = version_1.version;
exports.DEFAULT_TIMEOUT = 10000;
exports.WS_CLOSE_NORMAL = 1000;
exports.MAX_PUSH_BUFFER_SIZE = 100;
var SOCKET_STATES;
(function (SOCKET_STATES) {
    SOCKET_STATES[SOCKET_STATES["connecting"] = 0] = "connecting";
    SOCKET_STATES[SOCKET_STATES["open"] = 1] = "open";
    SOCKET_STATES[SOCKET_STATES["closing"] = 2] = "closing";
    SOCKET_STATES[SOCKET_STATES["closed"] = 3] = "closed";
})(SOCKET_STATES || (exports.SOCKET_STATES = SOCKET_STATES = {}));
var CHANNEL_STATES;
(function (CHANNEL_STATES) {
    CHANNEL_STATES["closed"] = "closed";
    CHANNEL_STATES["errored"] = "errored";
    CHANNEL_STATES["joined"] = "joined";
    CHANNEL_STATES["joining"] = "joining";
    CHANNEL_STATES["leaving"] = "leaving";
})(CHANNEL_STATES || (exports.CHANNEL_STATES = CHANNEL_STATES = {}));
var CHANNEL_EVENTS;
(function (CHANNEL_EVENTS) {
    CHANNEL_EVENTS["close"] = "phx_close";
    CHANNEL_EVENTS["error"] = "phx_error";
    CHANNEL_EVENTS["join"] = "phx_join";
    CHANNEL_EVENTS["reply"] = "phx_reply";
    CHANNEL_EVENTS["leave"] = "phx_leave";
    CHANNEL_EVENTS["access_token"] = "access_token";
})(CHANNEL_EVENTS || (exports.CHANNEL_EVENTS = CHANNEL_EVENTS = {}));
var TRANSPORTS;
(function (TRANSPORTS) {
    TRANSPORTS["websocket"] = "websocket";
})(TRANSPORTS || (exports.TRANSPORTS = TRANSPORTS = {}));
var CONNECTION_STATE;
(function (CONNECTION_STATE) {
    CONNECTION_STATE["Connecting"] = "connecting";
    CONNECTION_STATE["Open"] = "open";
    CONNECTION_STATE["Closing"] = "closing";
    CONNECTION_STATE["Closed"] = "closed";
})(CONNECTION_STATE || (exports.CONNECTION_STATE = CONNECTION_STATE = {}));
//# sourceMappingURL=constants.js.map

/***/ }),

/***/ 3917:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({ value: true }));
const constants_1 = __webpack_require__(6218);
class Push {
    /**
     * Initializes the Push
     *
     * @param channel The Channel
     * @param event The event, for example `"phx_join"`
     * @param payload The payload, for example `{user_id: 123}`
     * @param timeout The push timeout in milliseconds
     */
    constructor(channel, event, payload = {}, timeout = constants_1.DEFAULT_TIMEOUT) {
        this.channel = channel;
        this.event = event;
        this.payload = payload;
        this.timeout = timeout;
        this.sent = false;
        this.timeoutTimer = undefined;
        this.ref = '';
        this.receivedResp = null;
        this.recHooks = [];
        this.refEvent = null;
    }
    resend(timeout) {
        this.timeout = timeout;
        this._cancelRefEvent();
        this.ref = '';
        this.refEvent = null;
        this.receivedResp = null;
        this.sent = false;
        this.send();
    }
    send() {
        if (this._hasReceived('timeout')) {
            return;
        }
        this.startTimeout();
        this.sent = true;
        this.channel.socket.push({
            topic: this.channel.topic,
            event: this.event,
            payload: this.payload,
            ref: this.ref,
            join_ref: this.channel._joinRef(),
        });
    }
    updatePayload(payload) {
        this.payload = Object.assign(Object.assign({}, this.payload), payload);
    }
    receive(status, callback) {
        var _a;
        if (this._hasReceived(status)) {
            callback((_a = this.receivedResp) === null || _a === void 0 ? void 0 : _a.response);
        }
        this.recHooks.push({ status, callback });
        return this;
    }
    startTimeout() {
        if (this.timeoutTimer) {
            return;
        }
        this.ref = this.channel.socket._makeRef();
        this.refEvent = this.channel._replyEventName(this.ref);
        const callback = (payload) => {
            this._cancelRefEvent();
            this._cancelTimeout();
            this.receivedResp = payload;
            this._matchReceive(payload);
        };
        this.channel._on(this.refEvent, {}, callback);
        this.timeoutTimer = setTimeout(() => {
            this.trigger('timeout', {});
        }, this.timeout);
    }
    trigger(status, response) {
        if (this.refEvent)
            this.channel._trigger(this.refEvent, { status, response });
    }
    destroy() {
        this._cancelRefEvent();
        this._cancelTimeout();
    }
    _cancelRefEvent() {
        if (!this.refEvent) {
            return;
        }
        this.channel._off(this.refEvent, {});
    }
    _cancelTimeout() {
        clearTimeout(this.timeoutTimer);
        this.timeoutTimer = undefined;
    }
    _matchReceive({ status, response }) {
        this.recHooks.filter((h) => h.status === status).forEach((h) => h.callback(response));
    }
    _hasReceived(status) {
        return this.receivedResp && this.receivedResp.status === status;
    }
}
exports["default"] = Push;
//# sourceMappingURL=push.js.map

/***/ }),

/***/ 3148:
/***/ ((__unused_webpack_module, exports) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({ value: true }));
class Serializer {
    constructor(allowedMetadataKeys) {
        this.HEADER_LENGTH = 1;
        this.USER_BROADCAST_PUSH_META_LENGTH = 6;
        this.KINDS = { userBroadcastPush: 3, userBroadcast: 4 };
        this.BINARY_ENCODING = 0;
        this.JSON_ENCODING = 1;
        this.BROADCAST_EVENT = 'broadcast';
        this.allowedMetadataKeys = [];
        this.allowedMetadataKeys = allowedMetadataKeys !== null && allowedMetadataKeys !== void 0 ? allowedMetadataKeys : [];
    }
    encode(msg, callback) {
        if (msg.event === this.BROADCAST_EVENT &&
            !(msg.payload instanceof ArrayBuffer) &&
            typeof msg.payload.event === 'string') {
            return callback(this._binaryEncodeUserBroadcastPush(msg));
        }
        let payload = [msg.join_ref, msg.ref, msg.topic, msg.event, msg.payload];
        return callback(JSON.stringify(payload));
    }
    _binaryEncodeUserBroadcastPush(message) {
        var _a;
        if (this._isArrayBuffer((_a = message.payload) === null || _a === void 0 ? void 0 : _a.payload)) {
            return this._encodeBinaryUserBroadcastPush(message);
        }
        else {
            return this._encodeJsonUserBroadcastPush(message);
        }
    }
    _encodeBinaryUserBroadcastPush(message) {
        var _a, _b;
        const userPayload = (_b = (_a = message.payload) === null || _a === void 0 ? void 0 : _a.payload) !== null && _b !== void 0 ? _b : new ArrayBuffer(0);
        return this._encodeUserBroadcastPush(message, this.BINARY_ENCODING, userPayload);
    }
    _encodeJsonUserBroadcastPush(message) {
        var _a, _b;
        const userPayload = (_b = (_a = message.payload) === null || _a === void 0 ? void 0 : _a.payload) !== null && _b !== void 0 ? _b : {};
        const encoder = new TextEncoder();
        const encodedUserPayload = encoder.encode(JSON.stringify(userPayload)).buffer;
        return this._encodeUserBroadcastPush(message, this.JSON_ENCODING, encodedUserPayload);
    }
    _encodeUserBroadcastPush(message, encodingType, encodedPayload) {
        var _a, _b;
        const topic = message.topic;
        const ref = (_a = message.ref) !== null && _a !== void 0 ? _a : '';
        const joinRef = (_b = message.join_ref) !== null && _b !== void 0 ? _b : '';
        const userEvent = message.payload.event;
        // Filter metadata based on allowed keys
        const rest = this.allowedMetadataKeys
            ? this._pick(message.payload, this.allowedMetadataKeys)
            : {};
        const metadata = Object.keys(rest).length === 0 ? '' : JSON.stringify(rest);
        // Validate lengths don't exceed uint8 max value (255)
        if (joinRef.length > 255) {
            throw new Error(`joinRef length ${joinRef.length} exceeds maximum of 255`);
        }
        if (ref.length > 255) {
            throw new Error(`ref length ${ref.length} exceeds maximum of 255`);
        }
        if (topic.length > 255) {
            throw new Error(`topic length ${topic.length} exceeds maximum of 255`);
        }
        if (userEvent.length > 255) {
            throw new Error(`userEvent length ${userEvent.length} exceeds maximum of 255`);
        }
        if (metadata.length > 255) {
            throw new Error(`metadata length ${metadata.length} exceeds maximum of 255`);
        }
        const metaLength = this.USER_BROADCAST_PUSH_META_LENGTH +
            joinRef.length +
            ref.length +
            topic.length +
            userEvent.length +
            metadata.length;
        const header = new ArrayBuffer(this.HEADER_LENGTH + metaLength);
        let view = new DataView(header);
        let offset = 0;
        view.setUint8(offset++, this.KINDS.userBroadcastPush); // kind
        view.setUint8(offset++, joinRef.length);
        view.setUint8(offset++, ref.length);
        view.setUint8(offset++, topic.length);
        view.setUint8(offset++, userEvent.length);
        view.setUint8(offset++, metadata.length);
        view.setUint8(offset++, encodingType);
        Array.from(joinRef, (char) => view.setUint8(offset++, char.charCodeAt(0)));
        Array.from(ref, (char) => view.setUint8(offset++, char.charCodeAt(0)));
        Array.from(topic, (char) => view.setUint8(offset++, char.charCodeAt(0)));
        Array.from(userEvent, (char) => view.setUint8(offset++, char.charCodeAt(0)));
        Array.from(metadata, (char) => view.setUint8(offset++, char.charCodeAt(0)));
        var combined = new Uint8Array(header.byteLength + encodedPayload.byteLength);
        combined.set(new Uint8Array(header), 0);
        combined.set(new Uint8Array(encodedPayload), header.byteLength);
        return combined.buffer;
    }
    decode(rawPayload, callback) {
        if (this._isArrayBuffer(rawPayload)) {
            let result = this._binaryDecode(rawPayload);
            return callback(result);
        }
        if (typeof rawPayload === 'string') {
            const jsonPayload = JSON.parse(rawPayload);
            const [join_ref, ref, topic, event, payload] = jsonPayload;
            return callback({ join_ref, ref, topic, event, payload });
        }
        return callback({});
    }
    _binaryDecode(buffer) {
        const view = new DataView(buffer);
        const kind = view.getUint8(0);
        const decoder = new TextDecoder();
        switch (kind) {
            case this.KINDS.userBroadcast:
                return this._decodeUserBroadcast(buffer, view, decoder);
        }
    }
    _decodeUserBroadcast(buffer, view, decoder) {
        const topicSize = view.getUint8(1);
        const userEventSize = view.getUint8(2);
        const metadataSize = view.getUint8(3);
        const payloadEncoding = view.getUint8(4);
        let offset = this.HEADER_LENGTH + 4;
        const topic = decoder.decode(buffer.slice(offset, offset + topicSize));
        offset = offset + topicSize;
        const userEvent = decoder.decode(buffer.slice(offset, offset + userEventSize));
        offset = offset + userEventSize;
        const metadata = decoder.decode(buffer.slice(offset, offset + metadataSize));
        offset = offset + metadataSize;
        const payload = buffer.slice(offset, buffer.byteLength);
        const parsedPayload = payloadEncoding === this.JSON_ENCODING ? JSON.parse(decoder.decode(payload)) : payload;
        const data = {
            type: this.BROADCAST_EVENT,
            event: userEvent,
            payload: parsedPayload,
        };
        // Metadata is optional and always JSON encoded
        if (metadataSize > 0) {
            data['meta'] = JSON.parse(metadata);
        }
        return { join_ref: null, ref: null, topic: topic, event: this.BROADCAST_EVENT, payload: data };
    }
    _isArrayBuffer(buffer) {
        var _a;
        return buffer instanceof ArrayBuffer || ((_a = buffer === null || buffer === void 0 ? void 0 : buffer.constructor) === null || _a === void 0 ? void 0 : _a.name) === 'ArrayBuffer';
    }
    _pick(obj, keys) {
        if (!obj || typeof obj !== 'object') {
            return {};
        }
        return Object.fromEntries(Object.entries(obj).filter(([key]) => keys.includes(key)));
    }
}
exports["default"] = Serializer;
//# sourceMappingURL=serializer.js.map

/***/ }),

/***/ 8503:
/***/ ((__unused_webpack_module, exports) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({ value: true }));
/**
 * Creates a timer that accepts a `timerCalc` function to perform calculated timeout retries, such as exponential backoff.
 *
 * @example
 *    let reconnectTimer = new Timer(() => this.connect(), function(tries){
 *      return [1000, 5000, 10000][tries - 1] || 10000
 *    })
 *    reconnectTimer.scheduleTimeout() // fires after 1000
 *    reconnectTimer.scheduleTimeout() // fires after 5000
 *    reconnectTimer.reset()
 *    reconnectTimer.scheduleTimeout() // fires after 1000
 */
class Timer {
    constructor(callback, timerCalc) {
        this.callback = callback;
        this.timerCalc = timerCalc;
        this.timer = undefined;
        this.tries = 0;
        this.callback = callback;
        this.timerCalc = timerCalc;
    }
    reset() {
        this.tries = 0;
        clearTimeout(this.timer);
        this.timer = undefined;
    }
    // Cancels any previous scheduleTimeout and schedules callback
    scheduleTimeout() {
        clearTimeout(this.timer);
        this.timer = setTimeout(() => {
            this.tries = this.tries + 1;
            this.callback();
        }, this.timerCalc(this.tries + 1));
    }
}
exports["default"] = Timer;
//# sourceMappingURL=timer.js.map

/***/ }),

/***/ 1921:
/***/ ((__unused_webpack_module, exports) => {

"use strict";

/**
 * Helpers to convert the change Payload into native JS types.
 */
Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.httpEndpointURL = exports.toTimestampString = exports.toArray = exports.toJson = exports.toNumber = exports.toBoolean = exports.convertCell = exports.convertColumn = exports.convertChangeData = exports.PostgresTypes = void 0;
// Adapted from epgsql (src/epgsql_binary.erl), this module licensed under
// 3-clause BSD found here: https://raw.githubusercontent.com/epgsql/epgsql/devel/LICENSE
var PostgresTypes;
(function (PostgresTypes) {
    PostgresTypes["abstime"] = "abstime";
    PostgresTypes["bool"] = "bool";
    PostgresTypes["date"] = "date";
    PostgresTypes["daterange"] = "daterange";
    PostgresTypes["float4"] = "float4";
    PostgresTypes["float8"] = "float8";
    PostgresTypes["int2"] = "int2";
    PostgresTypes["int4"] = "int4";
    PostgresTypes["int4range"] = "int4range";
    PostgresTypes["int8"] = "int8";
    PostgresTypes["int8range"] = "int8range";
    PostgresTypes["json"] = "json";
    PostgresTypes["jsonb"] = "jsonb";
    PostgresTypes["money"] = "money";
    PostgresTypes["numeric"] = "numeric";
    PostgresTypes["oid"] = "oid";
    PostgresTypes["reltime"] = "reltime";
    PostgresTypes["text"] = "text";
    PostgresTypes["time"] = "time";
    PostgresTypes["timestamp"] = "timestamp";
    PostgresTypes["timestamptz"] = "timestamptz";
    PostgresTypes["timetz"] = "timetz";
    PostgresTypes["tsrange"] = "tsrange";
    PostgresTypes["tstzrange"] = "tstzrange";
})(PostgresTypes || (exports.PostgresTypes = PostgresTypes = {}));
/**
 * Takes an array of columns and an object of string values then converts each string value
 * to its mapped type.
 *
 * @param {{name: String, type: String}[]} columns
 * @param {Object} record
 * @param {Object} options The map of various options that can be applied to the mapper
 * @param {Array} options.skipTypes The array of types that should not be converted
 *
 * @example convertChangeData([{name: 'first_name', type: 'text'}, {name: 'age', type: 'int4'}], {first_name: 'Paul', age:'33'}, {})
 * //=>{ first_name: 'Paul', age: 33 }
 */
const convertChangeData = (columns, record, options = {}) => {
    var _a;
    const skipTypes = (_a = options.skipTypes) !== null && _a !== void 0 ? _a : [];
    if (!record) {
        return {};
    }
    return Object.keys(record).reduce((acc, rec_key) => {
        acc[rec_key] = (0, exports.convertColumn)(rec_key, columns, record, skipTypes);
        return acc;
    }, {});
};
exports.convertChangeData = convertChangeData;
/**
 * Converts the value of an individual column.
 *
 * @param {String} columnName The column that you want to convert
 * @param {{name: String, type: String}[]} columns All of the columns
 * @param {Object} record The map of string values
 * @param {Array} skipTypes An array of types that should not be converted
 * @return {object} Useless information
 *
 * @example convertColumn('age', [{name: 'first_name', type: 'text'}, {name: 'age', type: 'int4'}], {first_name: 'Paul', age: '33'}, [])
 * //=> 33
 * @example convertColumn('age', [{name: 'first_name', type: 'text'}, {name: 'age', type: 'int4'}], {first_name: 'Paul', age: '33'}, ['int4'])
 * //=> "33"
 */
const convertColumn = (columnName, columns, record, skipTypes) => {
    const column = columns.find((x) => x.name === columnName);
    const colType = column === null || column === void 0 ? void 0 : column.type;
    const value = record[columnName];
    if (colType && !skipTypes.includes(colType)) {
        return (0, exports.convertCell)(colType, value);
    }
    return noop(value);
};
exports.convertColumn = convertColumn;
/**
 * If the value of the cell is `null`, returns null.
 * Otherwise converts the string value to the correct type.
 * @param {String} type A postgres column type
 * @param {String} value The cell value
 *
 * @example convertCell('bool', 't')
 * //=> true
 * @example convertCell('int8', '10')
 * //=> 10
 * @example convertCell('_int4', '{1,2,3,4}')
 * //=> [1,2,3,4]
 */
const convertCell = (type, value) => {
    // if data type is an array
    if (type.charAt(0) === '_') {
        const dataType = type.slice(1, type.length);
        return (0, exports.toArray)(value, dataType);
    }
    // If not null, convert to correct type.
    switch (type) {
        case PostgresTypes.bool:
            return (0, exports.toBoolean)(value);
        case PostgresTypes.float4:
        case PostgresTypes.float8:
        case PostgresTypes.int2:
        case PostgresTypes.int4:
        case PostgresTypes.int8:
        case PostgresTypes.numeric:
        case PostgresTypes.oid:
            return (0, exports.toNumber)(value);
        case PostgresTypes.json:
        case PostgresTypes.jsonb:
            return (0, exports.toJson)(value);
        case PostgresTypes.timestamp:
            return (0, exports.toTimestampString)(value); // Format to be consistent with PostgREST
        case PostgresTypes.abstime: // To allow users to cast it based on Timezone
        case PostgresTypes.date: // To allow users to cast it based on Timezone
        case PostgresTypes.daterange:
        case PostgresTypes.int4range:
        case PostgresTypes.int8range:
        case PostgresTypes.money:
        case PostgresTypes.reltime: // To allow users to cast it based on Timezone
        case PostgresTypes.text:
        case PostgresTypes.time: // To allow users to cast it based on Timezone
        case PostgresTypes.timestamptz: // To allow users to cast it based on Timezone
        case PostgresTypes.timetz: // To allow users to cast it based on Timezone
        case PostgresTypes.tsrange:
        case PostgresTypes.tstzrange:
            return noop(value);
        default:
            // Return the value for remaining types
            return noop(value);
    }
};
exports.convertCell = convertCell;
const noop = (value) => {
    return value;
};
const toBoolean = (value) => {
    switch (value) {
        case 't':
            return true;
        case 'f':
            return false;
        default:
            return value;
    }
};
exports.toBoolean = toBoolean;
const toNumber = (value) => {
    if (typeof value === 'string') {
        const parsedValue = parseFloat(value);
        if (!Number.isNaN(parsedValue)) {
            return parsedValue;
        }
    }
    return value;
};
exports.toNumber = toNumber;
const toJson = (value) => {
    if (typeof value === 'string') {
        try {
            return JSON.parse(value);
        }
        catch (_a) {
            return value;
        }
    }
    return value;
};
exports.toJson = toJson;
/**
 * Converts a Postgres Array into a native JS array
 *
 * @example toArray('{}', 'int4')
 * //=> []
 * @example toArray('{"[2021-01-01,2021-12-31)","(2021-01-01,2021-12-32]"}', 'daterange')
 * //=> ['[2021-01-01,2021-12-31)', '(2021-01-01,2021-12-32]']
 * @example toArray([1,2,3,4], 'int4')
 * //=> [1,2,3,4]
 */
const toArray = (value, type) => {
    if (typeof value !== 'string') {
        return value;
    }
    const lastIdx = value.length - 1;
    const closeBrace = value[lastIdx];
    const openBrace = value[0];
    // Confirm value is a Postgres array by checking curly brackets
    if (openBrace === '{' && closeBrace === '}') {
        let arr;
        const valTrim = value.slice(1, lastIdx);
        // TODO: find a better solution to separate Postgres array data
        try {
            arr = JSON.parse('[' + valTrim + ']');
        }
        catch (_) {
            // WARNING: splitting on comma does not cover all edge cases
            arr = valTrim ? valTrim.split(',') : [];
        }
        return arr.map((val) => (0, exports.convertCell)(type, val));
    }
    return value;
};
exports.toArray = toArray;
/**
 * Fixes timestamp to be ISO-8601. Swaps the space between the date and time for a 'T'
 * See https://github.com/supabase/supabase/issues/18
 *
 * @example toTimestampString('2019-09-10 00:00:00')
 * //=> '2019-09-10T00:00:00'
 */
const toTimestampString = (value) => {
    if (typeof value === 'string') {
        return value.replace(' ', 'T');
    }
    return value;
};
exports.toTimestampString = toTimestampString;
const httpEndpointURL = (socketUrl) => {
    const wsUrl = new URL(socketUrl);
    wsUrl.protocol = wsUrl.protocol.replace(/^ws/i, 'http');
    wsUrl.pathname = wsUrl.pathname
        .replace(/\/+$/, '') // remove all trailing slashes
        .replace(/\/socket\/websocket$/i, '') // remove the socket/websocket path
        .replace(/\/socket$/i, '') // remove the socket path
        .replace(/\/websocket$/i, ''); // remove the websocket path
    if (wsUrl.pathname === '' || wsUrl.pathname === '/') {
        wsUrl.pathname = '/api/broadcast';
    }
    else {
        wsUrl.pathname = wsUrl.pathname + '/api/broadcast';
    }
    return wsUrl.href;
};
exports.httpEndpointURL = httpEndpointURL;
//# sourceMappingURL=transformers.js.map

/***/ }),

/***/ 152:
/***/ ((__unused_webpack_module, exports) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.version = void 0;
// Generated automatically during releases by scripts/update-version-files.ts
// This file provides runtime access to the package version for:
// - HTTP request headers (e.g., X-Client-Info header for API requests)
// - Debugging and support (identifying which version is running)
// - Telemetry and logging (version reporting in errors/analytics)
// - Ensuring build artifacts match the published package version
exports.version = '2.98.0';
//# sourceMappingURL=version.js.map

/***/ }),

/***/ 2643:
/***/ ((__unused_webpack_module, exports) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.WebSocketFactory = void 0;
/**
 * Utilities for creating WebSocket instances across runtimes.
 */
class WebSocketFactory {
    /**
     * Static-only utility – prevent instantiation.
     */
    constructor() { }
    static detectEnvironment() {
        var _a;
        if (typeof WebSocket !== 'undefined') {
            return { type: 'native', constructor: WebSocket };
        }
        if (typeof globalThis !== 'undefined' && typeof globalThis.WebSocket !== 'undefined') {
            return { type: 'native', constructor: globalThis.WebSocket };
        }
        if (typeof global !== 'undefined' && typeof global.WebSocket !== 'undefined') {
            return { type: 'native', constructor: global.WebSocket };
        }
        if (typeof globalThis !== 'undefined' &&
            typeof globalThis.WebSocketPair !== 'undefined' &&
            typeof globalThis.WebSocket === 'undefined') {
            return {
                type: 'cloudflare',
                error: 'Cloudflare Workers detected. WebSocket clients are not supported in Cloudflare Workers.',
                workaround: 'Use Cloudflare Workers WebSocket API for server-side WebSocket handling, or deploy to a different runtime.',
            };
        }
        if ((typeof globalThis !== 'undefined' && globalThis.EdgeRuntime) ||
            (typeof navigator !== 'undefined' && ((_a = navigator.userAgent) === null || _a === void 0 ? void 0 : _a.includes('Vercel-Edge')))) {
            return {
                type: 'unsupported',
                error: 'Edge runtime detected (Vercel Edge/Netlify Edge). WebSockets are not supported in edge functions.',
                workaround: 'Use serverless functions or a different deployment target for WebSocket functionality.',
            };
        }
        // Use dynamic property access to avoid Next.js Edge Runtime static analysis warnings
        const _process = globalThis['process'];
        if (_process) {
            const processVersions = _process['versions'];
            if (processVersions && processVersions['node']) {
                // Remove 'v' prefix if present and parse the major version
                const versionString = processVersions['node'];
                const nodeVersion = parseInt(versionString.replace(/^v/, '').split('.')[0]);
                // Node.js 22+ should have native WebSocket
                if (nodeVersion >= 22) {
                    // Check if native WebSocket is available (should be in Node.js 22+)
                    if (typeof globalThis.WebSocket !== 'undefined') {
                        return { type: 'native', constructor: globalThis.WebSocket };
                    }
                    // If not available, user needs to provide it
                    return {
                        type: 'unsupported',
                        error: `Node.js ${nodeVersion} detected but native WebSocket not found.`,
                        workaround: 'Provide a WebSocket implementation via the transport option.',
                    };
                }
                // Node.js < 22 doesn't have native WebSocket
                return {
                    type: 'unsupported',
                    error: `Node.js ${nodeVersion} detected without native WebSocket support.`,
                    workaround: 'For Node.js < 22, install "ws" package and provide it via the transport option:\n' +
                        'import ws from "ws"\n' +
                        'new RealtimeClient(url, { transport: ws })',
                };
            }
        }
        return {
            type: 'unsupported',
            error: 'Unknown JavaScript runtime without WebSocket support.',
            workaround: "Ensure you're running in a supported environment (browser, Node.js, Deno) or provide a custom WebSocket implementation.",
        };
    }
    /**
     * Returns the best available WebSocket constructor for the current runtime.
     *
     * @example
     * ```ts
     * const WS = WebSocketFactory.getWebSocketConstructor()
     * const socket = new WS('wss://realtime.supabase.co/socket')
     * ```
     */
    static getWebSocketConstructor() {
        const env = this.detectEnvironment();
        if (env.constructor) {
            return env.constructor;
        }
        let errorMessage = env.error || 'WebSocket not supported in this environment.';
        if (env.workaround) {
            errorMessage += `\n\nSuggested solution: ${env.workaround}`;
        }
        throw new Error(errorMessage);
    }
    /**
     * Creates a WebSocket using the detected constructor.
     *
     * @example
     * ```ts
     * const socket = WebSocketFactory.createWebSocket('wss://realtime.supabase.co/socket')
     * ```
     */
    static createWebSocket(url, protocols) {
        const WS = this.getWebSocketConstructor();
        return new WS(url, protocols);
    }
    /**
     * Detects whether the runtime can establish WebSocket connections.
     *
     * @example
     * ```ts
     * if (!WebSocketFactory.isWebSocketSupported()) {
     *   console.warn('Falling back to long polling')
     * }
     * ```
     */
    static isWebSocketSupported() {
        try {
            const env = this.detectEnvironment();
            return env.type === 'native' || env.type === 'ws';
        }
        catch (_a) {
            return false;
        }
    }
}
exports.WebSocketFactory = WebSocketFactory;
exports["default"] = WebSocketFactory;
//# sourceMappingURL=websocket-factory.js.map

/***/ }),

/***/ 4432:
/***/ ((__unused_webpack_module, exports) => {

"use strict";
var __webpack_unused_export__;

__webpack_unused_export__ = ({
    value: true
});
Object.defineProperty(exports, "Z", ({
    enumerable: true,
    get: function() {
        return _asyncToGenerator;
    }
}));
function asyncGeneratorStep(gen, resolve, reject, _next, _throw, key, arg) {
    try {
        var info = gen[key](arg);
        var value = info.value;
    } catch (error) {
        reject(error);
        return;
    }
    if (info.done) {
        resolve(value);
    } else {
        Promise.resolve(value).then(_next, _throw);
    }
}
function _asyncToGenerator(fn) {
    return function() {
        var self = this, args = arguments;
        return new Promise(function(resolve, reject) {
            var gen = fn.apply(self, args);
            function _next(value) {
                asyncGeneratorStep(gen, resolve, reject, _next, _throw, "next", value);
            }
            function _throw(err) {
                asyncGeneratorStep(gen, resolve, reject, _next, _throw, "throw", err);
            }
            _next(undefined);
        });
    };
}


/***/ }),

/***/ 7688:
/***/ ((__unused_webpack_module, exports) => {

"use strict";
var __webpack_unused_export__;

__webpack_unused_export__ = ({
    value: true
});
Object.defineProperty(exports, "Z", ({
    enumerable: true,
    get: function() {
        return _extends;
    }
}));
function extends_() {
    extends_ = Object.assign || function(target) {
        for(var i = 1; i < arguments.length; i++){
            var source = arguments[i];
            for(var key in source){
                if (Object.prototype.hasOwnProperty.call(source, key)) {
                    target[key] = source[key];
                }
            }
        }
        return target;
    };
    return extends_.apply(this, arguments);
}
function _extends() {
    return extends_.apply(this, arguments);
}


/***/ }),

/***/ 6356:
/***/ ((__unused_webpack_module, exports) => {

"use strict";
var __webpack_unused_export__;

__webpack_unused_export__ = ({
    value: true
});
Object.defineProperty(exports, "Z", ({
    enumerable: true,
    get: function() {
        return _interopRequireDefault;
    }
}));
function _interopRequireDefault(obj) {
    return obj && obj.__esModule ? obj : {
        default: obj
    };
}


/***/ }),

/***/ 1644:
/***/ ((__unused_webpack_module, exports) => {

"use strict";
var __webpack_unused_export__;

__webpack_unused_export__ = ({
    value: true
});
Object.defineProperty(exports, "Z", ({
    enumerable: true,
    get: function() {
        return _interopRequireWildcard;
    }
}));
function _getRequireWildcardCache(nodeInterop) {
    if (typeof WeakMap !== "function") return null;
    var cacheBabelInterop = new WeakMap();
    var cacheNodeInterop = new WeakMap();
    return (_getRequireWildcardCache = function _getRequireWildcardCache(nodeInterop) {
        return nodeInterop ? cacheNodeInterop : cacheBabelInterop;
    })(nodeInterop);
}
function _interopRequireWildcard(obj, nodeInterop) {
    if (!nodeInterop && obj && obj.__esModule) {
        return obj;
    }
    if (obj === null || typeof obj !== "object" && typeof obj !== "function") {
        return {
            default: obj
        };
    }
    var cache = _getRequireWildcardCache(nodeInterop);
    if (cache && cache.has(obj)) {
        return cache.get(obj);
    }
    var newObj = {};
    var hasPropertyDescriptor = Object.defineProperty && Object.getOwnPropertyDescriptor;
    for(var key in obj){
        if (key !== "default" && Object.prototype.hasOwnProperty.call(obj, key)) {
            var desc = hasPropertyDescriptor ? Object.getOwnPropertyDescriptor(obj, key) : null;
            if (desc && (desc.get || desc.set)) {
                Object.defineProperty(newObj, key, desc);
            } else {
                newObj[key] = obj[key];
            }
        }
    }
    newObj.default = obj;
    if (cache) {
        cache.set(obj, newObj);
    }
    return newObj;
}


/***/ }),

/***/ 2495:
/***/ ((__unused_webpack_module, exports) => {

"use strict";
var __webpack_unused_export__;

__webpack_unused_export__ = ({
    value: true
});
Object.defineProperty(exports, "Z", ({
    enumerable: true,
    get: function() {
        return _objectWithoutPropertiesLoose;
    }
}));
function _objectWithoutPropertiesLoose(source, excluded) {
    if (source == null) return {};
    var target = {};
    var sourceKeys = Object.keys(source);
    var key, i;
    for(i = 0; i < sourceKeys.length; i++){
        key = sourceKeys[i];
        if (excluded.indexOf(key) >= 0) continue;
        target[key] = source[key];
    }
    return target;
}


/***/ }),

/***/ 1645:
/***/ ((module, exports, __webpack_require__) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.addBasePath = addBasePath;

var _addPathPrefix = __webpack_require__(1751);

var _normalizeTrailingSlash = __webpack_require__(8830);

const basePath =  false || '';

function addBasePath(path, required) {
  if (false) {}

  return (0, _normalizeTrailingSlash).normalizePathTrailingSlash((0, _addPathPrefix).addPathPrefix(path, basePath));
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 939:
/***/ ((module, exports, __webpack_require__) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.addLocale = void 0;

var _normalizeTrailingSlash = __webpack_require__(8830);

const addLocale = (path, ...args) => {
  if (false) {}

  return path;
};

exports.addLocale = addLocale;

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 5444:
/***/ ((module, exports) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.FLIGHT_PARAMETERS = exports.RSC_VARY_HEADER = exports.RSC_CONTENT_TYPE_HEADER = exports.FETCH_CACHE_HEADER = exports.NEXT_ROUTER_PREFETCH = exports.NEXT_ROUTER_STATE_TREE = exports.ACTION = exports.RSC = void 0;
const RSC = 'RSC';
exports.RSC = RSC;
const ACTION = 'Next-Action';
exports.ACTION = ACTION;
const NEXT_ROUTER_STATE_TREE = 'Next-Router-State-Tree';
exports.NEXT_ROUTER_STATE_TREE = NEXT_ROUTER_STATE_TREE;
const NEXT_ROUTER_PREFETCH = 'Next-Router-Prefetch';
exports.NEXT_ROUTER_PREFETCH = NEXT_ROUTER_PREFETCH;
const FETCH_CACHE_HEADER = 'x-vercel-sc-headers';
exports.FETCH_CACHE_HEADER = FETCH_CACHE_HEADER;
const RSC_CONTENT_TYPE_HEADER = 'text/x-component';
exports.RSC_CONTENT_TYPE_HEADER = RSC_CONTENT_TYPE_HEADER;
const RSC_VARY_HEADER = `${RSC}, ${NEXT_ROUTER_STATE_TREE}, ${NEXT_ROUTER_PREFETCH}`;
exports.RSC_VARY_HEADER = RSC_VARY_HEADER;
const FLIGHT_PARAMETERS = [[RSC], [NEXT_ROUTER_STATE_TREE], [NEXT_ROUTER_PREFETCH]];
exports.FLIGHT_PARAMETERS = FLIGHT_PARAMETERS;

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 5197:
/***/ ((module, exports, __webpack_require__) => {

"use client";
"use strict";

Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports["default"] = AppRouter;
exports.urlToUrlWithoutFlightMarker = urlToUrlWithoutFlightMarker;

var _async_to_generator = (__webpack_require__(4432)/* ["default"] */ .Z);

var _interop_require_wildcard = (__webpack_require__(1644)/* ["default"] */ .Z);

var _object_without_properties_loose = (__webpack_require__(2495)/* ["default"] */ .Z);

var _react = _interop_require_wildcard(__webpack_require__(8038));

var _appRouterContext = __webpack_require__(3280);

var _routerReducer = __webpack_require__(3840);

var _routerReducerTypes = __webpack_require__(4159);

var _createHrefFromUrl = __webpack_require__(9169);

var _hooksClientContext = __webpack_require__(9274);

var _useReducerWithDevtools = __webpack_require__(4997);

var _errorBoundary = __webpack_require__(2835);

var _createInitialRouterState = __webpack_require__(7253);

var _fetchServerResponse = __webpack_require__(2426);

var _isBot = __webpack_require__(1897);

var _addBasePath = __webpack_require__(1645);

function AppRouter(props) {
  const {
    globalErrorComponent
  } = props,
        rest = _object_without_properties_loose(props, ["globalErrorComponent"]);

  return /*#__PURE__*/_react.default.createElement(_errorBoundary.ErrorBoundary, {
    errorComponent: globalErrorComponent
  }, /*#__PURE__*/_react.default.createElement(Router, Object.assign({}, rest)));
}

const isServer = true; // Ensure the initialParallelRoutes are not combined because of double-rendering in the browser with Strict Mode.

let initialParallelRoutes = isServer ? null : new Map();

function urlToUrlWithoutFlightMarker(url) {
  const urlWithoutFlightParameters = new URL(url, location.origin); // TODO-APP: handle .rsc for static export case

  return urlWithoutFlightParameters;
}

const HotReloader =  true ? null : 0;
const prefetched = new Set();

function isExternalURL(url) {
  return url.origin !== window.location.origin;
}
/**
 * The global router that wraps the application components.
 */


function Router({
  initialHead,
  initialTree,
  initialCanonicalUrl,
  children,
  assetPrefix
}) {
  const initialState = (0, _react).useMemo(() => (0, _createInitialRouterState).createInitialRouterState({
    children,
    initialCanonicalUrl,
    initialTree,
    initialParallelRoutes,
    isServer,
    location: !isServer ? window.location : null,
    initialHead
  }), [children, initialCanonicalUrl, initialTree, initialHead]);
  const [{
    tree,
    cache,
    prefetchCache,
    pushRef,
    focusAndScrollRef,
    canonicalUrl
  }, dispatch, sync] = (0, _useReducerWithDevtools).useReducerWithReduxDevtools(_routerReducer.reducer, initialState);
  (0, _react).useEffect(() => {
    // Ensure initialParallelRoutes is cleaned up from memory once it's used.
    initialParallelRoutes = null;
  }, []); // Add memoized pathname/query for useSearchParams and usePathname.

  const {
    searchParams,
    pathname
  } = (0, _react).useMemo(() => {
    const url = new URL(canonicalUrl,  true ? 'http://n' : 0);
    return {
      // This is turned into a readonly class in `useSearchParams`
      searchParams: url.searchParams,
      pathname: url.pathname
    };
  }, [canonicalUrl]);
  /**
  * Server response that only patches the cache and tree.
  */

  const changeByServerResponse = (0, _react).useCallback((previousTree, flightData, overrideCanonicalUrl) => {
    dispatch({
      type: _routerReducerTypes.ACTION_SERVER_PATCH,
      flightData,
      previousTree,
      overrideCanonicalUrl,
      cache: {
        status: _appRouterContext.CacheStates.LAZY_INITIALIZED,
        data: null,
        subTreeData: null,
        parallelRoutes: new Map()
      },
      mutable: {}
    });
  }, [dispatch]);
  /**
  * The app router that is exposed through `useRouter`. It's only concerned with dispatching actions to the reducer, does not hold state.
  */

  const appRouter = (0, _react).useMemo(() => {
    const navigate = (href, navigateType, forceOptimisticNavigation) => {
      const url = new URL((0, _addBasePath).addBasePath(href), location.origin);
      return dispatch({
        type: _routerReducerTypes.ACTION_NAVIGATE,
        url,
        isExternalUrl: isExternalURL(url),
        locationSearch: location.search,
        forceOptimisticNavigation,
        navigateType,
        cache: {
          status: _appRouterContext.CacheStates.LAZY_INITIALIZED,
          data: null,
          subTreeData: null,
          parallelRoutes: new Map()
        },
        mutable: {}
      });
    };

    const routerInstance = {
      back: () => window.history.back(),
      forward: () => window.history.forward(),
      prefetch: _async_to_generator(function* (href) {
        const hrefWithBasePath = (0, _addBasePath).addBasePath(href); // If prefetch has already been triggered, don't trigger it again.

        if (prefetched.has(hrefWithBasePath) ||  false && 0) {
          return;
        }

        prefetched.add(hrefWithBasePath);
        const url = new URL(hrefWithBasePath, location.origin); // External urls can't be prefetched in the same way.

        if (isExternalURL(url)) {
          return;
        }

        try {
          var ref;
          const routerTree = ((ref = window.history.state) == null ? void 0 : ref.tree) || initialTree;
          const serverResponse = yield (0, _fetchServerResponse).fetchServerResponse(url, // initialTree is used when history.state.tree is missing because the history state is set in `useEffect` below, it being missing means this is the hydration case.
          routerTree, true); // @ts-ignore startTransition exists

          _react.default.startTransition(() => {
            dispatch({
              type: _routerReducerTypes.ACTION_PREFETCH,
              url,
              tree: routerTree,
              serverResponse
            });
          });
        } catch (err) {
          console.error('PREFETCH ERROR', err);
        }
      }),
      replace: (href, options = {}) => {
        // @ts-ignore startTransition exists
        _react.default.startTransition(() => {
          navigate(href, 'replace', Boolean(options.forceOptimisticNavigation));
        });
      },
      push: (href, options = {}) => {
        // @ts-ignore startTransition exists
        _react.default.startTransition(() => {
          navigate(href, 'push', Boolean(options.forceOptimisticNavigation));
        });
      },
      refresh: () => {
        // @ts-ignore startTransition exists
        _react.default.startTransition(() => {
          dispatch({
            type: _routerReducerTypes.ACTION_REFRESH,
            cache: {
              status: _appRouterContext.CacheStates.LAZY_INITIALIZED,
              data: null,
              subTreeData: null,
              parallelRoutes: new Map()
            },
            mutable: {},
            origin: window.location.origin
          });
        });
      }
    };
    return routerInstance;
  }, [dispatch, initialTree]);
  (0, _react).useEffect(() => {
    // When mpaNavigation flag is set do a hard navigation to the new url.
    if (pushRef.mpaNavigation) {
      const location = window.location;

      if (pushRef.pendingPush) {
        location.assign(canonicalUrl);
      } else {
        location.replace(canonicalUrl);
      }

      return;
    } // Identifier is shortened intentionally.
    // __NA is used to identify if the history entry can be handled by the app-router.
    // __N is used to identify if the history entry can be handled by the old router.


    const historyState = {
      __NA: true,
      tree
    };

    if (pushRef.pendingPush && (0, _createHrefFromUrl).createHrefFromUrl(new URL(window.location.href)) !== canonicalUrl) {
      // This intentionally mutates React state, pushRef is overwritten to ensure additional push/replace calls do not trigger an additional history entry.
      pushRef.pendingPush = false;
      window.history.pushState(historyState, '', canonicalUrl);
    } else {
      window.history.replaceState(historyState, '', canonicalUrl);
    }

    sync();
  }, [tree, pushRef, canonicalUrl, sync]); // Add `window.nd` for debugging purposes.
  // This is not meant for use in applications as concurrent rendering will affect the cache/tree/router.

  if (false) {}
  /**
  * Handle popstate event, this is used to handle back/forward in the browser.
  * By default dispatches ACTION_RESTORE, however if the history entry was not pushed/replaced by app-router it will reload the page.
  * That case can happen when the old router injected the history entry.
  */


  const onPopState = (0, _react).useCallback(({
    state
  }) => {
    if (!state) {
      // TODO-APP: this case only happens when pushState/replaceState was called outside of Next.js. It should probably reload the page in this case.
      return;
    } // This case happens when the history entry was pushed by the `pages` router.


    if (!state.__NA) {
      window.location.reload();
      return;
    } // @ts-ignore useTransition exists
    // TODO-APP: Ideally the back button should not use startTransition as it should apply the updates synchronously
    // Without startTransition works if the cache is there for this path


    _react.default.startTransition(() => {
      dispatch({
        type: _routerReducerTypes.ACTION_RESTORE,
        url: new URL(window.location.href),
        tree: state.tree
      });
    });
  }, [dispatch]); // Register popstate event to call onPopstate.

  (0, _react).useEffect(() => {
    window.addEventListener('popstate', onPopState);
    return () => {
      window.removeEventListener('popstate', onPopState);
    };
  }, [onPopState]);

  const content = /*#__PURE__*/_react.default.createElement(_react.default.Fragment, null, cache.subTreeData);

  return /*#__PURE__*/_react.default.createElement(_hooksClientContext.PathnameContext.Provider, {
    value: pathname
  }, /*#__PURE__*/_react.default.createElement(_hooksClientContext.SearchParamsContext.Provider, {
    value: searchParams
  }, /*#__PURE__*/_react.default.createElement(_appRouterContext.GlobalLayoutRouterContext.Provider, {
    value: {
      changeByServerResponse,
      tree,
      focusAndScrollRef
    }
  }, /*#__PURE__*/_react.default.createElement(_appRouterContext.AppRouterContext.Provider, {
    value: appRouter
  }, /*#__PURE__*/_react.default.createElement(_appRouterContext.LayoutRouterContext.Provider, {
    value: {
      childNodes: cache.parallelRoutes,
      tree: tree,
      // Root node always has `url`
      // Provided in AppTreeContext to ensure it can be overwritten in layout-router
      url: canonicalUrl,
      headRenderedAboveThisLevel: false
    }
  }, HotReloader ? /*#__PURE__*/_react.default.createElement(HotReloader, {
    assetPrefix: assetPrefix
  }, content) : content)))));
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 4418:
/***/ ((module, exports) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.createAsyncLocalStorage = createAsyncLocalStorage;

class FakeAsyncLocalStorage {
  disable() {
    throw new Error('Invariant: AsyncLocalStorage accessed in runtime where it is not available');
  }

  getStore() {
    // This fake implementation of AsyncLocalStorage always returns `undefined`.
    return undefined;
  }

  run() {
    throw new Error('Invariant: AsyncLocalStorage accessed in runtime where it is not available');
  }

  exit() {
    throw new Error('Invariant: AsyncLocalStorage accessed in runtime where it is not available');
  }

  enterWith() {
    throw new Error('Invariant: AsyncLocalStorage accessed in runtime where it is not available');
  }

}

function createAsyncLocalStorage() {
  if (globalThis.AsyncLocalStorage) {
    return new globalThis.AsyncLocalStorage();
  }

  return new FakeAsyncLocalStorage();
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 6662:
/***/ ((module, exports, __webpack_require__) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.bailoutToClientRendering = bailoutToClientRendering;

var _dynamicNoSsr = __webpack_require__(7259);

var _staticGenerationAsyncStorage = __webpack_require__(6064);

function bailoutToClientRendering() {
  const staticGenerationStore = _staticGenerationAsyncStorage.staticGenerationAsyncStorage.getStore();

  if (staticGenerationStore == null ? void 0 : staticGenerationStore.forceStatic) {
    return true;
  }

  if (staticGenerationStore == null ? void 0 : staticGenerationStore.isStaticGeneration) {
    (0, _dynamicNoSsr).suspense();
  }

  return false;
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 6157:
/***/ ((module, exports, __webpack_require__) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.clientHookInServerComponentError = clientHookInServerComponentError;

var _interop_require_default = (__webpack_require__(6356)/* ["default"] */ .Z);

var _react = _interop_require_default(__webpack_require__(8038));

function clientHookInServerComponentError(hookName) {
  if (false) {}
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 2835:
/***/ ((module, exports, __webpack_require__) => {

"use client";
"use strict";

Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports["default"] = GlobalError;
exports.ErrorBoundary = ErrorBoundary;

var _interop_require_default = (__webpack_require__(6356)/* ["default"] */ .Z);

var _react = _interop_require_default(__webpack_require__(8038));

function GlobalError({
  error
}) {
  return /*#__PURE__*/_react.default.createElement("html", null, /*#__PURE__*/_react.default.createElement("head", null), /*#__PURE__*/_react.default.createElement("body", null, /*#__PURE__*/_react.default.createElement("div", {
    style: styles.error
  }, /*#__PURE__*/_react.default.createElement("div", {
    style: styles.desc
  }, /*#__PURE__*/_react.default.createElement("h2", {
    style: styles.text
  }, "Application error: a client-side exception has occurred (see the browser console for more information)."), (error == null ? void 0 : error.digest) && /*#__PURE__*/_react.default.createElement("p", {
    style: styles.text
  }, `Digest: ${error.digest}`)))));
}

const styles = {
  error: {
    // https://github.com/sindresorhus/modern-normalize/blob/main/modern-normalize.css#L38-L52
    fontFamily: 'system-ui,"Segoe UI",Roboto,Helvetica,Arial,sans-serif,"Apple Color Emoji","Segoe UI Emoji"',
    height: '100vh',
    textAlign: 'center',
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    justifyContent: 'center'
  },
  desc: {
    textAlign: 'left'
  },
  text: {
    fontSize: '14px',
    fontWeight: 400,
    lineHeight: '3em',
    margin: 0
  }
};

class ErrorBoundaryHandler extends _react.default.Component {
  static getDerivedStateFromError(error) {
    return {
      error
    };
  }

  render() {
    if (this.state.error) {
      return /*#__PURE__*/_react.default.createElement(_react.default.Fragment, null, this.props.errorStyles, /*#__PURE__*/_react.default.createElement(this.props.errorComponent, {
        error: this.state.error,
        reset: this.reset
      }));
    }

    return this.props.children;
  }

  constructor(props) {
    super(props);

    this.reset = () => {
      this.setState({
        error: null
      });
    };

    this.state = {
      error: null
    };
  }

}

exports.ErrorBoundaryHandler = ErrorBoundaryHandler;

function ErrorBoundary({
  errorComponent,
  errorStyles,
  children
}) {
  if (errorComponent) {
    return /*#__PURE__*/_react.default.createElement(ErrorBoundaryHandler, {
      errorComponent: errorComponent,
      errorStyles: errorStyles
    }, children);
  }

  return /*#__PURE__*/_react.default.createElement(_react.default.Fragment, null, children);
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 8614:
/***/ ((module, exports) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.createInfinitePromise = createInfinitePromise;
/**
 * Used to cache in createInfinitePromise
 */

let infinitePromise;

function createInfinitePromise() {
  if (!infinitePromise) {
    // Only create the Promise once
    infinitePromise = new Promise(() => {// This is used to debug when the rendering is never updated.
      // setTimeout(() => {
      //   infinitePromise = new Error('Infinite promise')
      //   resolve()
      // }, 5000)
    });
  }

  return infinitePromise;
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 8536:
/***/ ((module, exports, __webpack_require__) => {

"use client";
"use strict";

Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports["default"] = OuterLayoutRouter;
exports.InnerLayoutRouter = InnerLayoutRouter;

var _extends = (__webpack_require__(7688)/* ["default"] */ .Z);

var _interop_require_default = (__webpack_require__(6356)/* ["default"] */ .Z);

var _interop_require_wildcard = (__webpack_require__(1644)/* ["default"] */ .Z);

var _react = _interop_require_wildcard(__webpack_require__(8038));

var _reactDom = _interop_require_default(__webpack_require__(8704));

var _appRouterContext = __webpack_require__(3280);

var _fetchServerResponse = __webpack_require__(2426);

var _infinitePromise = __webpack_require__(8614);

var _errorBoundary = __webpack_require__(2835);

var _matchSegments = __webpack_require__(140);

var _navigation = __webpack_require__(3745);

var _handleSmoothScroll = __webpack_require__(1668);

var _redirect = __webpack_require__(483);

var _findHeadInCache = __webpack_require__(9726);

function OuterLayoutRouter({
  parallelRouterKey,
  segmentPath,
  childProp,
  error,
  errorStyles,
  templateStyles,
  loading,
  loadingStyles,
  hasLoading,
  template,
  notFound,
  notFoundStyles
}) {
  const context = (0, _react).useContext(_appRouterContext.LayoutRouterContext);

  if (!context) {
    throw new Error('invariant expected layout router to be mounted');
  }

  const {
    childNodes,
    tree,
    url,
    headRenderedAboveThisLevel
  } = context; // Get the current parallelRouter cache node

  let childNodesForParallelRouter = childNodes.get(parallelRouterKey); // If the parallel router cache node does not exist yet, create it.
  // This writes to the cache when there is no item in the cache yet. It never *overwrites* existing cache items which is why it's safe in concurrent mode.

  if (!childNodesForParallelRouter) {
    childNodes.set(parallelRouterKey, new Map());
    childNodesForParallelRouter = childNodes.get(parallelRouterKey);
  } // Get the active segment in the tree
  // The reason arrays are used in the data format is that these are transferred from the server to the browser so it's optimized to save bytes.


  const treeSegment = tree[1][parallelRouterKey][0];
  const childPropSegment = Array.isArray(childProp.segment) ? childProp.segment[1] : childProp.segment; // If segment is an array it's a dynamic route and we want to read the dynamic route value as the segment to get from the cache.

  const currentChildSegment = Array.isArray(treeSegment) ? treeSegment[1] : treeSegment;
  /**
  * Decides which segments to keep rendering, all segments that are not active will be wrapped in `<Offscreen>`.
  */
  // TODO-APP: Add handling of `<Offscreen>` when it's available.

  const preservedSegments = [currentChildSegment];
  return /*#__PURE__*/_react.default.createElement(_react.default.Fragment, null, preservedSegments.map(preservedSegment => {
    return (
      /*
      - Error boundary
      - Only renders error boundary if error component is provided.
      - Rendered for each segment to ensure they have their own error state.
      - Loading boundary
      - Only renders suspense boundary if loading components is provided.
      - Rendered for each segment to ensure they have their own loading state.
      - Passed to the router during rendering to ensure it can be immediately rendered when suspending on a Flight fetch.
      */

      /*#__PURE__*/
      _react.default.createElement(_appRouterContext.TemplateContext.Provider, {
        key: preservedSegment,
        value: /*#__PURE__*/_react.default.createElement(_errorBoundary.ErrorBoundary, {
          errorComponent: error,
          errorStyles: errorStyles
        }, /*#__PURE__*/_react.default.createElement(LoadingBoundary, {
          hasLoading: hasLoading,
          loading: loading,
          loadingStyles: loadingStyles
        }, /*#__PURE__*/_react.default.createElement(NotFoundBoundary, {
          notFound: notFound,
          notFoundStyles: notFoundStyles
        }, /*#__PURE__*/_react.default.createElement(RedirectBoundary, null, /*#__PURE__*/_react.default.createElement(InnerLayoutRouter, {
          parallelRouterKey: parallelRouterKey,
          url: url,
          tree: tree,
          childNodes: childNodesForParallelRouter,
          childProp: childPropSegment === preservedSegment ? childProp : null,
          segmentPath: segmentPath,
          path: preservedSegment,
          isActive: currentChildSegment === preservedSegment,
          headRenderedAboveThisLevel: headRenderedAboveThisLevel
        })))))
      }, /*#__PURE__*/_react.default.createElement(_react.default.Fragment, null, templateStyles, template))
    );
  }));
}
/**
 * Add refetch marker to router state at the point of the current layout segment.
 * This ensures the response returned is not further down than the current layout segment.
 */


function walkAddRefetch(segmentPathToWalk, treeToRecreate) {
  if (segmentPathToWalk) {
    const [segment, parallelRouteKey] = segmentPathToWalk;
    const isLast = segmentPathToWalk.length === 2;

    if ((0, _matchSegments).matchSegment(treeToRecreate[0], segment)) {
      if (treeToRecreate[1].hasOwnProperty(parallelRouteKey)) {
        if (isLast) {
          const subTree = walkAddRefetch(undefined, treeToRecreate[1][parallelRouteKey]);
          return [treeToRecreate[0], _extends({}, treeToRecreate[1], {
            [parallelRouteKey]: [subTree[0], subTree[1], subTree[2], 'refetch']
          })];
        }

        return [treeToRecreate[0], _extends({}, treeToRecreate[1], {
          [parallelRouteKey]: walkAddRefetch(segmentPathToWalk.slice(2), treeToRecreate[1][parallelRouteKey])
        })];
      }
    }
  }

  return treeToRecreate;
} // TODO-APP: Replace with new React API for finding dom nodes without a `ref` when available

/**
 * Wraps ReactDOM.findDOMNode with additional logic to hide React Strict Mode warning
 */


function findDOMNode(instance) {
  // Tree-shake for server bundle
  if (false) {} // Only apply strict mode warning when not in production

  if (false) {}

  return _reactDom.default.findDOMNode(instance);
}
/**
 * Check if the top corner of the HTMLElement is in the viewport.
 */


function topOfElementInViewport(element, viewportHeight) {
  const rect = element.getBoundingClientRect();
  return rect.top >= 0 && rect.top <= viewportHeight;
}

class ScrollAndFocusHandler extends _react.default.Component {
  componentDidMount() {
    // Handle scroll and focus, it's only applied once in the first useEffect that triggers that changed.
    const {
      focusAndScrollRef
    } = this.props; // `findDOMNode` is tricky because it returns just the first child if the component is a fragment.
    // This already caused a bug where the first child was a <link/> in head.

    const domNode = findDOMNode(this);

    if (focusAndScrollRef.apply && domNode instanceof HTMLElement) {
      // State is mutated to ensure that the focus and scroll is applied only once.
      focusAndScrollRef.apply = false;
      (0, _handleSmoothScroll).handleSmoothScroll(() => {
        // Store the current viewport height because reading `clientHeight` causes a reflow,
        // and it won't change during this function.
        const htmlElement = document.documentElement;
        const viewportHeight = htmlElement.clientHeight; // If the element's top edge is already in the viewport, exit early.

        if (topOfElementInViewport(domNode, viewportHeight)) {
          return;
        } // Otherwise, try scrolling go the top of the document to be backward compatible with pages
        // scrollIntoView() called on `<html/>` element scrolls horizontally on chrome and firefox (that shouldn't happen)
        // We could use it to scroll horizontally following RTL but that also seems to be broken - it will always scroll left
        // scrollLeft = 0 also seems to ignore RTL and manually checking for RTL is too much hassle so we will scroll just vertically


        htmlElement.scrollTop = 0; // Scroll to domNode if domNode is not in viewport when scrolled to top of document

        if (!topOfElementInViewport(domNode, viewportHeight)) {
          // Scroll into view doesn't scroll horizontally by default when not needed
          domNode.scrollIntoView();
        }
      }, {
        // We will force layout by querying domNode position
        dontForceLayout: true
      }); // Set focus on the element

      domNode.focus();
    }
  }

  render() {
    return this.props.children;
  }

}

function InnerLayoutRouter({
  parallelRouterKey,
  url,
  childNodes,
  childProp,
  segmentPath,
  tree,
  // TODO-APP: implement `<Offscreen>` when available.
  // isActive,
  path,
  headRenderedAboveThisLevel
}) {
  const context = (0, _react).useContext(_appRouterContext.GlobalLayoutRouterContext);

  if (!context) {
    throw new Error('invariant global layout router not mounted');
  }

  const {
    changeByServerResponse,
    tree: fullTree,
    focusAndScrollRef
  } = context;
  const head = (0, _react).useMemo(() => {
    if (headRenderedAboveThisLevel) {
      return null;
    }

    return (0, _findHeadInCache).findHeadInCache(childNodes, tree[1]);
  }, [childNodes, tree, headRenderedAboveThisLevel]); // Read segment path from the parallel router cache node.

  let childNode = childNodes.get(path); // If childProp is available this means it's the Flight / SSR case.

  if (childProp && // TODO-APP: verify if this can be null based on user code
  childProp.current !== null) {
    if (childNode && childNode.status === _appRouterContext.CacheStates.LAZY_INITIALIZED) {
      // @ts-expect-error TODO-APP: handle changing of the type
      childNode.status = _appRouterContext.CacheStates.READY; // @ts-expect-error TODO-APP: handle changing of the type

      childNode.subTreeData = childProp.current; // Mutates the prop in order to clean up the memory associated with the subTreeData as it is now part of the cache.

      childProp.current = null;
    } else {
      // Add the segment's subTreeData to the cache.
      // This writes to the cache when there is no item in the cache yet. It never *overwrites* existing cache items which is why it's safe in concurrent mode.
      childNodes.set(path, {
        status: _appRouterContext.CacheStates.READY,
        data: null,
        subTreeData: childProp.current,
        parallelRoutes: new Map()
      }); // Mutates the prop in order to clean up the memory associated with the subTreeData as it is now part of the cache.

      childProp.current = null; // In the above case childNode was set on childNodes, so we have to get it from the cacheNodes again.

      childNode = childNodes.get(path);
    }
  } // When childNode is not available during rendering client-side we need to fetch it from the server.


  if (!childNode || childNode.status === _appRouterContext.CacheStates.LAZY_INITIALIZED) {
    /**
    * Router state with refetch marker added
    */
    // TODO-APP: remove ''
    const refetchTree = walkAddRefetch(['', ...segmentPath], fullTree);
    /**
    * Flight data fetch kicked off during render and put into the cache.
    */

    childNodes.set(path, {
      status: _appRouterContext.CacheStates.DATA_FETCH,
      data: (0, _fetchServerResponse).fetchServerResponse(new URL(url, location.origin), refetchTree),
      subTreeData: null,
      head: childNode && childNode.status === _appRouterContext.CacheStates.LAZY_INITIALIZED ? childNode.head : undefined,
      parallelRoutes: childNode && childNode.status === _appRouterContext.CacheStates.LAZY_INITIALIZED ? childNode.parallelRoutes : new Map()
    }); // In the above case childNode was set on childNodes, so we have to get it from the cacheNodes again.

    childNode = childNodes.get(path);
  } // This case should never happen so it throws an error. It indicates there's a bug in the Next.js.


  if (!childNode) {
    throw new Error('Child node should always exist');
  } // This case should never happen so it throws an error. It indicates there's a bug in the Next.js.


  if (childNode.subTreeData && childNode.data) {
    throw new Error('Child node should not have both subTreeData and data');
  } // If cache node has a data request we have to unwrap response by `use` and update the cache.


  if (childNode.data) {
    /**
    * Flight response data
    */
    // When the data has not resolved yet `use` will suspend here.
    const [flightData, overrideCanonicalUrl] = (0, _react).use(childNode.data); // Handle case when navigating to page in `pages` from `app`

    if (typeof flightData === 'string') {
      window.location.href = url;
      return null;
    } // segmentPath from the server does not match the layout's segmentPath


    childNode.data = null; // setTimeout is used to start a new transition during render, this is an intentional hack around React.

    setTimeout(() => {
      // @ts-ignore startTransition exists
      _react.default.startTransition(() => {
        changeByServerResponse(fullTree, flightData, overrideCanonicalUrl);
      });
    }); // Suspend infinitely as `changeByServerResponse` will cause a different part of the tree to be rendered.

    (0, _react).use((0, _infinitePromise).createInfinitePromise());
  } // If cache node has no subTreeData and no data request we have to infinitely suspend as the data will likely flow in from another place.
  // TODO-APP: double check users can't return null in a component that will kick in here.


  if (!childNode.subTreeData) {
    (0, _react).use((0, _infinitePromise).createInfinitePromise());
  }

  const subtree = // The layout router context narrows down tree and childNodes at each level.

  /*#__PURE__*/
  _react.default.createElement(_appRouterContext.LayoutRouterContext.Provider, {
    value: {
      tree: tree[1][parallelRouterKey],
      childNodes: childNode.parallelRoutes,
      // TODO-APP: overriding of url for parallel routes
      url: url,
      headRenderedAboveThisLevel: true
    }
  }, head, childNode.subTreeData); // Ensure root layout is not wrapped in a div as the root layout renders `<html>`


  return /*#__PURE__*/_react.default.createElement(ScrollAndFocusHandler, {
    focusAndScrollRef: focusAndScrollRef
  }, subtree);
}
/**
 * Renders suspense boundary with the provided "loading" property as the fallback.
 * If no loading property is provided it renders the children without a suspense boundary.
 */


function LoadingBoundary({
  children,
  loading,
  loadingStyles,
  hasLoading
}) {
  if (hasLoading) {
    return /*#__PURE__*/_react.default.createElement(_react.default.Suspense, {
      fallback: /*#__PURE__*/_react.default.createElement(_react.default.Fragment, null, loadingStyles, loading)
    }, children);
  }

  return /*#__PURE__*/_react.default.createElement(_react.default.Fragment, null, children);
}

function HandleRedirect({
  redirect
}) {
  const router = (0, _navigation).useRouter();
  (0, _react).useEffect(() => {
    router.replace(redirect, {});
  }, [redirect, router]);
  return null;
}

class RedirectErrorBoundary extends _react.default.Component {
  static getDerivedStateFromError(error) {
    if ((0, _redirect).isRedirectError(error)) {
      const url = (0, _redirect).getURLFromRedirectError(error);
      return {
        redirect: url
      };
    } // Re-throw if error is not for redirect


    throw error;
  }

  render() {
    const redirect = this.state.redirect;

    if (redirect !== null) {
      return /*#__PURE__*/_react.default.createElement(HandleRedirect, {
        redirect: redirect
      });
    }

    return this.props.children;
  }

  constructor(props) {
    super(props);
    this.state = {
      redirect: null
    };
  }

}

function RedirectBoundary({
  children
}) {
  const router = (0, _navigation).useRouter();
  return /*#__PURE__*/_react.default.createElement(RedirectErrorBoundary, {
    router: router
  }, children);
}

class NotFoundErrorBoundary extends _react.default.Component {
  static getDerivedStateFromError(error) {
    if ((error == null ? void 0 : error.digest) === 'NEXT_NOT_FOUND') {
      return {
        notFoundTriggered: true
      };
    } // Re-throw if error is not for 404


    throw error;
  }

  render() {
    if (this.state.notFoundTriggered) {
      return /*#__PURE__*/_react.default.createElement(_react.default.Fragment, null, /*#__PURE__*/_react.default.createElement("meta", {
        name: "robots",
        content: "noindex"
      }), this.props.notFoundStyles, this.props.notFound);
    }

    return this.props.children;
  }

  constructor(props) {
    super(props);
    this.state = {
      notFoundTriggered: false
    };
  }

}

function NotFoundBoundary({
  notFound,
  notFoundStyles,
  children
}) {
  return notFound ? /*#__PURE__*/_react.default.createElement(NotFoundErrorBoundary, {
    notFound: notFound,
    notFoundStyles: notFoundStyles
  }, children) : /*#__PURE__*/_react.default.createElement(_react.default.Fragment, null, children);
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 140:
/***/ ((module, exports) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.matchSegment = void 0;

const matchSegment = (existingSegment, segment) => {
  // Common case: segment is just a string
  if (typeof existingSegment === 'string' && typeof segment === 'string') {
    return existingSegment === segment;
  } // Dynamic parameter case: segment is an array with param/value. Both param and value are compared.


  if (Array.isArray(existingSegment) && Array.isArray(segment)) {
    return existingSegment[0] === segment[0] && existingSegment[1] === segment[1];
  }

  return false;
};

exports.matchSegment = matchSegment;

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 3745:
/***/ ((module, exports, __webpack_require__) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.useSearchParams = useSearchParams;
exports.usePathname = usePathname;
Object.defineProperty(exports, "ServerInsertedHTMLContext", ({
  enumerable: true,
  get: function () {
    return _serverInsertedHtml.ServerInsertedHTMLContext;
  }
}));
Object.defineProperty(exports, "useServerInsertedHTML", ({
  enumerable: true,
  get: function () {
    return _serverInsertedHtml.useServerInsertedHTML;
  }
}));
exports.useRouter = useRouter;
exports.useSelectedLayoutSegments = useSelectedLayoutSegments;
exports.useSelectedLayoutSegment = useSelectedLayoutSegment;
Object.defineProperty(exports, "redirect", ({
  enumerable: true,
  get: function () {
    return _redirect.redirect;
  }
}));
Object.defineProperty(exports, "notFound", ({
  enumerable: true,
  get: function () {
    return _notFound.notFound;
  }
}));

var _react = __webpack_require__(8038);

var _appRouterContext = __webpack_require__(3280);

var _hooksClientContext = __webpack_require__(9274);

var _clientHookInServerComponentError = __webpack_require__(6157);

var _serverInsertedHtml = __webpack_require__(3349);

var _redirect = __webpack_require__(483);

var _notFound = __webpack_require__(7501);

const INTERNAL_URLSEARCHPARAMS_INSTANCE = Symbol('internal for urlsearchparams readonly');

function readonlyURLSearchParamsError() {
  return new Error('ReadonlyURLSearchParams cannot be modified');
}

class ReadonlyURLSearchParams {
  [Symbol.iterator]() {
    return this[INTERNAL_URLSEARCHPARAMS_INSTANCE][Symbol.iterator]();
  }

  append() {
    throw readonlyURLSearchParamsError();
  }

  delete() {
    throw readonlyURLSearchParamsError();
  }

  set() {
    throw readonlyURLSearchParamsError();
  }

  sort() {
    throw readonlyURLSearchParamsError();
  }

  constructor(urlSearchParams) {
    this[INTERNAL_URLSEARCHPARAMS_INSTANCE] = urlSearchParams;
    this.entries = urlSearchParams.entries.bind(urlSearchParams);
    this.forEach = urlSearchParams.forEach.bind(urlSearchParams);
    this.get = urlSearchParams.get.bind(urlSearchParams);
    this.getAll = urlSearchParams.getAll.bind(urlSearchParams);
    this.has = urlSearchParams.has.bind(urlSearchParams);
    this.keys = urlSearchParams.keys.bind(urlSearchParams);
    this.values = urlSearchParams.values.bind(urlSearchParams);
    this.toString = urlSearchParams.toString.bind(urlSearchParams);
  }

}

exports.ReadonlyURLSearchParams = ReadonlyURLSearchParams;

function useSearchParams() {
  (0, _clientHookInServerComponentError).clientHookInServerComponentError('useSearchParams');
  const searchParams = (0, _react).useContext(_hooksClientContext.SearchParamsContext); // In the case where this is `null`, the compat types added in
  // `next-env.d.ts` will add a new overload that changes the return type to
  // include `null`.

  const readonlySearchParams = (0, _react).useMemo(() => {
    if (!searchParams) {
      // When the router is not ready in pages, we won't have the search params
      // available.
      return null;
    }

    return new ReadonlyURLSearchParams(searchParams);
  }, [searchParams]);

  if (true) {
    // AsyncLocalStorage should not be included in the client bundle.
    const {
      bailoutToClientRendering
    } = __webpack_require__(6662);

    if (bailoutToClientRendering()) {
      // TODO-APP: handle dynamic = 'force-static' here and on the client
      return readonlySearchParams;
    }
  }

  return readonlySearchParams;
}

function usePathname() {
  (0, _clientHookInServerComponentError).clientHookInServerComponentError('usePathname'); // In the case where this is `null`, the compat types added in `next-env.d.ts`
  // will add a new overload that changes the return type to include `null`.

  return (0, _react).useContext(_hooksClientContext.PathnameContext);
}

function useRouter() {
  (0, _clientHookInServerComponentError).clientHookInServerComponentError('useRouter');
  const router = (0, _react).useContext(_appRouterContext.AppRouterContext);

  if (router === null) {
    throw new Error('invariant expected app router to be mounted');
  }

  return router;
} // TODO-APP: handle parallel routes


function getSelectedLayoutSegmentPath(tree, parallelRouteKey, first = true, segmentPath = []) {
  let node;

  if (first) {
    // Use the provided parallel route key on the first parallel route
    node = tree[1][parallelRouteKey];
  } else {
    // After first parallel route prefer children, if there's no children pick the first parallel route.
    const parallelRoutes = tree[1];

    var _children;

    node = (_children = parallelRoutes.children) != null ? _children : Object.values(parallelRoutes)[0];
  }

  if (!node) return segmentPath;
  const segment = node[0];
  const segmentValue = Array.isArray(segment) ? segment[1] : segment;
  if (!segmentValue) return segmentPath;
  segmentPath.push(segmentValue);
  return getSelectedLayoutSegmentPath(node, parallelRouteKey, false, segmentPath);
}

function useSelectedLayoutSegments(parallelRouteKey = 'children') {
  (0, _clientHookInServerComponentError).clientHookInServerComponentError('useSelectedLayoutSegments');
  const {
    tree
  } = (0, _react).useContext(_appRouterContext.LayoutRouterContext);
  return getSelectedLayoutSegmentPath(tree, parallelRouteKey);
}

function useSelectedLayoutSegment(parallelRouteKey = 'children') {
  (0, _clientHookInServerComponentError).clientHookInServerComponentError('useSelectedLayoutSegment');
  const selectedLayoutSegments = useSelectedLayoutSegments(parallelRouteKey);

  if (selectedLayoutSegments.length === 0) {
    return null;
  }

  return selectedLayoutSegments[0];
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 7501:
/***/ ((module, exports) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.notFound = notFound;
exports.isNotFoundError = isNotFoundError;
const NOT_FOUND_ERROR_CODE = 'NEXT_NOT_FOUND';

function notFound() {
  // eslint-disable-next-line no-throw-literal
  const error = new Error(NOT_FOUND_ERROR_CODE);
  error.digest = NOT_FOUND_ERROR_CODE;
  throw error;
}

function isNotFoundError(error) {
  return (error == null ? void 0 : error.digest) === NOT_FOUND_ERROR_CODE;
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 483:
/***/ ((module, exports) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.redirect = redirect;
exports.isRedirectError = isRedirectError;
exports.getURLFromRedirectError = getURLFromRedirectError;
const REDIRECT_ERROR_CODE = 'NEXT_REDIRECT';

function redirect(url) {
  // eslint-disable-next-line no-throw-literal
  const error = new Error(REDIRECT_ERROR_CODE);
  error.digest = `${REDIRECT_ERROR_CODE};${url}`;
  throw error;
}

function isRedirectError(error) {
  return typeof (error == null ? void 0 : error.digest) === 'string' && error.digest.startsWith(REDIRECT_ERROR_CODE + ';') && error.digest.length > REDIRECT_ERROR_CODE.length + 1;
}

function getURLFromRedirectError(error) {
  if (!isRedirectError(error)) return null; // Slices off the beginning of the digest that contains the code and the
  // separating ';'.

  return error.digest.slice(REDIRECT_ERROR_CODE.length + 1);
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 8261:
/***/ ((module, exports, __webpack_require__) => {

"use client";
"use strict";

Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports["default"] = RenderFromTemplateContext;

var _interop_require_wildcard = (__webpack_require__(1644)/* ["default"] */ .Z);

var _react = _interop_require_wildcard(__webpack_require__(8038));

var _appRouterContext = __webpack_require__(3280);

function RenderFromTemplateContext() {
  const children = (0, _react).useContext(_appRouterContext.TemplateContext);
  return /*#__PURE__*/_react.default.createElement(_react.default.Fragment, null, children);
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 4799:
/***/ ((module, exports, __webpack_require__) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.applyRouterStatePatchToTree = applyRouterStatePatchToTree;

var _extends = (__webpack_require__(7688)/* ["default"] */ .Z);

var _matchSegments = __webpack_require__(140);
/**
 * Deep merge of the two router states. Parallel route keys are preserved if the patch doesn't have them.
 */


function applyPatch(initialTree, patchTree) {
  const [segment, parallelRoutes] = initialTree;

  if ((0, _matchSegments).matchSegment(segment, patchTree[0])) {
    const newParallelRoutes = {};

    for (const key in parallelRoutes) {
      const isInPatchTreeParallelRoutes = typeof patchTree[1][key] !== 'undefined';

      if (isInPatchTreeParallelRoutes) {
        newParallelRoutes[key] = applyPatch(parallelRoutes[key], patchTree[1][key]);
      } else {
        newParallelRoutes[key] = parallelRoutes[key];
      }
    }

    for (const key1 in patchTree[1]) {
      if (newParallelRoutes[key1]) {
        continue;
      }

      newParallelRoutes[key1] = patchTree[1][key1];
    }

    const tree = [segment, newParallelRoutes];

    if (initialTree[2]) {
      tree[2] = initialTree[2];
    }

    if (initialTree[3]) {
      tree[3] = initialTree[3];
    }

    if (initialTree[4]) {
      tree[4] = initialTree[4];
    }

    return tree;
  }

  return patchTree;
}

function applyRouterStatePatchToTree(flightSegmentPath, flightRouterState, treePatch) {
  const [segment, parallelRoutes,,, isRootLayout] = flightRouterState; // Root refresh

  if (flightSegmentPath.length === 1) {
    const tree = applyPatch(flightRouterState, treePatch);
    return tree;
  }

  const [currentSegment, parallelRouteKey] = flightSegmentPath; // Tree path returned from the server should always match up with the current tree in the browser

  if (!(0, _matchSegments).matchSegment(currentSegment, segment)) {
    return null;
  }

  const lastSegment = flightSegmentPath.length === 2;
  let parallelRoutePatch;

  if (lastSegment) {
    parallelRoutePatch = treePatch;
  } else {
    parallelRoutePatch = applyRouterStatePatchToTree(flightSegmentPath.slice(2), parallelRoutes[parallelRouteKey], treePatch);

    if (parallelRoutePatch === null) {
      return null;
    }
  }

  const tree = [flightSegmentPath[0], _extends({}, parallelRoutes, {
    [parallelRouteKey]: parallelRoutePatch
  })]; // Current segment is the root layout

  if (isRootLayout) {
    tree[4] = true;
  }

  return tree;
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 9169:
/***/ ((module, exports) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.createHrefFromUrl = createHrefFromUrl;

function createHrefFromUrl(url) {
  return url.pathname + url.search + url.hash;
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 7253:
/***/ ((module, exports, __webpack_require__) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.createInitialRouterState = createInitialRouterState;

var _appRouterContext = __webpack_require__(3280);

var _createHrefFromUrl = __webpack_require__(9169);

var _fillLazyItemsTillLeafWithHead = __webpack_require__(7498);

function createInitialRouterState({
  initialTree,
  children,
  initialCanonicalUrl,
  initialParallelRoutes,
  isServer,
  location,
  initialHead
}) {
  const cache = {
    status: _appRouterContext.CacheStates.READY,
    data: null,
    subTreeData: children,
    // The cache gets seeded during the first render. `initialParallelRoutes` ensures the cache from the first render is there during the second render.
    parallelRoutes: isServer ? new Map() : initialParallelRoutes
  }; // When the cache hasn't been seeded yet we fill the cache with the head.

  if (initialParallelRoutes === null || initialParallelRoutes.size === 0) {
    (0, _fillLazyItemsTillLeafWithHead).fillLazyItemsTillLeafWithHead(cache, undefined, initialTree, initialHead);
  }

  return {
    tree: initialTree,
    cache,
    prefetchCache: new Map(),
    pushRef: {
      pendingPush: false,
      mpaNavigation: false
    },
    focusAndScrollRef: {
      apply: false
    },
    canonicalUrl: // location.href is read as the initial value for canonicalUrl in the browser
    // This is safe to do as canonicalUrl can't be rendered, it's only used to control the history updates in the useEffect further down in this file.
    location ? (0, _createHrefFromUrl).createHrefFromUrl(location) : initialCanonicalUrl
  };
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 2480:
/***/ ((module, exports, __webpack_require__) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.createOptimisticTree = createOptimisticTree;

var _extends = (__webpack_require__(7688)/* ["default"] */ .Z);

var _matchSegments = __webpack_require__(140);

function createOptimisticTree(segments, flightRouterState, parentRefetch) {
  const [existingSegment, existingParallelRoutes, url, refresh, isRootLayout] = flightRouterState || [null, {}];
  const segment = segments[0];
  const isLastSegment = segments.length === 1;
  const segmentMatches = existingSegment !== null && (0, _matchSegments).matchSegment(existingSegment, segment);
  const shouldRefetchThisLevel = !flightRouterState || !segmentMatches;
  let parallelRoutes = {};

  if (existingSegment !== null && segmentMatches) {
    parallelRoutes = existingParallelRoutes;
  }

  let childTree;

  if (!isLastSegment) {
    const childItem = createOptimisticTree(segments.slice(1), parallelRoutes ? parallelRoutes.children : null, parentRefetch || shouldRefetchThisLevel);
    childTree = childItem;
  }

  const result = [segment, _extends({}, parallelRoutes, childTree ? {
    children: childTree
  } : {})];

  if (url) {
    result[2] = url;
  }

  if (!parentRefetch && shouldRefetchThisLevel) {
    result[3] = 'refetch';
  } else if (segmentMatches && refresh) {
    result[3] = refresh;
  }

  if (segmentMatches && isRootLayout) {
    result[4] = isRootLayout;
  }

  return result;
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 2807:
/***/ ((module, exports) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.createRecordFromThenable = createRecordFromThenable;

function createRecordFromThenable(thenable) {
  thenable.status = 'pending';
  thenable.then(value => {
    if (thenable.status === 'pending') {
      thenable.status = 'fulfilled';
      thenable.value = value;
    }
  }, err => {
    if (thenable.status === 'pending') {
      thenable.status = 'rejected';
      thenable.value = err;
    }
  });
  return thenable;
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 2426:
/***/ ((module, exports, __webpack_require__) => {

"use client";
"use strict";

Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.fetchServerResponse = fetchServerResponse;

var _async_to_generator = (__webpack_require__(4432)/* ["default"] */ .Z);

var _client = __webpack_require__(7897);

var _appRouterHeaders = __webpack_require__(5444);

var _appRouter = __webpack_require__(5197);

function fetchServerResponse(url, flightRouterState, prefetch) {
  return _fetchServerResponse.apply(this, arguments);
}

function _fetchServerResponse() {
  _fetchServerResponse = _async_to_generator(function* (url, flightRouterState, prefetch) {
    const headers = {
      // Enable flight response
      [_appRouterHeaders.RSC]: '1',
      // Provide the current router state
      [_appRouterHeaders.NEXT_ROUTER_STATE_TREE]: JSON.stringify(flightRouterState)
    };

    if (prefetch) {
      // Enable prefetch response
      headers[_appRouterHeaders.NEXT_ROUTER_PREFETCH] = '1';
    }

    try {
      const res = yield fetch(url.toString(), {
        // Backwards compat for older browsers. `same-origin` is the default in modern browsers.
        credentials: 'same-origin',
        headers
      });
      const canonicalUrl = res.redirected ? (0, _appRouter).urlToUrlWithoutFlightMarker(res.url) : undefined;

      const isFlightResponse = res.headers.get('content-type') === _appRouterHeaders.RSC_CONTENT_TYPE_HEADER; // If fetch returns something different than flight response handle it like a mpa navigation


      if (!isFlightResponse) {
        return [res.url, undefined];
      } // Handle the `fetch` readable stream that can be unwrapped by `React.use`.


      const flightData = yield (0, _client).createFromFetch(Promise.resolve(res));
      return [flightData, canonicalUrl];
    } catch (err) {
      console.error('Failed to fetch RSC payload. Falling back to browser navigation.', err); // If fetch fails handle it like a mpa navigation
      // TODO-APP: Add a test for the case where a CORS request fails, e.g. external url redirect coming from the response.
      // See https://github.com/vercel/next.js/issues/43605#issuecomment-1451617521 for a reproduction.

      return [url.toString(), undefined];
    }
  });
  return _fetchServerResponse.apply(this, arguments);
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 7754:
/***/ ((module, exports, __webpack_require__) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.fillCacheWithDataProperty = fillCacheWithDataProperty;

var _appRouterContext = __webpack_require__(3280);

function fillCacheWithDataProperty(newCache, existingCache, segments, fetchResponse) {
  const isLastEntry = segments.length === 1;
  const parallelRouteKey = 'children';
  const [segment] = segments;
  const existingChildSegmentMap = existingCache.parallelRoutes.get(parallelRouteKey);

  if (!existingChildSegmentMap) {
    // Bailout because the existing cache does not have the path to the leaf node
    // Will trigger lazy fetch in layout-router because of missing segment
    return {
      bailOptimistic: true
    };
  }

  let childSegmentMap = newCache.parallelRoutes.get(parallelRouteKey);

  if (!childSegmentMap || childSegmentMap === existingChildSegmentMap) {
    childSegmentMap = new Map(existingChildSegmentMap);
    newCache.parallelRoutes.set(parallelRouteKey, childSegmentMap);
  }

  const existingChildCacheNode = existingChildSegmentMap.get(segment);
  let childCacheNode = childSegmentMap.get(segment); // In case of last segment start off the fetch at this level and don't copy further down.

  if (isLastEntry) {
    if (!childCacheNode || !childCacheNode.data || childCacheNode === existingChildCacheNode) {
      childSegmentMap.set(segment, {
        status: _appRouterContext.CacheStates.DATA_FETCH,
        data: fetchResponse(),
        subTreeData: null,
        parallelRoutes: new Map()
      });
    }

    return;
  }

  if (!childCacheNode || !existingChildCacheNode) {
    // Start fetch in the place where the existing cache doesn't have the data yet.
    if (!childCacheNode) {
      childSegmentMap.set(segment, {
        status: _appRouterContext.CacheStates.DATA_FETCH,
        data: fetchResponse(),
        subTreeData: null,
        parallelRoutes: new Map()
      });
    }

    return;
  }

  if (childCacheNode === existingChildCacheNode) {
    childCacheNode = {
      status: childCacheNode.status,
      data: childCacheNode.data,
      subTreeData: childCacheNode.subTreeData,
      parallelRoutes: new Map(childCacheNode.parallelRoutes)
    };
    childSegmentMap.set(segment, childCacheNode);
  }

  return fillCacheWithDataProperty(childCacheNode, existingChildCacheNode, segments.slice(1), fetchResponse);
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 2650:
/***/ ((module, exports, __webpack_require__) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.fillCacheWithNewSubTreeData = fillCacheWithNewSubTreeData;

var _appRouterContext = __webpack_require__(3280);

var _invalidateCacheByRouterState = __webpack_require__(4619);

var _fillLazyItemsTillLeafWithHead = __webpack_require__(7498);

function fillCacheWithNewSubTreeData(newCache, existingCache, flightDataPath) {
  const isLastEntry = flightDataPath.length <= 5;
  const [parallelRouteKey, segment] = flightDataPath;
  const segmentForCache = Array.isArray(segment) ? segment[1] : segment;
  const existingChildSegmentMap = existingCache.parallelRoutes.get(parallelRouteKey);

  if (!existingChildSegmentMap) {
    // Bailout because the existing cache does not have the path to the leaf node
    // Will trigger lazy fetch in layout-router because of missing segment
    return;
  }

  let childSegmentMap = newCache.parallelRoutes.get(parallelRouteKey);

  if (!childSegmentMap || childSegmentMap === existingChildSegmentMap) {
    childSegmentMap = new Map(existingChildSegmentMap);
    newCache.parallelRoutes.set(parallelRouteKey, childSegmentMap);
  }

  const existingChildCacheNode = existingChildSegmentMap.get(segmentForCache);
  let childCacheNode = childSegmentMap.get(segmentForCache);

  if (isLastEntry) {
    if (!childCacheNode || !childCacheNode.data || childCacheNode === existingChildCacheNode) {
      childCacheNode = {
        status: _appRouterContext.CacheStates.READY,
        data: null,
        subTreeData: flightDataPath[3],
        // Ensure segments other than the one we got data for are preserved.
        parallelRoutes: existingChildCacheNode ? new Map(existingChildCacheNode.parallelRoutes) : new Map()
      };

      if (existingChildCacheNode) {
        (0, _invalidateCacheByRouterState).invalidateCacheByRouterState(childCacheNode, existingChildCacheNode, flightDataPath[2]);
      }

      (0, _fillLazyItemsTillLeafWithHead).fillLazyItemsTillLeafWithHead(childCacheNode, existingChildCacheNode, flightDataPath[2], flightDataPath[4]);
      childSegmentMap.set(segmentForCache, childCacheNode);
    }

    return;
  }

  if (!childCacheNode || !existingChildCacheNode) {
    // Bailout because the existing cache does not have the path to the leaf node
    // Will trigger lazy fetch in layout-router because of missing segment
    return;
  }

  if (childCacheNode === existingChildCacheNode) {
    childCacheNode = {
      status: childCacheNode.status,
      data: childCacheNode.data,
      subTreeData: childCacheNode.subTreeData,
      parallelRoutes: new Map(childCacheNode.parallelRoutes)
    };
    childSegmentMap.set(segmentForCache, childCacheNode);
  }

  fillCacheWithNewSubTreeData(childCacheNode, existingChildCacheNode, flightDataPath.slice(2));
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 7498:
/***/ ((module, exports, __webpack_require__) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.fillLazyItemsTillLeafWithHead = fillLazyItemsTillLeafWithHead;

var _appRouterContext = __webpack_require__(3280);

function fillLazyItemsTillLeafWithHead(newCache, existingCache, routerState, head) {
  const isLastSegment = Object.keys(routerState[1]).length === 0;

  if (isLastSegment) {
    newCache.head = head;
    return;
  } // Remove segment that we got data for so that it is filled in during rendering of subTreeData.


  for (const key in routerState[1]) {
    const parallelRouteState = routerState[1][key];
    const segmentForParallelRoute = parallelRouteState[0];
    const cacheKey = Array.isArray(segmentForParallelRoute) ? segmentForParallelRoute[1] : segmentForParallelRoute;

    if (existingCache) {
      const existingParallelRoutesCacheNode = existingCache.parallelRoutes.get(key);

      if (existingParallelRoutesCacheNode) {
        let parallelRouteCacheNode = new Map(existingParallelRoutesCacheNode);
        const existingCacheNode = parallelRouteCacheNode.get(cacheKey);
        parallelRouteCacheNode.delete(cacheKey);
        const newCacheNode = {
          status: _appRouterContext.CacheStates.LAZY_INITIALIZED,
          data: null,
          subTreeData: null,
          parallelRoutes: new Map(existingCacheNode == null ? void 0 : existingCacheNode.parallelRoutes)
        };
        parallelRouteCacheNode.set(cacheKey, newCacheNode);
        fillLazyItemsTillLeafWithHead(newCacheNode, undefined, parallelRouteState, head);
        newCache.parallelRoutes.set(key, parallelRouteCacheNode);
        continue;
      }
    }

    const newCacheNode = {
      status: _appRouterContext.CacheStates.LAZY_INITIALIZED,
      data: null,
      subTreeData: null,
      parallelRoutes: new Map()
    };
    const existingParallelRoutes = newCache.parallelRoutes.get(key);

    if (existingParallelRoutes) {
      existingParallelRoutes.set(cacheKey, newCacheNode);
    } else {
      newCache.parallelRoutes.set(key, new Map([[cacheKey, newCacheNode]]));
    }

    fillLazyItemsTillLeafWithHead(newCacheNode, undefined, parallelRouteState, head);
  }
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 6782:
/***/ ((module, exports) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.invalidateCacheBelowFlightSegmentPath = invalidateCacheBelowFlightSegmentPath;

function invalidateCacheBelowFlightSegmentPath(newCache, existingCache, flightSegmentPath) {
  const isLastEntry = flightSegmentPath.length <= 2;
  const [parallelRouteKey, segment] = flightSegmentPath;
  const segmentForCache = Array.isArray(segment) ? segment[1] : segment;
  const existingChildSegmentMap = existingCache.parallelRoutes.get(parallelRouteKey);

  if (!existingChildSegmentMap) {
    // Bailout because the existing cache does not have the path to the leaf node
    // Will trigger lazy fetch in layout-router because of missing segment
    return;
  }

  let childSegmentMap = newCache.parallelRoutes.get(parallelRouteKey);

  if (!childSegmentMap || childSegmentMap === existingChildSegmentMap) {
    childSegmentMap = new Map(existingChildSegmentMap);
    newCache.parallelRoutes.set(parallelRouteKey, childSegmentMap);
  } // In case of last entry don't copy further down.


  if (isLastEntry) {
    childSegmentMap.delete(segmentForCache);
    return;
  }

  const existingChildCacheNode = existingChildSegmentMap.get(segmentForCache);
  let childCacheNode = childSegmentMap.get(segmentForCache);

  if (!childCacheNode || !existingChildCacheNode) {
    // Bailout because the existing cache does not have the path to the leaf node
    // Will trigger lazy fetch in layout-router because of missing segment
    return;
  }

  if (childCacheNode === existingChildCacheNode) {
    childCacheNode = {
      status: childCacheNode.status,
      data: childCacheNode.data,
      subTreeData: childCacheNode.subTreeData,
      parallelRoutes: new Map(childCacheNode.parallelRoutes)
    };
    childSegmentMap.set(segmentForCache, childCacheNode);
  }

  invalidateCacheBelowFlightSegmentPath(childCacheNode, existingChildCacheNode, flightSegmentPath.slice(2));
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 4619:
/***/ ((module, exports) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.invalidateCacheByRouterState = invalidateCacheByRouterState;

function invalidateCacheByRouterState(newCache, existingCache, routerState) {
  // Remove segment that we got data for so that it is filled in during rendering of subTreeData.
  for (const key in routerState[1]) {
    const segmentForParallelRoute = routerState[1][key][0];
    const cacheKey = Array.isArray(segmentForParallelRoute) ? segmentForParallelRoute[1] : segmentForParallelRoute;
    const existingParallelRoutesCacheNode = existingCache.parallelRoutes.get(key);

    if (existingParallelRoutesCacheNode) {
      let parallelRouteCacheNode = new Map(existingParallelRoutesCacheNode);
      parallelRouteCacheNode.delete(cacheKey);
      newCache.parallelRoutes.set(key, parallelRouteCacheNode);
    }
  }
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 5543:
/***/ ((module, exports) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.isNavigatingToNewRootLayout = isNavigatingToNewRootLayout;

function isNavigatingToNewRootLayout(currentTree, nextTree) {
  // Compare segments
  const currentTreeSegment = currentTree[0];
  const nextTreeSegment = nextTree[0]; // If any segment is different before we find the root layout, the root layout has changed.
  // E.g. /same/(group1)/layout.js -> /same/(group2)/layout.js
  // First segment is 'same' for both, keep looking. (group1) changed to (group2) before the root layout was found, it must have changed.

  if (Array.isArray(currentTreeSegment) && Array.isArray(nextTreeSegment)) {
    // Compare dynamic param name and type but ignore the value, different values would not affect the current root layout
    // /[name] - /slug1 and /slug2, both values (slug1 & slug2) still has the same layout /[name]/layout.js
    if (currentTreeSegment[0] !== nextTreeSegment[0] || currentTreeSegment[2] !== nextTreeSegment[2]) {
      return true;
    }
  } else if (currentTreeSegment !== nextTreeSegment) {
    return true;
  } // Current tree root layout found


  if (currentTree[4]) {
    // If the next tree doesn't have the root layout flag, it must have changed.
    return !nextTree[4];
  } // Current tree  didn't have its root layout here, must have changed.


  if (nextTree[4]) {
    return true;
  } // We can't assume it's `parallelRoutes.children` here in case the root layout is `app/@something/layout.js`
  // But it's not possible to be more than one parallelRoutes before the root layout is found
  // TODO-APP: change to traverse all parallel routes


  const currentTreeChild = Object.values(currentTree[1])[0];
  const nextTreeChild = Object.values(nextTree[1])[0];
  if (!currentTreeChild || !nextTreeChild) return true;
  return isNavigatingToNewRootLayout(currentTreeChild, nextTreeChild);
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 5692:
/***/ ((module, exports) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.readRecordValue = readRecordValue;

function readRecordValue(thenable) {
  // @ts-expect-error TODO: fix type
  if (thenable.status === 'fulfilled') {
    // @ts-expect-error TODO: fix type
    return thenable.value;
  } else {
    throw thenable;
  }
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 9726:
/***/ ((module, exports) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.findHeadInCache = findHeadInCache;

function findHeadInCache(childSegmentMap, parallelRoutes) {
  if (!childSegmentMap) {
    return undefined;
  }

  for (const key in parallelRoutes) {
    const [segment, childParallelRoutes] = parallelRoutes[key];
    const isLastItem = Object.keys(childParallelRoutes).length === 0;
    const cacheKey = Array.isArray(segment) ? segment[1] : segment;
    const cacheNode = childSegmentMap.get(cacheKey);

    if (!cacheNode) {
      continue;
    }

    if (isLastItem && cacheNode.head) return cacheNode.head;
    const segmentMap = cacheNode.parallelRoutes.get(key);

    if (segmentMap) {
      const item = findHeadInCache(segmentMap, childParallelRoutes);

      if (item) {
        return item;
      }
    }
  }

  return undefined;
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 889:
/***/ ((module, exports, __webpack_require__) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.handleMutable = handleMutable;
exports.applyFlightData = applyFlightData;
exports.handleExternalUrl = handleExternalUrl;
exports.navigateReducer = navigateReducer;

var _appRouterContext = __webpack_require__(3280);

var _fetchServerResponse = __webpack_require__(2426);

var _createRecordFromThenable = __webpack_require__(2807);

var _readRecordValue = __webpack_require__(5692);

var _createHrefFromUrl = __webpack_require__(9169);

var _fillLazyItemsTillLeafWithHead = __webpack_require__(7498);

var _fillCacheWithNewSubtreeData = __webpack_require__(2650);

var _invalidateCacheBelowFlightSegmentpath = __webpack_require__(6782);

var _fillCacheWithDataProperty = __webpack_require__(7754);

var _createOptimisticTree = __webpack_require__(2480);

var _applyRouterStatePatchToTree = __webpack_require__(4799);

var _shouldHardNavigate = __webpack_require__(3635);

var _isNavigatingToNewRootLayout = __webpack_require__(5543);

function handleMutable(state, mutable) {
  return {
    // Set href.
    canonicalUrl: typeof mutable.canonicalUrl !== 'undefined' ? mutable.canonicalUrl === state.canonicalUrl ? state.canonicalUrl : mutable.canonicalUrl : state.canonicalUrl,
    pushRef: {
      pendingPush: typeof mutable.pendingPush !== 'undefined' ? mutable.pendingPush : state.pushRef.pendingPush,
      mpaNavigation: typeof mutable.mpaNavigation !== 'undefined' ? mutable.mpaNavigation : state.pushRef.mpaNavigation
    },
    // All navigation requires scroll and focus management to trigger.
    focusAndScrollRef: {
      apply: typeof mutable.applyFocusAndScroll !== 'undefined' ? mutable.applyFocusAndScroll : state.focusAndScrollRef.apply
    },
    // Apply cache.
    cache: mutable.cache ? mutable.cache : state.cache,
    prefetchCache: state.prefetchCache,
    // Apply patched router state.
    tree: typeof mutable.patchedTree !== 'undefined' ? mutable.patchedTree : state.tree
  };
}

function applyFlightData(state, cache, flightDataPath) {
  // The one before last item is the router state tree patch
  const [treePatch, subTreeData, head] = flightDataPath.slice(-3); // Handles case where prefetch only returns the router tree patch without rendered components.

  if (subTreeData === null) {
    return false;
  }

  if (flightDataPath.length === 3) {
    cache.status = _appRouterContext.CacheStates.READY;
    cache.subTreeData = subTreeData;
    (0, _fillLazyItemsTillLeafWithHead).fillLazyItemsTillLeafWithHead(cache, state.cache, treePatch, head);
  } else {
    // Copy subTreeData for the root node of the cache.
    cache.status = _appRouterContext.CacheStates.READY;
    cache.subTreeData = state.cache.subTreeData; // Create a copy of the existing cache with the subTreeData applied.

    (0, _fillCacheWithNewSubtreeData).fillCacheWithNewSubTreeData(cache, state.cache, flightDataPath);
  }

  return true;
}

function handleExternalUrl(state, mutable, url, pendingPush) {
  mutable.previousTree = state.tree;
  mutable.mpaNavigation = true;
  mutable.canonicalUrl = url;
  mutable.pendingPush = pendingPush;
  mutable.applyFocusAndScroll = false;
  return handleMutable(state, mutable);
}

function navigateReducer(state, action) {
  const {
    url,
    isExternalUrl,
    locationSearch,
    navigateType,
    cache,
    mutable,
    forceOptimisticNavigation
  } = action;
  const {
    pathname,
    search
  } = url;
  const href = (0, _createHrefFromUrl).createHrefFromUrl(url);
  const pendingPush = navigateType === 'push';
  const isForCurrentTree = JSON.stringify(mutable.previousTree) === JSON.stringify(state.tree);

  if (isForCurrentTree) {
    return handleMutable(state, mutable);
  }

  if (isExternalUrl) {
    return handleExternalUrl(state, mutable, url.toString(), pendingPush);
  }

  const prefetchValues = state.prefetchCache.get(href);

  if (prefetchValues) {
    // The one before last item is the router state tree patch
    const {
      flightData,
      tree: newTree,
      canonicalUrlOverride
    } = prefetchValues; // Handle case when navigating to page in `pages` from `app`

    if (typeof flightData === 'string') {
      return handleExternalUrl(state, mutable, flightData, pendingPush);
    }

    if (newTree !== null) {
      if ((0, _isNavigatingToNewRootLayout).isNavigatingToNewRootLayout(state.tree, newTree)) {
        return handleExternalUrl(state, mutable, href, pendingPush);
      } // TODO-APP: Currently the Flight data can only have one item but in the future it can have multiple paths.


      const flightDataPath = flightData[0];
      const flightSegmentPath = flightDataPath.slice(0, -3);
      const applied = applyFlightData(state, cache, flightDataPath);
      const hardNavigate = // TODO-APP: Revisit searchParams support
      search !== locationSearch || (0, _shouldHardNavigate).shouldHardNavigate( // TODO-APP: remove ''
      ['', ...flightSegmentPath], state.tree);

      if (hardNavigate) {
        cache.status = _appRouterContext.CacheStates.READY; // Copy subTreeData for the root node of the cache.

        cache.subTreeData = state.cache.subTreeData;
        (0, _invalidateCacheBelowFlightSegmentpath).invalidateCacheBelowFlightSegmentPath(cache, state.cache, flightSegmentPath); // Ensure the existing cache value is used when the cache was not invalidated.

        mutable.cache = cache;
      } else if (applied) {
        mutable.cache = cache;
      }

      mutable.previousTree = state.tree;
      mutable.patchedTree = newTree;
      mutable.applyFocusAndScroll = true;
      mutable.canonicalUrl = canonicalUrlOverride ? (0, _createHrefFromUrl).createHrefFromUrl(canonicalUrlOverride) : href;
      mutable.pendingPush = pendingPush;
      return handleMutable(state, mutable);
    }
  } // When doing a hard push there can be two cases: with optimistic tree and without
  // The with optimistic tree case only happens when the layouts have a loading state (loading.js)
  // The without optimistic tree case happens when there is no loading state, in that case we suspend in this reducer
  // forceOptimisticNavigation is used for links that have `prefetch={false}`.


  if (forceOptimisticNavigation) {
    const segments = pathname.split('/'); // TODO-APP: figure out something better for index pages

    segments.push(''); // Optimistic tree case.
    // If the optimistic tree is deeper than the current state leave that deeper part out of the fetch

    const optimisticTree = (0, _createOptimisticTree).createOptimisticTree(segments, state.tree, false); // Copy subTreeData for the root node of the cache.

    cache.status = _appRouterContext.CacheStates.READY;
    cache.subTreeData = state.cache.subTreeData; // Copy existing cache nodes as far as possible and fill in `data` property with the started data fetch.
    // The `data` property is used to suspend in layout-router during render if it hasn't resolved yet by the time it renders.

    const res = (0, _fillCacheWithDataProperty).fillCacheWithDataProperty(cache, state.cache, // TODO-APP: segments.slice(1) strips '', we can get rid of '' altogether.
    segments.slice(1), () => (0, _fetchServerResponse).fetchServerResponse(url, optimisticTree)); // If optimistic fetch couldn't happen it falls back to the non-optimistic case.

    if (!(res == null ? void 0 : res.bailOptimistic)) {
      mutable.previousTree = state.tree;
      mutable.patchedTree = optimisticTree;
      mutable.pendingPush = pendingPush;
      mutable.applyFocusAndScroll = true;
      mutable.cache = cache;
      mutable.canonicalUrl = href;
      return handleMutable(state, mutable);
    }
  } // Below is the not-optimistic case. Data is fetched at the root and suspended there without a suspense boundary.
  // If no in-flight fetch at the top, start it.


  if (!cache.data) {
    cache.data = (0, _createRecordFromThenable).createRecordFromThenable((0, _fetchServerResponse).fetchServerResponse(url, state.tree));
  } // Unwrap cache data with `use` to suspend here (in the reducer) until the fetch resolves.


  const [flightData, canonicalUrlOverride] = (0, _readRecordValue).readRecordValue(cache.data); // Handle case when navigating to page in `pages` from `app`

  if (typeof flightData === 'string') {
    return handleExternalUrl(state, mutable, flightData, pendingPush);
  } // Remove cache.data as it has been resolved at this point.


  cache.data = null; // TODO-APP: Currently the Flight data can only have one item but in the future it can have multiple paths.

  const flightDataPath = flightData[0]; // The one before last item is the router state tree patch

  const [treePatch] = flightDataPath.slice(-3, -2); // Path without the last segment, router state, and the subTreeData

  const flightSegmentPath = flightDataPath.slice(0, -4); // Create new tree based on the flightSegmentPath and router state patch

  const newTree = (0, _applyRouterStatePatchToTree).applyRouterStatePatchToTree( // TODO-APP: remove ''
  ['', ...flightSegmentPath], state.tree, treePatch);

  if (newTree === null) {
    throw new Error('SEGMENT MISMATCH');
  }

  if ((0, _isNavigatingToNewRootLayout).isNavigatingToNewRootLayout(state.tree, newTree)) {
    return handleExternalUrl(state, mutable, href, pendingPush);
  }

  mutable.canonicalUrl = canonicalUrlOverride ? (0, _createHrefFromUrl).createHrefFromUrl(canonicalUrlOverride) : href;
  mutable.previousTree = state.tree;
  mutable.patchedTree = newTree;
  mutable.applyFocusAndScroll = true;
  mutable.pendingPush = pendingPush;
  const applied = applyFlightData(state, cache, flightDataPath);

  if (applied) {
    mutable.cache = cache;
  }

  return handleMutable(state, mutable);
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 3382:
/***/ ((module, exports, __webpack_require__) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.prefetchReducer = prefetchReducer;

var _applyRouterStatePatchToTree = __webpack_require__(4799);

var _createHrefFromUrl = __webpack_require__(9169);

function prefetchReducer(state, action) {
  const {
    url,
    serverResponse
  } = action;
  const [flightData, canonicalUrlOverride] = serverResponse;

  if (typeof flightData === 'string') {
    return state;
  }

  const href = (0, _createHrefFromUrl).createHrefFromUrl(url); // TODO-APP: Currently the Flight data can only have one item but in the future it can have multiple paths.

  const flightDataPath = flightData[0]; // The one before last item is the router state tree patch

  const [treePatch] = flightDataPath.slice(-3);
  const flightSegmentPath = flightDataPath.slice(0, -3);
  const newTree = (0, _applyRouterStatePatchToTree).applyRouterStatePatchToTree( // TODO-APP: remove ''
  ['', ...flightSegmentPath], state.tree, treePatch); // Patch did not apply correctly

  if (newTree === null) {
    return state;
  } // Create new tree based on the flightSegmentPath and router state patch


  state.prefetchCache.set(href, {
    flightData,
    // Create new tree based on the flightSegmentPath and router state patch
    tree: newTree,
    canonicalUrlOverride
  });
  return state;
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 5077:
/***/ ((module, exports, __webpack_require__) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.refreshReducer = refreshReducer;

var _fetchServerResponse = __webpack_require__(2426);

var _createRecordFromThenable = __webpack_require__(2807);

var _readRecordValue = __webpack_require__(5692);

var _createHrefFromUrl = __webpack_require__(9169);

var _applyRouterStatePatchToTree = __webpack_require__(4799);

var _isNavigatingToNewRootLayout = __webpack_require__(5543);

var _navigateReducer = __webpack_require__(889);

function refreshReducer(state, action) {
  const {
    cache,
    mutable,
    origin
  } = action;
  const href = state.canonicalUrl;
  const isForCurrentTree = JSON.stringify(mutable.previousTree) === JSON.stringify(state.tree);

  if (isForCurrentTree) {
    return (0, _navigateReducer).handleMutable(state, mutable);
  }

  if (!cache.data) {
    // TODO-APP: verify that `href` is not an external url.
    // Fetch data from the root of the tree.
    cache.data = (0, _createRecordFromThenable).createRecordFromThenable((0, _fetchServerResponse).fetchServerResponse(new URL(href, origin), [state.tree[0], state.tree[1], state.tree[2], 'refetch']));
  }

  const [flightData, canonicalUrlOverride] = (0, _readRecordValue).readRecordValue(cache.data); // Handle case when navigating to page in `pages` from `app`

  if (typeof flightData === 'string') {
    return (0, _navigateReducer).handleExternalUrl(state, mutable, flightData, state.pushRef.pendingPush);
  } // Remove cache.data as it has been resolved at this point.


  cache.data = null; // TODO-APP: Currently the Flight data can only have one item but in the future it can have multiple paths.

  const flightDataPath = flightData[0]; // FlightDataPath with more than two items means unexpected Flight data was returned

  if (flightDataPath.length !== 3) {
    // TODO-APP: handle this case better
    console.log('REFRESH FAILED');
    return state;
  } // Given the path can only have two items the items are only the router state and subTreeData for the root.


  const [treePatch] = flightDataPath;
  const newTree = (0, _applyRouterStatePatchToTree).applyRouterStatePatchToTree( // TODO-APP: remove ''
  [''], state.tree, treePatch);

  if (newTree === null) {
    throw new Error('SEGMENT MISMATCH');
  }

  if ((0, _isNavigatingToNewRootLayout).isNavigatingToNewRootLayout(state.tree, newTree)) {
    return (0, _navigateReducer).handleExternalUrl(state, mutable, href, state.pushRef.pendingPush);
  }

  const canonicalUrlOverrideHref = canonicalUrlOverride ? (0, _createHrefFromUrl).createHrefFromUrl(canonicalUrlOverride) : undefined;

  if (canonicalUrlOverride) {
    mutable.canonicalUrl = canonicalUrlOverrideHref;
  }

  const applied = (0, _navigateReducer).applyFlightData(state, cache, flightDataPath);

  if (applied) {
    mutable.cache = cache;
  }

  mutable.previousTree = state.tree;
  mutable.patchedTree = newTree;
  mutable.canonicalUrl = href;
  return (0, _navigateReducer).handleMutable(state, mutable);
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 8326:
/***/ ((module, exports, __webpack_require__) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.restoreReducer = restoreReducer;

var _createHrefFromUrl = __webpack_require__(9169);

function restoreReducer(state, action) {
  const {
    url,
    tree
  } = action;
  const href = (0, _createHrefFromUrl).createHrefFromUrl(url);
  return {
    // Set canonical url
    canonicalUrl: href,
    pushRef: state.pushRef,
    focusAndScrollRef: state.focusAndScrollRef,
    cache: state.cache,
    prefetchCache: state.prefetchCache,
    // Restore provided tree
    tree: tree
  };
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 5788:
/***/ ((module, exports, __webpack_require__) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.serverPatchReducer = serverPatchReducer;

var _createHrefFromUrl = __webpack_require__(9169);

var _applyRouterStatePatchToTree = __webpack_require__(4799);

var _isNavigatingToNewRootLayout = __webpack_require__(5543);

var _navigateReducer = __webpack_require__(889);

function serverPatchReducer(state, action) {
  const {
    flightData,
    previousTree,
    overrideCanonicalUrl,
    cache,
    mutable
  } = action;
  const isForCurrentTree = JSON.stringify(previousTree) === JSON.stringify(state.tree); // When a fetch is slow to resolve it could be that you navigated away while the request was happening or before the reducer runs.
  // In that case opt-out of applying the patch given that the data could be stale.

  if (!isForCurrentTree) {
    // TODO-APP: Handle tree mismatch
    console.log('TREE MISMATCH'); // Keep everything as-is.

    return state;
  }

  if (mutable.previousTree) {
    return (0, _navigateReducer).handleMutable(state, mutable);
  } // Handle case when navigating to page in `pages` from `app`


  if (typeof flightData === 'string') {
    return (0, _navigateReducer).handleExternalUrl(state, mutable, flightData, state.pushRef.pendingPush);
  } // TODO-APP: Currently the Flight data can only have one item but in the future it can have multiple paths.


  const flightDataPath = flightData[0]; // Slices off the last segment (which is at -4) as it doesn't exist in the tree yet

  const flightSegmentPath = flightDataPath.slice(0, -4);
  const [treePatch] = flightDataPath.slice(-3, -2);
  const newTree = (0, _applyRouterStatePatchToTree).applyRouterStatePatchToTree( // TODO-APP: remove ''
  ['', ...flightSegmentPath], state.tree, treePatch);

  if (newTree === null) {
    throw new Error('SEGMENT MISMATCH');
  }

  if ((0, _isNavigatingToNewRootLayout).isNavigatingToNewRootLayout(state.tree, newTree)) {
    return (0, _navigateReducer).handleExternalUrl(state, mutable, state.canonicalUrl, state.pushRef.pendingPush);
  }

  const canonicalUrlOverrideHref = overrideCanonicalUrl ? (0, _createHrefFromUrl).createHrefFromUrl(overrideCanonicalUrl) : undefined;

  if (canonicalUrlOverrideHref) {
    mutable.canonicalUrl = canonicalUrlOverrideHref;
  }

  (0, _navigateReducer).applyFlightData(state, cache, flightDataPath);
  mutable.previousTree = state.tree;
  mutable.patchedTree = newTree;
  mutable.cache = cache;
  return (0, _navigateReducer).handleMutable(state, mutable);
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 4159:
/***/ ((module, exports) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.ACTION_PREFETCH = exports.ACTION_SERVER_PATCH = exports.ACTION_RESTORE = exports.ACTION_NAVIGATE = exports.ACTION_REFRESH = void 0;
const ACTION_REFRESH = 'refresh';
exports.ACTION_REFRESH = ACTION_REFRESH;
const ACTION_NAVIGATE = 'navigate';
exports.ACTION_NAVIGATE = ACTION_NAVIGATE;
const ACTION_RESTORE = 'restore';
exports.ACTION_RESTORE = ACTION_RESTORE;
const ACTION_SERVER_PATCH = 'server-patch';
exports.ACTION_SERVER_PATCH = ACTION_SERVER_PATCH;
const ACTION_PREFETCH = 'prefetch';
exports.ACTION_PREFETCH = ACTION_PREFETCH;

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 3840:
/***/ ((module, exports, __webpack_require__) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.reducer = void 0;

var _routerReducerTypes = __webpack_require__(4159);

var _navigateReducer = __webpack_require__(889);

var _serverPatchReducer = __webpack_require__(5788);

var _restoreReducer = __webpack_require__(8326);

var _refreshReducer = __webpack_require__(5077);

var _prefetchReducer = __webpack_require__(3382);
/**
 * Reducer that handles the app-router state updates.
 */


function clientReducer(state, action) {
  switch (action.type) {
    case _routerReducerTypes.ACTION_NAVIGATE:
      {
        return (0, _navigateReducer).navigateReducer(state, action);
      }

    case _routerReducerTypes.ACTION_SERVER_PATCH:
      {
        return (0, _serverPatchReducer).serverPatchReducer(state, action);
      }

    case _routerReducerTypes.ACTION_RESTORE:
      {
        return (0, _restoreReducer).restoreReducer(state, action);
      }

    case _routerReducerTypes.ACTION_REFRESH:
      {
        return (0, _refreshReducer).refreshReducer(state, action);
      }

    case _routerReducerTypes.ACTION_PREFETCH:
      {
        return (0, _prefetchReducer).prefetchReducer(state, action);
      }
    // This case should never be hit as dispatch is strongly typed.

    default:
      throw new Error('Unknown action');
  }
}

function serverReducer(state, _action) {
  return state;
}

const reducer =  true ? serverReducer : 0;
exports.reducer = reducer;

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 3635:
/***/ ((module, exports, __webpack_require__) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.shouldHardNavigate = shouldHardNavigate;

var _matchSegments = __webpack_require__(140);

function shouldHardNavigate(flightSegmentPath, flightRouterState) {
  const [segment, parallelRoutes] = flightRouterState; // TODO-APP: Check if `as` can be replaced.

  const [currentSegment, parallelRouteKey] = flightSegmentPath; // Check if current segment matches the existing segment.

  if (!(0, _matchSegments).matchSegment(currentSegment, segment)) {
    // If dynamic parameter in tree doesn't match up with segment path a hard navigation is triggered.
    if (Array.isArray(currentSegment)) {
      return true;
    } // If the existing segment did not match soft navigation is triggered.


    return false;
  }

  const lastSegment = flightSegmentPath.length <= 2;

  if (lastSegment) {
    return false;
  }

  return shouldHardNavigate(flightSegmentPath.slice(2), parallelRoutes[parallelRouteKey]);
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 6064:
/***/ ((module, exports, __webpack_require__) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.staticGenerationAsyncStorage = void 0;

var _asyncLocalStorage = __webpack_require__(4418);

const staticGenerationAsyncStorage = (0, _asyncLocalStorage).createAsyncLocalStorage();
exports.staticGenerationAsyncStorage = staticGenerationAsyncStorage;

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 4997:
/***/ ((module, exports, __webpack_require__) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.useReducerWithReduxDevtools = void 0;

var _react = __webpack_require__(8038);

function normalizeRouterState(val) {
  if (val instanceof Map) {
    const obj = {};

    for (const [key, value] of val.entries()) {
      if (typeof value === 'function') {
        obj[key] = 'fn()';
        continue;
      }

      if (typeof value === 'object' && value !== null) {
        if (value.$$typeof) {
          obj[key] = value.$$typeof.toString();
          continue;
        }

        if (value._bundlerConfig) {
          obj[key] = 'FlightData';
          continue;
        }
      }

      obj[key] = normalizeRouterState(value);
    }

    return obj;
  }

  if (typeof val === 'object' && val !== null) {
    const obj = {};

    for (const key in val) {
      const value = val[key];

      if (typeof value === 'function') {
        obj[key] = 'fn()';
        continue;
      }

      if (typeof value === 'object' && value !== null) {
        if (value.$$typeof) {
          obj[key] = value.$$typeof.toString();
          continue;
        }

        if (value.hasOwnProperty('_bundlerConfig')) {
          obj[key] = 'FlightData';
          continue;
        }
      }

      obj[key] = normalizeRouterState(value);
    }

    return obj;
  }

  if (Array.isArray(val)) {
    return val.map(normalizeRouterState);
  }

  return val;
}

function devToolReducer(fn, ref) {
  return (state, action) => {
    const res = fn(state, action);

    if (ref.current) {
      ref.current.send(action, normalizeRouterState(res));
    }

    return res;
  };
}

function useReducerWithReduxDevtoolsNoop(fn, initialState) {
  const [state, dispatch] = (0, _react).useReducer(fn, initialState);
  return [state, dispatch, () => {}];
}

function useReducerWithReduxDevtoolsImpl(fn, initialState) {
  const devtoolsConnectionRef = (0, _react).useRef();
  const enabledRef = (0, _react).useRef();
  (0, _react).useEffect(() => {
    if (devtoolsConnectionRef.current || enabledRef.current === false) {
      return;
    }

    if (enabledRef.current === undefined && typeof window.__REDUX_DEVTOOLS_EXTENSION__ === 'undefined') {
      enabledRef.current = false;
      return;
    }

    devtoolsConnectionRef.current = window.__REDUX_DEVTOOLS_EXTENSION__.connect({
      instanceId: 8000,
      name: 'next-router'
    });

    if (devtoolsConnectionRef.current) {
      devtoolsConnectionRef.current.init(normalizeRouterState(initialState));
    }

    return () => {
      devtoolsConnectionRef.current = undefined;
    };
  }, [initialState]);
  const [state, dispatch] = (0, _react).useReducer(devToolReducer(
  /* logReducer( */
  fn
  /*)*/
  , devtoolsConnectionRef), initialState);
  const sync = (0, _react).useCallback(() => {
    if (devtoolsConnectionRef.current) {
      devtoolsConnectionRef.current.send({
        type: 'RENDER_SYNC'
      }, normalizeRouterState(state));
    }
  }, [state]);
  return [state, dispatch, sync];
}

const useReducerWithReduxDevtools =  false ? 0 : useReducerWithReduxDevtoolsNoop;
exports.useReducerWithReduxDevtools = useReducerWithReduxDevtools;

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 224:
/***/ ((module, exports) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.getDomainLocale = getDomainLocale;
const basePath = (/* unused pure expression or super */ null && ( false || ''));

function getDomainLocale(path, locale, locales, domainLocales) {
  if (false) {} else {
    return false;
  }
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 3849:
/***/ ((module, exports, __webpack_require__) => {

"use client";
"use strict";

Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports["default"] = void 0;

var _interop_require_default = (__webpack_require__(6356)/* ["default"] */ .Z);

var _object_without_properties_loose = (__webpack_require__(2495)/* ["default"] */ .Z);

var _react = _interop_require_default(__webpack_require__(8038));

var _resolveHref = __webpack_require__(7782);

var _isLocalUrl = __webpack_require__(1109);

var _formatUrl = __webpack_require__(3938);

var _utils = __webpack_require__(9232);

var _addLocale = __webpack_require__(939);

var _routerContext = __webpack_require__(4964);

var _appRouterContext = __webpack_require__(3280);

var _useIntersection = __webpack_require__(3428);

var _getDomainLocale = __webpack_require__(224);

var _addBasePath = __webpack_require__(1645);

const prefetched = new Set();

function prefetch(router, href, as, options, isAppRouter) {
  if (true) {
    return;
  } // app-router supports external urls out of the box so it shouldn't short-circuit here as support for e.g. `replace` is added in the app-router.


  if (!isAppRouter && !(0, _isLocalUrl).isLocalURL(href)) {
    return;
  } // We should only dedupe requests when experimental.optimisticClientCache is
  // disabled.


  if (!options.bypassPrefetchedCheck) {
    const locale = // Let the link's locale prop override the default router locale.
    typeof options.locale !== 'undefined' ? options.locale : 'locale' in router ? router.locale : undefined;
    const prefetchedKey = href + '%' + as + '%' + locale; // If we've already fetched the key, then don't prefetch it again!

    if (prefetched.has(prefetchedKey)) {
      return;
    } // Mark this URL as prefetched.


    prefetched.add(prefetchedKey);
  } // Prefetch the JSON page if asked (only in the client)
  // We need to handle a prefetch error here since we may be
  // loading with priority which can reject but we don't
  // want to force navigation since this is only a prefetch


  Promise.resolve(router.prefetch(href, as, options)).catch(err => {
    if (false) {}
  });
}

function isModifiedEvent(event) {
  const eventTarget = event.currentTarget;
  const target = eventTarget.getAttribute('target');
  return target && target !== '_self' || event.metaKey || event.ctrlKey || event.shiftKey || event.altKey || event.nativeEvent && event.nativeEvent.which === 2;
}

function linkClicked(e, router, href, as, replace, shallow, scroll, locale, isAppRouter, prefetchEnabled) {
  const {
    nodeName
  } = e.currentTarget; // anchors inside an svg have a lowercase nodeName

  const isAnchorNodeName = nodeName.toUpperCase() === 'A';

  if (isAnchorNodeName && (isModifiedEvent(e) || // app-router supports external urls out of the box so it shouldn't short-circuit here as support for e.g. `replace` is added in the app-router.
  !isAppRouter && !(0, _isLocalUrl).isLocalURL(href))) {
    // ignore click for browser’s default behavior
    return;
  }

  e.preventDefault();

  const navigate = () => {
    // If the router is an NextRouter instance it will have `beforePopState`
    if ('beforePopState' in router) {
      router[replace ? 'replace' : 'push'](href, as, {
        shallow,
        locale,
        scroll
      });
    } else {
      router[replace ? 'replace' : 'push'](as || href, {
        forceOptimisticNavigation: !prefetchEnabled
      });
    }
  };

  if (isAppRouter) {
    // @ts-expect-error startTransition exists.
    _react.default.startTransition(navigate);
  } else {
    navigate();
  }
}

function formatStringOrUrl(urlObjOrString) {
  if (typeof urlObjOrString === 'string') {
    return urlObjOrString;
  }

  return (0, _formatUrl).formatUrl(urlObjOrString);
}
/**
 * React Component that enables client-side transitions between routes.
 */


const Link = /*#__PURE__*/_react.default.forwardRef(function LinkComponent(props, forwardedRef) {
  if (false) { var createPropError; }

  let children;

  const {
    href: hrefProp,
    as: asProp,
    children: childrenProp,
    prefetch: prefetchProp,
    passHref,
    replace,
    shallow,
    scroll,
    locale,
    onClick,
    onMouseEnter: onMouseEnterProp,
    onTouchStart: onTouchStartProp,
    // @ts-expect-error this is inlined as a literal boolean not a string
    legacyBehavior = true === false
  } = props,
        restProps = _object_without_properties_loose(props, ["href", "as", "children", "prefetch", "passHref", "replace", "shallow", "scroll", "locale", "onClick", "onMouseEnter", "onTouchStart", "legacyBehavior"]);

  children = childrenProp;

  if (legacyBehavior && (typeof children === 'string' || typeof children === 'number')) {
    children = /*#__PURE__*/_react.default.createElement("a", null, children);
  }

  const prefetchEnabled = prefetchProp !== false;

  const pagesRouter = _react.default.useContext(_routerContext.RouterContext);

  const appRouter = _react.default.useContext(_appRouterContext.AppRouterContext);

  const router = pagesRouter != null ? pagesRouter : appRouter; // We're in the app directory if there is no pages router.

  const isAppRouter = !pagesRouter;

  if (false) {}

  const {
    href,
    as
  } = _react.default.useMemo(() => {
    if (!pagesRouter) {
      const resolvedHref = formatStringOrUrl(hrefProp);
      return {
        href: resolvedHref,
        as: asProp ? formatStringOrUrl(asProp) : resolvedHref
      };
    }

    const [resolvedHref, resolvedAs] = (0, _resolveHref).resolveHref(pagesRouter, hrefProp, true);
    return {
      href: resolvedHref,
      as: asProp ? (0, _resolveHref).resolveHref(pagesRouter, asProp) : resolvedAs || resolvedHref
    };
  }, [pagesRouter, hrefProp, asProp]);

  const previousHref = _react.default.useRef(href);

  const previousAs = _react.default.useRef(as); // This will return the first child, if multiple are provided it will throw an error


  let child;

  if (legacyBehavior) {
    if (false) {} else {
      child = _react.default.Children.only(children);
    }
  } else {
    if (false) { var ref; }
  }

  const childRef = legacyBehavior ? child && typeof child === 'object' && child.ref : forwardedRef;
  const [setIntersectionRef, isVisible, resetVisible] = (0, _useIntersection).useIntersection({
    rootMargin: '200px'
  });

  const setRef = _react.default.useCallback(el => {
    // Before the link getting observed, check if visible state need to be reset
    if (previousAs.current !== as || previousHref.current !== href) {
      resetVisible();
      previousAs.current = as;
      previousHref.current = href;
    }

    setIntersectionRef(el);

    if (childRef) {
      if (typeof childRef === 'function') childRef(el);else if (typeof childRef === 'object') {
        childRef.current = el;
      }
    }
  }, [as, childRef, href, resetVisible, setIntersectionRef]); // Prefetch the URL if we haven't already and it's visible.


  _react.default.useEffect(() => {
    // in dev, we only prefetch on hover to avoid wasting resources as the prefetch will trigger compiling the page.
    if (false) {}

    if (!router) {
      return;
    } // If we don't need to prefetch the URL, don't do prefetch.


    if (!isVisible || !prefetchEnabled) {
      return;
    } // Prefetch the URL.


    prefetch(router, href, as, {
      locale
    }, isAppRouter);
  }, [as, href, isVisible, locale, prefetchEnabled, pagesRouter == null ? void 0 : pagesRouter.locale, router, isAppRouter]);

  const childProps = {
    ref: setRef,

    onClick(e) {
      if (false) {}

      if (!legacyBehavior && typeof onClick === 'function') {
        onClick(e);
      }

      if (legacyBehavior && child.props && typeof child.props.onClick === 'function') {
        child.props.onClick(e);
      }

      if (!router) {
        return;
      }

      if (e.defaultPrevented) {
        return;
      }

      linkClicked(e, router, href, as, replace, shallow, scroll, locale, isAppRouter, prefetchEnabled);
    },

    onMouseEnter(e) {
      if (!legacyBehavior && typeof onMouseEnterProp === 'function') {
        onMouseEnterProp(e);
      }

      if (legacyBehavior && child.props && typeof child.props.onMouseEnter === 'function') {
        child.props.onMouseEnter(e);
      }

      if (!router) {
        return;
      }

      if (!prefetchEnabled && isAppRouter) {
        return;
      }

      prefetch(router, href, as, {
        locale,
        priority: true,
        // @see {https://github.com/vercel/next.js/discussions/40268?sort=top#discussioncomment-3572642}
        bypassPrefetchedCheck: true
      }, isAppRouter);
    },

    onTouchStart(e) {
      if (!legacyBehavior && typeof onTouchStartProp === 'function') {
        onTouchStartProp(e);
      }

      if (legacyBehavior && child.props && typeof child.props.onTouchStart === 'function') {
        child.props.onTouchStart(e);
      }

      if (!router) {
        return;
      }

      if (!prefetchEnabled && isAppRouter) {
        return;
      }

      prefetch(router, href, as, {
        locale,
        priority: true,
        // @see {https://github.com/vercel/next.js/discussions/40268?sort=top#discussioncomment-3572642}
        bypassPrefetchedCheck: true
      }, isAppRouter);
    }

  }; // If child is an <a> tag and doesn't have a href attribute, or if the 'passHref' property is
  // defined, we specify the current 'href', so that repetition is not needed by the user.
  // If the url is absolute, we can bypass the logic to prepend the domain and locale.

  if ((0, _utils).isAbsoluteUrl(as)) {
    childProps.href = as;
  } else if (!legacyBehavior || passHref || child.type === 'a' && !('href' in child.props)) {
    const curLocale = typeof locale !== 'undefined' ? locale : pagesRouter == null ? void 0 : pagesRouter.locale; // we only render domain locales if we are currently on a domain locale
    // so that locale links are still visitable in development/preview envs

    const localeDomain = (pagesRouter == null ? void 0 : pagesRouter.isLocaleDomain) && (0, _getDomainLocale).getDomainLocale(as, curLocale, pagesRouter == null ? void 0 : pagesRouter.locales, pagesRouter == null ? void 0 : pagesRouter.domainLocales);
    childProps.href = localeDomain || (0, _addBasePath).addBasePath((0, _addLocale).addLocale(as, curLocale, pagesRouter == null ? void 0 : pagesRouter.defaultLocale));
  }

  return legacyBehavior ? /*#__PURE__*/_react.default.cloneElement(child, childProps) : /*#__PURE__*/_react.default.createElement("a", Object.assign({}, restProps, childProps), children);
});

var _default = Link;
exports["default"] = _default;

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 8830:
/***/ ((module, exports, __webpack_require__) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.normalizePathTrailingSlash = void 0;

var _removeTrailingSlash = __webpack_require__(3297);

var _parsePath = __webpack_require__(8854);

const normalizePathTrailingSlash = path => {
  if (!path.startsWith('/') || undefined) {
    return path;
  }

  const {
    pathname,
    query,
    hash
  } = (0, _parsePath).parsePath(path);

  if (false) {}

  return `${(0, _removeTrailingSlash).removeTrailingSlash(pathname)}${query}${hash}`;
};

exports.normalizePathTrailingSlash = normalizePathTrailingSlash;

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 7443:
/***/ ((module, exports) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.cancelIdleCallback = exports.requestIdleCallback = void 0;

const requestIdleCallback = typeof self !== 'undefined' && self.requestIdleCallback && self.requestIdleCallback.bind(window) || function (cb) {
  let start = Date.now();
  return self.setTimeout(function () {
    cb({
      didTimeout: false,
      timeRemaining: function () {
        return Math.max(0, 50 - (Date.now() - start));
      }
    });
  }, 1);
};

exports.requestIdleCallback = requestIdleCallback;

const cancelIdleCallback = typeof self !== 'undefined' && self.cancelIdleCallback && self.cancelIdleCallback.bind(window) || function (id) {
  return clearTimeout(id);
};

exports.cancelIdleCallback = cancelIdleCallback;

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 3428:
/***/ ((module, exports, __webpack_require__) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.useIntersection = useIntersection;

var _react = __webpack_require__(8038);

var _requestIdleCallback = __webpack_require__(7443);

const hasIntersectionObserver = typeof IntersectionObserver === 'function';
const observers = new Map();
const idList = [];

function createObserver(options) {
  const id = {
    root: options.root || null,
    margin: options.rootMargin || ''
  };
  const existing = idList.find(obj => obj.root === id.root && obj.margin === id.margin);
  let instance;

  if (existing) {
    instance = observers.get(existing);

    if (instance) {
      return instance;
    }
  }

  const elements = new Map();
  const observer = new IntersectionObserver(entries => {
    entries.forEach(entry => {
      const callback = elements.get(entry.target);
      const isVisible = entry.isIntersecting || entry.intersectionRatio > 0;

      if (callback && isVisible) {
        callback(isVisible);
      }
    });
  }, options);
  instance = {
    id,
    observer,
    elements
  };
  idList.push(id);
  observers.set(id, instance);
  return instance;
}

function observe(element, callback, options) {
  const {
    id,
    observer,
    elements
  } = createObserver(options);
  elements.set(element, callback);
  observer.observe(element);
  return function unobserve() {
    elements.delete(element);
    observer.unobserve(element); // Destroy observer when there's nothing left to watch:

    if (elements.size === 0) {
      observer.disconnect();
      observers.delete(id);
      const index = idList.findIndex(obj => obj.root === id.root && obj.margin === id.margin);

      if (index > -1) {
        idList.splice(index, 1);
      }
    }
  };
}

function useIntersection({
  rootRef,
  rootMargin,
  disabled
}) {
  const isDisabled = disabled || !hasIntersectionObserver;
  const [visible, setVisible] = (0, _react).useState(false);
  const elementRef = (0, _react).useRef(null);
  const setElement = (0, _react).useCallback(element => {
    elementRef.current = element;
  }, []);
  (0, _react).useEffect(() => {
    if (hasIntersectionObserver) {
      if (isDisabled || visible) return;
      const element = elementRef.current;

      if (element && element.tagName) {
        const unobserve = observe(element, isVisible => isVisible && setVisible(isVisible), {
          root: rootRef == null ? void 0 : rootRef.current,
          rootMargin
        });
        return unobserve;
      }
    } else {
      if (!visible) {
        const idleCallback = (0, _requestIdleCallback).requestIdleCallback(() => setVisible(true));
        return () => (0, _requestIdleCallback).cancelIdleCallback(idleCallback);
      }
    } // eslint-disable-next-line react-hooks/exhaustive-deps

  }, [isDisabled, rootMargin, rootRef, visible, elementRef.current]);
  const resetVisible = (0, _react).useCallback(() => {
    setVisible(false);
  }, []);
  return [setElement, visible, resetVisible];
}

if ((typeof exports.default === 'function' || typeof exports.default === 'object' && exports.default !== null) && typeof exports.default.__esModule === 'undefined') {
  Object.defineProperty(exports.default, '__esModule', {
    value: true
  });
  Object.assign(exports.default, exports);
  module.exports = exports.default;
}

/***/ }),

/***/ 7259:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {

"use client";
"use strict";

Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.suspense = suspense;
exports.NoSSR = NoSSR;

var _interop_require_default = (__webpack_require__(6356)/* ["default"] */ .Z);

var _react = _interop_require_default(__webpack_require__(8038));

var _noSsrError = __webpack_require__(2192);

function suspense() {
  const error = new Error(_noSsrError.NEXT_DYNAMIC_NO_SSR_CODE);
  error.digest = _noSsrError.NEXT_DYNAMIC_NO_SSR_CODE;
  throw error;
}

function NoSSR({
  children
}) {
  if (true) {
    suspense();
  }

  return children;
}

/***/ }),

/***/ 2192:
/***/ ((__unused_webpack_module, exports) => {

"use strict";


Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports.NEXT_DYNAMIC_NO_SSR_CODE = void 0;
const NEXT_DYNAMIC_NO_SSR_CODE = 'DYNAMIC_SERVER_USAGE';
exports.NEXT_DYNAMIC_NO_SSR_CODE = NEXT_DYNAMIC_NO_SSR_CODE;

/***/ }),

/***/ 7520:
/***/ ((__unused_webpack_module, exports) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({
    value: true
}));
exports.createProxy = createProxy;
/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */ // Modified from https://github.com/facebook/react/blob/main/packages/react-server-dom-webpack/src/ReactFlightWebpackNodeRegister.js
const CLIENT_REFERENCE = Symbol.for("react.client.reference");
const PROMISE_PROTOTYPE = Promise.prototype;
const deepProxyHandlers = {
    get: function(target, name, _receiver) {
        switch(name){
            // These names are read by the Flight runtime if you end up using the exports object.
            case "$$typeof":
                // These names are a little too common. We should probably have a way to
                // have the Flight runtime extract the inner target instead.
                return target.$$typeof;
            case "$$id":
                return target.$$id;
            case "$$async":
                return target.$$async;
            case "name":
                return target.name;
            case "displayName":
                return undefined;
            // We need to special case this because createElement reads it if we pass this
            // reference.
            case "defaultProps":
                return undefined;
            // Avoid this attempting to be serialized.
            case "toJSON":
                return undefined;
            case Symbol.toPrimitive.toString():
                // @ts-ignore
                return Object.prototype[Symbol.toPrimitive];
            case "Provider":
                throw new Error(`Cannot render a Client Context Provider on the Server. ` + `Instead, you can export a Client Component wrapper ` + `that itself renders a Client Context Provider.`);
            default:
                break;
        }
        const expression = String(target.name) + "." + String(name);
        throw new Error(`Cannot access ${expression} on the server. ` + "You cannot dot into a client module from a server component. " + "You can only pass the imported name through.");
    },
    set: function() {
        throw new Error("Cannot assign to a client module from a server module.");
    }
};
const proxyHandlers = {
    get: function(target, name, _receiver) {
        switch(name){
            // These names are read by the Flight runtime if you end up using the exports object.
            case "$$typeof":
                return target.$$typeof;
            case "$$id":
                return target.$$id;
            case "$$async":
                return target.$$async;
            case "name":
                return target.name;
            // We need to special case this because createElement reads it if we pass this
            // reference.
            case "defaultProps":
                return undefined;
            // Avoid this attempting to be serialized.
            case "toJSON":
                return undefined;
            case Symbol.toPrimitive.toString():
                // @ts-ignore
                return Object.prototype[Symbol.toPrimitive];
            case "__esModule":
                // Something is conditionally checking which export to use. We'll pretend to be
                // an ESM compat module but then we'll check again on the client.
                const moduleId = target.$$id;
                target.default = Object.defineProperties(function() {
                    throw new Error(`Attempted to call the default export of ${moduleId} from the server ` + `but it's on the client. It's not possible to invoke a client function from ` + `the server, it can only be rendered as a Component or passed to props of a ` + `Client Component.`);
                }, {
                    $$typeof: {
                        value: CLIENT_REFERENCE
                    },
                    // This a placeholder value that tells the client to conditionally use the
                    // whole object or just the default export.
                    $$id: {
                        value: target.$$id + "#"
                    },
                    $$async: {
                        value: target.$$async
                    }
                });
                return true;
            case "then":
                if (target.then) {
                    // Use a cached value
                    return target.then;
                }
                if (!target.$$async) {
                    // If this module is expected to return a Promise (such as an AsyncModule) then
                    // we should resolve that with a client reference that unwraps the Promise on
                    // the client.
                    const clientReference = Object.defineProperties({}, {
                        $$typeof: {
                            value: CLIENT_REFERENCE
                        },
                        $$id: {
                            value: target.$$id
                        },
                        $$async: {
                            value: true
                        }
                    });
                    const proxy = new Proxy(clientReference, proxyHandlers); // Treat this as a resolved Promise for React's use()
                    target.status = "fulfilled";
                    target.value = proxy;
                    const then = target.then = Object.defineProperties(function then(resolve, _reject) {
                        // Expose to React.
                        return Promise.resolve(resolve(proxy));
                    }, // export then we should treat it as a reference to that name.
                    {
                        $$typeof: {
                            value: CLIENT_REFERENCE
                        },
                        $$id: {
                            value: target.$$id
                        },
                        $$async: {
                            value: false
                        }
                    });
                    return then;
                } else {
                    // Since typeof .then === 'function' is a feature test we'd continue recursing
                    // indefinitely if we return a function. Instead, we return an object reference
                    // if we check further.
                    return undefined;
                }
            default:
                break;
        }
        let cachedReference = target[name];
        if (!cachedReference) {
            const reference = Object.defineProperties(function() {
                throw new Error(`Attempted to call ${String(name)}() from the server but ${String(name)} is on the client. ` + `It's not possible to invoke a client function from the server, it can ` + `only be rendered as a Component or passed to props of a Client Component.`);
            }, {
                $$typeof: {
                    value: CLIENT_REFERENCE
                },
                $$id: {
                    value: target.$$id + "#" + name
                },
                $$async: {
                    value: target.$$async
                }
            });
            cachedReference = target[name] = new Proxy(reference, deepProxyHandlers);
        }
        return cachedReference;
    },
    getPrototypeOf (_target) {
        // Pretend to be a Promise in case anyone asks.
        return PROMISE_PROTOTYPE;
    },
    set: function() {
        throw new Error("Cannot assign to a client module from a server module.");
    }
};
function createProxy(moduleId) {
    const clientReference = Object.defineProperties({}, {
        $$typeof: {
            value: CLIENT_REFERENCE
        },
        // Represents the whole Module object instead of a particular import.
        $$id: {
            value: moduleId
        },
        $$async: {
            value: false
        }
    });
    return new Proxy(clientReference, proxyHandlers);
}


/***/ }),

/***/ 6789:
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

/* __next_internal_client_entry_do_not_use__  */ const { createProxy  } = __webpack_require__(7520);
module.exports = createProxy("/data/data/com.termux/files/home/cavo/node_modules/next/dist/client/components/app-router.js");


/***/ }),

/***/ 9786:
/***/ ((module, exports) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({
    value: true
}));
exports.createAsyncLocalStorage = createAsyncLocalStorage;
class FakeAsyncLocalStorage {
    disable() {
        throw new Error("Invariant: AsyncLocalStorage accessed in runtime where it is not available");
    }
    getStore() {
        // This fake implementation of AsyncLocalStorage always returns `undefined`.
        return undefined;
    }
    run() {
        throw new Error("Invariant: AsyncLocalStorage accessed in runtime where it is not available");
    }
    exit() {
        throw new Error("Invariant: AsyncLocalStorage accessed in runtime where it is not available");
    }
    enterWith() {
        throw new Error("Invariant: AsyncLocalStorage accessed in runtime where it is not available");
    }
}
function createAsyncLocalStorage() {
    if (globalThis.AsyncLocalStorage) {
        return new globalThis.AsyncLocalStorage();
    }
    return new FakeAsyncLocalStorage();
}
if ((typeof exports.default === "function" || typeof exports.default === "object" && exports.default !== null) && typeof exports.default.__esModule === "undefined") {
    Object.defineProperty(exports.default, "__esModule", {
        value: true
    });
    Object.assign(exports.default, exports);
    module.exports = exports.default;
}


/***/ }),

/***/ 5998:
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

/* __next_internal_client_entry_do_not_use__  */ const { createProxy  } = __webpack_require__(7520);
module.exports = createProxy("/data/data/com.termux/files/home/cavo/node_modules/next/dist/client/components/error-boundary.js");


/***/ }),

/***/ 1488:
/***/ ((module, exports) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({
    value: true
}));
exports.DYNAMIC_ERROR_CODE = void 0;
const DYNAMIC_ERROR_CODE = "DYNAMIC_SERVER_USAGE";
exports.DYNAMIC_ERROR_CODE = DYNAMIC_ERROR_CODE;
class DynamicServerError extends Error {
    constructor(type){
        super(`Dynamic server usage: ${type}`);
        this.digest = DYNAMIC_ERROR_CODE;
    }
}
exports.DynamicServerError = DynamicServerError;
if ((typeof exports.default === "function" || typeof exports.default === "object" && exports.default !== null) && typeof exports.default.__esModule === "undefined") {
    Object.defineProperty(exports.default, "__esModule", {
        value: true
    });
    Object.assign(exports.default, exports);
    module.exports = exports.default;
}


/***/ }),

/***/ 277:
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

/* __next_internal_client_entry_do_not_use__  */ const { createProxy  } = __webpack_require__(7520);
module.exports = createProxy("/data/data/com.termux/files/home/cavo/node_modules/next/dist/client/components/layout-router.js");


/***/ }),

/***/ 639:
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

/* __next_internal_client_entry_do_not_use__  */ const { createProxy  } = __webpack_require__(7520);
module.exports = createProxy("/data/data/com.termux/files/home/cavo/node_modules/next/dist/client/components/render-from-template-context.js");


/***/ }),

/***/ 6425:
/***/ ((module, exports, __webpack_require__) => {

"use strict";

Object.defineProperty(exports, "__esModule", ({
    value: true
}));
exports.requestAsyncStorage = void 0;
var _asyncLocalStorage = __webpack_require__(9786);
const requestAsyncStorage = (0, _asyncLocalStorage).createAsyncLocalStorage();
exports.requestAsyncStorage = requestAsyncStorage;
if ((typeof exports.default === "function" || typeof exports.default === "object" && exports.default !== null) && typeof exports.default.__esModule === "undefined") {
    Object.defineProperty(exports.default, "__esModule", {
        value: true
    });
    Object.assign(exports.default, exports);
    module.exports = exports.default;
}


/***/ }),

/***/ 1395:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {

"use strict";
/**
 * @license React
 * react-server-dom-webpack-server.edge.production.min.js
 *
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */ 
var aa = __webpack_require__(3229), f = "function" === typeof AsyncLocalStorage, ba = f ? new AsyncLocalStorage() : null, m = null, n = 0;
function p(a, b) {
    if (0 !== b.length) if (512 < b.length) 0 < n && (a.enqueue(new Uint8Array(m.buffer, 0, n)), m = new Uint8Array(512), n = 0), a.enqueue(b);
    else {
        var c = m.length - n;
        c < b.length && (0 === c ? a.enqueue(m) : (m.set(b.subarray(0, c), n), a.enqueue(m), b = b.subarray(c)), m = new Uint8Array(512), n = 0);
        m.set(b, n);
        n += b.length;
    }
    return !0;
}
var q = new TextEncoder();
function r(a) {
    return q.encode(a);
}
function ca(a, b) {
    "function" === typeof a.error ? a.error(b) : a.close();
}
var t = JSON.stringify;
function da(a, b, c) {
    a = t(c, a.toJSON);
    b = b.toString(16) + ":" + a + "\n";
    return q.encode(b);
}
function u(a, b, c) {
    a = t(c);
    b = b.toString(16) + ":" + a + "\n";
    return q.encode(b);
}
var w = Symbol.for("react.client.reference"), ea = Symbol.for("react.server.reference"), y = Symbol.for("react.element"), fa = Symbol.for("react.fragment"), ja = Symbol.for("react.provider"), ka = Symbol.for("react.server_context"), la = Symbol.for("react.forward_ref"), ma = Symbol.for("react.suspense"), na = Symbol.for("react.suspense_list"), oa = Symbol.for("react.memo"), z = Symbol.for("react.lazy"), pa = Symbol.for("react.default_value"), qa = Symbol.for("react.memo_cache_sentinel"), ra = Symbol.iterator;
function A(a, b, c, d, e, g, h) {
    this.acceptsBooleans = 2 === b || 3 === b || 4 === b;
    this.attributeName = d;
    this.attributeNamespace = e;
    this.mustUseProperty = c;
    this.propertyName = a;
    this.type = b;
    this.sanitizeURL = g;
    this.removeEmptyString = h;
}
"children dangerouslySetInnerHTML defaultValue defaultChecked innerHTML suppressContentEditableWarning suppressHydrationWarning style".split(" ").forEach(function(a) {
    new A(a, 0, !1, a, null, !1, !1);
});
[
    [
        "acceptCharset",
        "accept-charset"
    ],
    [
        "className",
        "class"
    ],
    [
        "htmlFor",
        "for"
    ],
    [
        "httpEquiv",
        "http-equiv"
    ]
].forEach(function(a) {
    new A(a[0], 1, !1, a[1], null, !1, !1);
});
[
    "contentEditable",
    "draggable",
    "spellCheck",
    "value"
].forEach(function(a) {
    new A(a, 2, !1, a.toLowerCase(), null, !1, !1);
});
[
    "autoReverse",
    "externalResourcesRequired",
    "focusable",
    "preserveAlpha"
].forEach(function(a) {
    new A(a, 2, !1, a, null, !1, !1);
});
"allowFullScreen async autoFocus autoPlay controls default defer disabled disablePictureInPicture disableRemotePlayback formNoValidate hidden loop noModule noValidate open playsInline readOnly required reversed scoped seamless itemScope".split(" ").forEach(function(a) {
    new A(a, 3, !1, a.toLowerCase(), null, !1, !1);
});
[
    "checked",
    "multiple",
    "muted",
    "selected"
].forEach(function(a) {
    new A(a, 3, !0, a, null, !1, !1);
});
[
    "capture",
    "download"
].forEach(function(a) {
    new A(a, 4, !1, a, null, !1, !1);
});
[
    "cols",
    "rows",
    "size",
    "span"
].forEach(function(a) {
    new A(a, 6, !1, a, null, !1, !1);
});
[
    "rowSpan",
    "start"
].forEach(function(a) {
    new A(a, 5, !1, a.toLowerCase(), null, !1, !1);
});
var B = /[\-:]([a-z])/g;
function C(a) {
    return a[1].toUpperCase();
}
"accent-height alignment-baseline arabic-form baseline-shift cap-height clip-path clip-rule color-interpolation color-interpolation-filters color-profile color-rendering dominant-baseline enable-background fill-opacity fill-rule flood-color flood-opacity font-family font-size font-size-adjust font-stretch font-style font-variant font-weight glyph-name glyph-orientation-horizontal glyph-orientation-vertical horiz-adv-x horiz-origin-x image-rendering letter-spacing lighting-color marker-end marker-mid marker-start overline-position overline-thickness paint-order panose-1 pointer-events rendering-intent shape-rendering stop-color stop-opacity strikethrough-position strikethrough-thickness stroke-dasharray stroke-dashoffset stroke-linecap stroke-linejoin stroke-miterlimit stroke-opacity stroke-width text-anchor text-decoration text-rendering transform-origin underline-position underline-thickness unicode-bidi unicode-range units-per-em v-alphabetic v-hanging v-ideographic v-mathematical vector-effect vert-adv-y vert-origin-x vert-origin-y word-spacing writing-mode xmlns:xlink x-height".split(" ").forEach(function(a) {
    var b = a.replace(B, C);
    new A(b, 1, !1, a, null, !1, !1);
});
"xlink:actuate xlink:arcrole xlink:role xlink:show xlink:title xlink:type".split(" ").forEach(function(a) {
    var b = a.replace(B, C);
    new A(b, 1, !1, a, "http://www.w3.org/1999/xlink", !1, !1);
});
[
    "xml:base",
    "xml:lang",
    "xml:space"
].forEach(function(a) {
    var b = a.replace(B, C);
    new A(b, 1, !1, a, "http://www.w3.org/XML/1998/namespace", !1, !1);
});
[
    "tabIndex",
    "crossOrigin"
].forEach(function(a) {
    new A(a, 1, !1, a.toLowerCase(), null, !1, !1);
});
new A("xlinkHref", 1, !1, "xlink:href", "http://www.w3.org/1999/xlink", !0, !1);
[
    "src",
    "href",
    "action",
    "formAction"
].forEach(function(a) {
    new A(a, 1, !1, a.toLowerCase(), null, !0, !0);
});
var D = {
    animationIterationCount: !0,
    aspectRatio: !0,
    borderImageOutset: !0,
    borderImageSlice: !0,
    borderImageWidth: !0,
    boxFlex: !0,
    boxFlexGroup: !0,
    boxOrdinalGroup: !0,
    columnCount: !0,
    columns: !0,
    flex: !0,
    flexGrow: !0,
    flexPositive: !0,
    flexShrink: !0,
    flexNegative: !0,
    flexOrder: !0,
    gridArea: !0,
    gridRow: !0,
    gridRowEnd: !0,
    gridRowSpan: !0,
    gridRowStart: !0,
    gridColumn: !0,
    gridColumnEnd: !0,
    gridColumnSpan: !0,
    gridColumnStart: !0,
    fontWeight: !0,
    lineClamp: !0,
    lineHeight: !0,
    opacity: !0,
    order: !0,
    orphans: !0,
    scale: !0,
    tabSize: !0,
    widows: !0,
    zIndex: !0,
    zoom: !0,
    fillOpacity: !0,
    floodOpacity: !0,
    stopOpacity: !0,
    strokeDasharray: !0,
    strokeDashoffset: !0,
    strokeMiterlimit: !0,
    strokeOpacity: !0,
    strokeWidth: !0
}, sa = [
    "Webkit",
    "ms",
    "Moz",
    "O"
];
Object.keys(D).forEach(function(a) {
    sa.forEach(function(b) {
        b = b + a.charAt(0).toUpperCase() + a.substring(1);
        D[b] = D[a];
    });
});
var E = Array.isArray;
r('"></template>');
r("<script>");
r("</script>");
r('<script src="');
r('<script type="module" src="');
r('" integrity="');
r('" async=""></script>');
r("<!-- -->");
r(' style="');
r(":");
r(";");
r(" ");
r('="');
r('"');
r('=""');
r(">");
r("/>");
r(' selected=""');
r("\n");
r("<!DOCTYPE html>");
r("</");
r(">");
r('<template id="');
r('"></template>');
r("<!--$-->");
r('<!--$?--><template id="');
r('"></template>');
r("<!--$!-->");
r("<!--/$-->");
r("<template");
r('"');
r(' data-dgst="');
r(' data-msg="');
r(' data-stck="');
r("></template>");
r('<div hidden id="');
r('">');
r("</div>");
r('<svg aria-hidden="true" style="display:none" id="');
r('">');
r("</svg>");
r('<math aria-hidden="true" style="display:none" id="');
r('">');
r("</math>");
r('<table hidden id="');
r('">');
r("</table>");
r('<table hidden><tbody id="');
r('">');
r("</tbody></table>");
r('<table hidden><tr id="');
r('">');
r("</tr></table>");
r('<table hidden><colgroup id="');
r('">');
r("</colgroup></table>");
r('$RS=function(a,b){a=document.getElementById(a);b=document.getElementById(b);for(a.parentNode.removeChild(a);a.firstChild;)b.parentNode.insertBefore(a.firstChild,b);b.parentNode.removeChild(b)};;$RS("');
r('$RS("');
r('","');
r('")</script>');
r('<template data-rsi="" data-sid="');
r('" data-pid="');
r('$RC=function(b,c,e){c=document.getElementById(c);c.parentNode.removeChild(c);var a=document.getElementById(b);if(a){b=a.previousSibling;if(e)b.data="$!",a.setAttribute("data-dgst",e);else{e=b.parentNode;a=b.nextSibling;var f=0;do{if(a&&8===a.nodeType){var d=a.data;if("/$"===d)if(0===f)break;else f--;else"$"!==d&&"$?"!==d&&"$!"!==d||f++}d=a.nextSibling;e.removeChild(a);a=d}while(a);for(;c.firstChild;)e.insertBefore(c.firstChild,a);b.data="$"}b._reactRetry&&b._reactRetry()}};$RC("');
r('$RC("');
r('$RC=function(b,c,e){c=document.getElementById(c);c.parentNode.removeChild(c);var a=document.getElementById(b);if(a){b=a.previousSibling;if(e)b.data="$!",a.setAttribute("data-dgst",e);else{e=b.parentNode;a=b.nextSibling;var f=0;do{if(a&&8===a.nodeType){var d=a.data;if("/$"===d)if(0===f)break;else f--;else"$"!==d&&"$?"!==d&&"$!"!==d||f++}d=a.nextSibling;e.removeChild(a);a=d}while(a);for(;c.firstChild;)e.insertBefore(c.firstChild,a);b.data="$"}b._reactRetry&&b._reactRetry()}};$RM=new Map;\n$RR=function(t,u,y){function v(n){this.s=n}for(var w=$RC,p=$RM,q=new Map,r=document,g,b,h=r.querySelectorAll("link[data-precedence],style[data-precedence]"),x=[],k=0;b=h[k++];)"not all"===b.getAttribute("media")?x.push(b):("LINK"===b.tagName&&p.set(b.getAttribute("href"),b),q.set(b.dataset.precedence,g=b));b=0;h=[];var l,a;for(k=!0;;){if(k){var f=y[b++];if(!f){k=!1;b=0;continue}var c=!1,m=0;var e=f[m++];if(a=p.get(e)){var d=a._p;c=!0}else{a=r.createElement("link");a.href=e;a.rel=\n"stylesheet";for(a.dataset.precedence=l=f[m++];d=f[m++];)a.setAttribute(d,f[m++]);d=a._p=new Promise(function(n,z){a.onload=n;a.onerror=z});d.then(v.bind(d,"l"),v.bind(d,"e"));p.set(e,a)}e=a.getAttribute("media");!d||"l"===d.s||e&&!matchMedia(e).matches||h.push(d);if(c)continue}else{a=x[b++];if(!a)break;l=a.getAttribute("data-precedence");a.removeAttribute("media")}c=q.get(l)||g;c===g&&(g=a);q.set(l,a);c?c.parentNode.insertBefore(a,c.nextSibling):(c=r.head,c.insertBefore(a,c.firstChild))}Promise.all(h).then(w.bind(null,\nt,u,""),w.bind(null,t,u,"Resource failed to load"))};$RR("');
r('$RM=new Map;\n$RR=function(t,u,y){function v(n){this.s=n}for(var w=$RC,p=$RM,q=new Map,r=document,g,b,h=r.querySelectorAll("link[data-precedence],style[data-precedence]"),x=[],k=0;b=h[k++];)"not all"===b.getAttribute("media")?x.push(b):("LINK"===b.tagName&&p.set(b.getAttribute("href"),b),q.set(b.dataset.precedence,g=b));b=0;h=[];var l,a;for(k=!0;;){if(k){var f=y[b++];if(!f){k=!1;b=0;continue}var c=!1,m=0;var e=f[m++];if(a=p.get(e)){var d=a._p;c=!0}else{a=r.createElement("link");a.href=e;a.rel=\n"stylesheet";for(a.dataset.precedence=l=f[m++];d=f[m++];)a.setAttribute(d,f[m++]);d=a._p=new Promise(function(n,z){a.onload=n;a.onerror=z});d.then(v.bind(d,"l"),v.bind(d,"e"));p.set(e,a)}e=a.getAttribute("media");!d||"l"===d.s||e&&!matchMedia(e).matches||h.push(d);if(c)continue}else{a=x[b++];if(!a)break;l=a.getAttribute("data-precedence");a.removeAttribute("media")}c=q.get(l)||g;c===g&&(g=a);q.set(l,a);c?c.parentNode.insertBefore(a,c.nextSibling):(c=r.head,c.insertBefore(a,c.firstChild))}Promise.all(h).then(w.bind(null,\nt,u,""),w.bind(null,t,u,"Resource failed to load"))};$RR("');
r('$RR("');
r('","');
r('",');
r('"');
r(")</script>");
r('<template data-rci="" data-bid="');
r('<template data-rri="" data-bid="');
r('" data-sid="');
r('" data-sty="');
r('$RX=function(b,c,d,e){var a=document.getElementById(b);a&&(b=a.previousSibling,b.data="$!",a=a.dataset,c&&(a.dgst=c),d&&(a.msg=d),e&&(a.stck=e),b._reactRetry&&b._reactRetry())};;$RX("');
r('$RX("');
r('"');
r(",");
r(")</script>");
r('<template data-rxi="" data-bid="');
r('" data-dgst="');
r('" data-msg="');
r('" data-stck="');
r('<style media="not all" data-precedence="');
r('" data-href="');
r('">');
r("</style>");
r('<style data-precedence="');
r('" data-href="');
r(" ");
r('">');
r("</style>");
r("[");
r(",[");
r(",");
r("]");
var G = null;
function H(a, b) {
    if (a !== b) {
        a.context._currentValue = a.parentValue;
        a = a.parent;
        var c = b.parent;
        if (null === a) {
            if (null !== c) throw Error("The stacks must reach the root at the same time. This is a bug in React.");
        } else {
            if (null === c) throw Error("The stacks must reach the root at the same time. This is a bug in React.");
            H(a, c);
            b.context._currentValue = b.value;
        }
    }
}
function ta(a) {
    a.context._currentValue = a.parentValue;
    a = a.parent;
    null !== a && ta(a);
}
function ua(a) {
    var b = a.parent;
    null !== b && ua(b);
    a.context._currentValue = a.value;
}
function va(a, b) {
    a.context._currentValue = a.parentValue;
    a = a.parent;
    if (null === a) throw Error("The depth must equal at least at zero before reaching the root. This is a bug in React.");
    a.depth === b.depth ? H(a, b) : va(a, b);
}
function wa(a, b) {
    var c = b.parent;
    if (null === c) throw Error("The depth must equal at least at zero before reaching the root. This is a bug in React.");
    a.depth === c.depth ? H(a, c) : wa(a, c);
    b.context._currentValue = b.value;
}
function I(a) {
    var b = G;
    b !== a && (null === b ? ua(a) : null === a ? ta(b) : b.depth === a.depth ? H(b, a) : b.depth > a.depth ? va(b, a) : wa(b, a), G = a);
}
function xa(a, b) {
    var c = a._currentValue;
    a._currentValue = b;
    var d = G;
    return G = a = {
        parent: d,
        depth: null === d ? 0 : d.depth + 1,
        context: a,
        parentValue: c,
        value: b
    };
}
var J = Error("Suspense Exception: This is not a real error! It's an implementation detail of `use` to interrupt the current render. You must either rethrow it immediately, or move the `use` call outside of the `try/catch` block. Capturing without rethrowing will lead to unexpected behavior.\n\nTo handle async errors, wrap your component in an error boundary, or call the promise's `.catch` method and pass the result to `use`");
function ya() {}
function za(a, b, c) {
    c = a[c];
    void 0 === c ? a.push(b) : c !== b && (b.then(ya, ya), b = c);
    switch(b.status){
        case "fulfilled":
            return b.value;
        case "rejected":
            throw b.reason;
        default:
            if ("string" !== typeof b.status) switch(a = b, a.status = "pending", a.then(function(d) {
                if ("pending" === b.status) {
                    var e = b;
                    e.status = "fulfilled";
                    e.value = d;
                }
            }, function(d) {
                if ("pending" === b.status) {
                    var e = b;
                    e.status = "rejected";
                    e.reason = d;
                }
            }), b.status){
                case "fulfilled":
                    return b.value;
                case "rejected":
                    throw b.reason;
            }
            K = b;
            throw J;
    }
}
var K = null;
function Aa() {
    if (null === K) throw Error("Expected a suspended thenable. This is a bug in React. Please file an issue.");
    var a = K;
    K = null;
    return a;
}
var L = null, N = 0, O = null;
function Ba() {
    var a = O;
    O = null;
    return a;
}
function Ca(a) {
    return a._currentValue;
}
var Ga = {
    useMemo: function(a) {
        return a();
    },
    useCallback: function(a) {
        return a;
    },
    useDebugValue: function() {},
    useDeferredValue: P,
    useTransition: P,
    readContext: Ca,
    useContext: Ca,
    useReducer: P,
    useRef: P,
    useState: P,
    useInsertionEffect: P,
    useLayoutEffect: P,
    useImperativeHandle: P,
    useEffect: P,
    useId: Da,
    useMutableSource: P,
    useSyncExternalStore: P,
    useCacheRefresh: function() {
        return Ea;
    },
    useMemoCache: function(a) {
        for(var b = Array(a), c = 0; c < a; c++)b[c] = qa;
        return b;
    },
    use: Fa
};
function P() {
    throw Error("This Hook is not supported in Server Components.");
}
function Ea() {
    throw Error("Refreshing the cache is not supported in Server Components.");
}
function Da() {
    if (null === L) throw Error("useId can only be used while React is rendering");
    var a = L.identifierCount++;
    return ":" + L.identifierPrefix + "S" + a.toString(32) + ":";
}
function Fa(a) {
    if (null !== a && "object" === typeof a || "function" === typeof a) {
        if ("function" === typeof a.then) {
            var b = N;
            N += 1;
            null === O && (O = []);
            return za(O, a, b);
        }
        if (a.$$typeof === ka) return a._currentValue;
    }
    throw Error("An unsupported type was passed to use(): " + String(a));
}
function Q() {
    return new AbortController().signal;
}
function Ha() {
    if (R) return R;
    if (f) {
        var a = ba.getStore();
        if (a) return a;
    }
    return new Map();
}
var Ia = {
    getCacheSignal: function() {
        var a = Ha(), b = a.get(Q);
        void 0 === b && (b = Q(), a.set(Q, b));
        return b;
    },
    getCacheForType: function(a) {
        var b = Ha(), c = b.get(a);
        void 0 === c && (c = a(), b.set(a, c));
        return c;
    }
}, R = null, S = aa.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED, T = S.ContextRegistry, Ja = S.ReactCurrentDispatcher, Ka = S.ReactCurrentCache;
function La(a) {
    console.error(a);
}
function Ma(a, b, c, d, e) {
    if (null !== Ka.current && Ka.current !== Ia) throw Error("Currently React only supports one RSC renderer at a time.");
    Ka.current = Ia;
    var g = new Set(), h = [], k = {
        status: 0,
        fatalError: null,
        destination: null,
        bundlerConfig: b,
        cache: new Map(),
        nextChunkId: 0,
        pendingChunks: 0,
        abortableTasks: g,
        pingedTasks: h,
        completedImportChunks: [],
        completedJSONChunks: [],
        completedErrorChunks: [],
        writtenSymbols: new Map(),
        writtenClientReferences: new Map(),
        writtenServerReferences: new Map(),
        writtenProviders: new Map(),
        identifierPrefix: e || "",
        identifierCount: 1,
        onError: void 0 === c ? La : c,
        toJSON: function(l, v) {
            return Na(k, this, l, v);
        }
    };
    k.pendingChunks++;
    b = Oa(d);
    a = Pa(k, a, b, g);
    h.push(a);
    return k;
}
var Qa = {};
function Ra(a, b) {
    a.pendingChunks++;
    var c = Pa(a, null, G, a.abortableTasks);
    switch(b.status){
        case "fulfilled":
            return c.model = b.value, Sa(a, c), c.id;
        case "rejected":
            var d = U(a, b.reason);
            V(a, c.id, d);
            return c.id;
        default:
            "string" !== typeof b.status && (b.status = "pending", b.then(function(e) {
                "pending" === b.status && (b.status = "fulfilled", b.value = e);
            }, function(e) {
                "pending" === b.status && (b.status = "rejected", b.reason = e);
            }));
    }
    b.then(function(e) {
        c.model = e;
        Sa(a, c);
    }, function(e) {
        c.status = 4;
        e = U(a, e);
        V(a, c.id, e);
        null !== a.destination && W(a, a.destination);
    });
    return c.id;
}
function Ta(a) {
    if ("fulfilled" === a.status) return a.value;
    if ("rejected" === a.status) throw a.reason;
    throw a;
}
function Ua(a) {
    switch(a.status){
        case "fulfilled":
        case "rejected":
            break;
        default:
            "string" !== typeof a.status && (a.status = "pending", a.then(function(b) {
                "pending" === a.status && (a.status = "fulfilled", a.value = b);
            }, function(b) {
                "pending" === a.status && (a.status = "rejected", a.reason = b);
            }));
    }
    return {
        $$typeof: z,
        _payload: a,
        _init: Ta
    };
}
function X(a, b, c, d, e, g) {
    if (null !== d && void 0 !== d) throw Error("Refs cannot be used in Server Components, nor passed to Client Components.");
    if ("function" === typeof b) {
        if (b.$$typeof === w) return [
            y,
            b,
            c,
            e
        ];
        N = 0;
        O = g;
        e = b(e);
        return "object" === typeof e && null !== e && "function" === typeof e.then ? "fulfilled" === e.status ? e.value : Ua(e) : e;
    }
    if ("string" === typeof b) return [
        y,
        b,
        c,
        e
    ];
    if ("symbol" === typeof b) return b === fa ? e.children : [
        y,
        b,
        c,
        e
    ];
    if (null != b && "object" === typeof b) {
        if (b.$$typeof === w) return [
            y,
            b,
            c,
            e
        ];
        switch(b.$$typeof){
            case z:
                var h = b._init;
                b = h(b._payload);
                return X(a, b, c, d, e, g);
            case la:
                return a = b.render, N = 0, O = g, a(e, void 0);
            case oa:
                return X(a, b.type, c, d, e, g);
            case ja:
                return xa(b._context, e.value), [
                    y,
                    b,
                    c,
                    {
                        value: e.value,
                        children: e.children,
                        __pop: Qa
                    }
                ];
        }
    }
    throw Error("Unsupported Server Component type: " + Va(b));
}
function Sa(a, b) {
    var c = a.pingedTasks;
    c.push(b);
    1 === c.length && setTimeout(function() {
        return Wa(a);
    }, 0);
}
function Pa(a, b, c, d) {
    var e = {
        id: a.nextChunkId++,
        status: 0,
        model: b,
        context: c,
        ping: function() {
            return Sa(a, e);
        },
        thenableState: null
    };
    d.add(e);
    return e;
}
function Xa(a, b, c, d) {
    var e = d.$$async ? d.$$id + "#async" : d.$$id, g = a.writtenClientReferences, h = g.get(e);
    if (void 0 !== h) return b[0] === y && "1" === c ? "$L" + h.toString(16) : "$" + h.toString(16);
    try {
        var k = a.bundlerConfig[d.$$id];
        var l = d.$$async ? {
            id: k.id,
            chunks: k.chunks,
            name: k.name,
            async: !0
        } : k;
        a.pendingChunks++;
        var v = a.nextChunkId++, ha = t(l), x = v.toString(16) + ":I" + ha + "\n";
        var M = q.encode(x);
        a.completedImportChunks.push(M);
        g.set(e, v);
        return b[0] === y && "1" === c ? "$L" + v.toString(16) : "$" + v.toString(16);
    } catch (ia) {
        return a.pendingChunks++, b = a.nextChunkId++, c = U(a, ia), V(a, b, c), "$" + b.toString(16);
    }
}
function Ya(a) {
    return Object.prototype.toString.call(a).replace(/^\[object (.*)\]$/, function(b, c) {
        return c;
    });
}
function Va(a) {
    switch(typeof a){
        case "string":
            return JSON.stringify(10 >= a.length ? a : a.substr(0, 10) + "...");
        case "object":
            if (E(a)) return "[...]";
            a = Ya(a);
            return "Object" === a ? "{...}" : a;
        case "function":
            return "function";
        default:
            return String(a);
    }
}
function Y(a) {
    if ("string" === typeof a) return a;
    switch(a){
        case ma:
            return "Suspense";
        case na:
            return "SuspenseList";
    }
    if ("object" === typeof a) switch(a.$$typeof){
        case la:
            return Y(a.render);
        case oa:
            return Y(a.type);
        case z:
            var b = a._payload;
            a = a._init;
            try {
                return Y(a(b));
            } catch (c) {}
    }
    return "";
}
function Z(a, b) {
    var c = Ya(a);
    if ("Object" !== c && "Array" !== c) return c;
    c = -1;
    var d = 0;
    if (E(a)) {
        var e = "[";
        for(var g = 0; g < a.length; g++){
            0 < g && (e += ", ");
            var h = a[g];
            h = "object" === typeof h && null !== h ? Z(h) : Va(h);
            "" + g === b ? (c = e.length, d = h.length, e += h) : e = 10 > h.length && 40 > e.length + h.length ? e + h : e + "...";
        }
        e += "]";
    } else if (a.$$typeof === y) e = "<" + Y(a.type) + "/>";
    else {
        e = "{";
        g = Object.keys(a);
        for(h = 0; h < g.length; h++){
            0 < h && (e += ", ");
            var k = g[h], l = JSON.stringify(k);
            e += ('"' + k + '"' === l ? k : l) + ": ";
            l = a[k];
            l = "object" === typeof l && null !== l ? Z(l) : Va(l);
            k === b ? (c = e.length, d = l.length, e += l) : e = 10 > l.length && 40 > e.length + l.length ? e + l : e + "...";
        }
        e += "}";
    }
    return void 0 === b ? e : -1 < c && 0 < d ? (a = " ".repeat(c) + "^".repeat(d), "\n  " + e + "\n  " + a) : "\n  " + e;
}
function Na(a, b, c, d) {
    switch(d){
        case y:
            return "$";
    }
    for(; "object" === typeof d && null !== d && (d.$$typeof === y || d.$$typeof === z);)try {
        switch(d.$$typeof){
            case y:
                var e = d;
                d = X(a, e.type, e.key, e.ref, e.props, null);
                break;
            case z:
                var g = d._init;
                d = g(d._payload);
        }
    } catch (h) {
        c = h === J ? Aa() : h;
        if ("object" === typeof c && null !== c && "function" === typeof c.then) return a.pendingChunks++, a = Pa(a, d, G, a.abortableTasks), d = a.ping, c.then(d, d), a.thenableState = Ba(), "$L" + a.id.toString(16);
        a.pendingChunks++;
        d = a.nextChunkId++;
        c = U(a, c);
        V(a, d, c);
        return "$L" + d.toString(16);
    }
    if (null === d) return null;
    if ("object" === typeof d) {
        if (d.$$typeof === w) return Xa(a, b, c, d);
        if ("function" === typeof d.then) return "$@" + Ra(a, d).toString(16);
        if (d.$$typeof === ja) return d = d._context._globalName, b = a.writtenProviders, c = b.get(c), void 0 === c && (a.pendingChunks++, c = a.nextChunkId++, b.set(d, c), d = u(a, c, "$P" + d), a.completedJSONChunks.push(d)), "$" + c.toString(16);
        if (d === Qa) {
            a = G;
            if (null === a) throw Error("Tried to pop a Context at the root of the app. This is a bug in React.");
            d = a.parentValue;
            a.context._currentValue = d === pa ? a.context._defaultValue : d;
            G = a.parent;
            return;
        }
        return !E(d) && (null === d || "object" !== typeof d ? a = null : (a = ra && d[ra] || d["@@iterator"], a = "function" === typeof a ? a : null), a) ? Array.from(d) : d;
    }
    if ("string" === typeof d) return a = "$" === d[0] ? "$" + d : d, a;
    if ("boolean" === typeof d || "number" === typeof d || "undefined" === typeof d) return d;
    if ("function" === typeof d) {
        if (d.$$typeof === w) return Xa(a, b, c, d);
        if (d.$$typeof === ea) return c = a.writtenServerReferences, b = c.get(d), void 0 !== b ? a = "$F" + b.toString(16) : (b = d.$$bound, e = {
            id: d.$$id,
            bound: b ? Promise.resolve(b) : null
        }, a.pendingChunks++, b = a.nextChunkId++, e = da(a, b, e), a.completedJSONChunks.push(e), c.set(d, b), a = "$F" + b.toString(16)), a;
        if (/^on[A-Z]/.test(c)) throw Error("Event handlers cannot be passed to Client Component props." + Z(b, c) + "\nIf you need interactivity, consider converting part of this to a Client Component.");
        throw Error('Functions cannot be passed directly to Client Components unless you explicitly expose it by marking it with "use server".' + Z(b, c));
    }
    if ("symbol" === typeof d) {
        e = a.writtenSymbols;
        g = e.get(d);
        if (void 0 !== g) return "$" + g.toString(16);
        g = d.description;
        if (Symbol.for(g) !== d) throw Error("Only global symbols received from Symbol.for(...) can be passed to Client Components. The symbol Symbol.for(" + (d.description + ") cannot be found among global symbols.") + Z(b, c));
        a.pendingChunks++;
        c = a.nextChunkId++;
        b = u(a, c, "$S" + g);
        a.completedImportChunks.push(b);
        e.set(d, c);
        return "$" + c.toString(16);
    }
    if ("bigint" === typeof d) throw Error("BigInt (" + d + ") is not yet supported in Client Component props." + Z(b, c));
    throw Error("Type " + typeof d + " is not supported in Client Component props." + Z(b, c));
}
function U(a, b) {
    a = a.onError;
    b = a(b);
    if (null != b && "string" !== typeof b) throw Error('onError returned something with a type other than "string". onError should return a string and may return null or undefined but must not return anything else. It received something of type "' + typeof b + '" instead');
    return b || "";
}
function Za(a, b) {
    null !== a.destination ? (a.status = 2, ca(a.destination, b)) : (a.status = 1, a.fatalError = b);
}
function V(a, b, c) {
    c = {
        digest: c
    };
    b = b.toString(16) + ":E" + t(c) + "\n";
    b = q.encode(b);
    a.completedErrorChunks.push(b);
}
function Wa(a) {
    var b = Ja.current, c = R;
    Ja.current = Ga;
    R = a.cache;
    L = a;
    try {
        var d = a.pingedTasks;
        a.pingedTasks = [];
        for(var e = 0; e < d.length; e++){
            var g = d[e];
            var h = a;
            if (0 === g.status) {
                I(g.context);
                try {
                    var k = g.model;
                    if ("object" === typeof k && null !== k && k.$$typeof === y) {
                        var l = k, v = g.thenableState;
                        g.model = k;
                        k = X(h, l.type, l.key, l.ref, l.props, v);
                        for(g.thenableState = null; "object" === typeof k && null !== k && k.$$typeof === y;)l = k, g.model = k, k = X(h, l.type, l.key, l.ref, l.props, null);
                    }
                    var ha = da(h, g.id, k);
                    h.completedJSONChunks.push(ha);
                    h.abortableTasks.delete(g);
                    g.status = 1;
                } catch (F) {
                    var x = F === J ? Aa() : F;
                    if ("object" === typeof x && null !== x && "function" === typeof x.then) {
                        var M = g.ping;
                        x.then(M, M);
                        g.thenableState = Ba();
                    } else {
                        h.abortableTasks.delete(g);
                        g.status = 4;
                        var ia = U(h, x);
                        V(h, g.id, ia);
                    }
                }
            }
        }
        null !== a.destination && W(a, a.destination);
    } catch (F) {
        U(a, F), Za(a, F);
    } finally{
        Ja.current = b, R = c, L = null;
    }
}
function W(a, b) {
    m = new Uint8Array(512);
    n = 0;
    try {
        for(var c = a.completedImportChunks, d = 0; d < c.length; d++)a.pendingChunks--, p(b, c[d]);
        c.splice(0, d);
        var e = a.completedJSONChunks;
        for(d = 0; d < e.length; d++)a.pendingChunks--, p(b, e[d]);
        e.splice(0, d);
        var g = a.completedErrorChunks;
        for(d = 0; d < g.length; d++)a.pendingChunks--, p(b, g[d]);
        g.splice(0, d);
    } finally{
        m && 0 < n && (b.enqueue(new Uint8Array(m.buffer, 0, n)), m = null, n = 0);
    }
    0 === a.pendingChunks && b.close();
}
function $a(a) {
    f ? setTimeout(function() {
        return ba.run(a.cache, Wa, a);
    }, 0) : setTimeout(function() {
        return Wa(a);
    }, 0);
}
function ab(a, b) {
    try {
        var c = a.abortableTasks;
        if (0 < c.size) {
            var d = U(a, void 0 === b ? Error("The render was aborted by the server without a reason.") : b);
            a.pendingChunks++;
            var e = a.nextChunkId++;
            V(a, e, d);
            c.forEach(function(g) {
                g.status = 3;
                var h = "$" + e.toString(16);
                g = u(a, g.id, h);
                a.completedErrorChunks.push(g);
            });
            c.clear();
        }
        null !== a.destination && W(a, a.destination);
    } catch (g) {
        U(a, g), Za(a, g);
    }
}
function Oa(a) {
    if (a) {
        var b = G;
        I(null);
        for(var c = 0; c < a.length; c++){
            var d = a[c], e = d[0];
            d = d[1];
            T[e] || (T[e] = aa.createServerContext(e, pa));
            xa(T[e], d);
        }
        a = G;
        I(b);
        return a;
    }
    return null;
}
exports.renderToReadableStream = function(a, b, c) {
    var d = Ma(a, b, c ? c.onError : void 0, c ? c.context : void 0, c ? c.identifierPrefix : void 0);
    if (c && c.signal) {
        var e = c.signal;
        if (e.aborted) ab(d, e.reason);
        else {
            var g = function() {
                ab(d, e.reason);
                e.removeEventListener("abort", g);
            };
            e.addEventListener("abort", g);
        }
    }
    return new ReadableStream({
        type: "bytes",
        start: function() {
            $a(d);
        },
        pull: function(h) {
            if (1 === d.status) d.status = 2, ca(h, d.fatalError);
            else if (2 !== d.status && null === d.destination) {
                d.destination = h;
                try {
                    W(d, h);
                } catch (k) {
                    U(d, k), Za(d, k);
                }
            }
        },
        cancel: function() {}
    }, {
        highWaterMark: 0
    });
};


/***/ }),

/***/ 4491:
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

"use strict";

if (true) {
    module.exports = __webpack_require__(1395);
} else {}


/***/ }),

/***/ 9877:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {

"use strict";
var __webpack_unused_export__;
/**
 * @license React
 * react-jsx-runtime.production.min.js
 *
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */ 
var f = __webpack_require__(3229), k = Symbol.for("react.element"), l = Symbol.for("react.fragment"), m = Object.prototype.hasOwnProperty, n = f.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED.ReactCurrentOwner, p = {
    key: !0,
    ref: !0,
    __self: !0,
    __source: !0
};
function q(c, a, g) {
    var b, d = {}, e = null, h = null;
    void 0 !== g && (e = "" + g);
    void 0 !== a.key && (e = "" + a.key);
    void 0 !== a.ref && (h = a.ref);
    for(b in a)m.call(a, b) && !p.hasOwnProperty(b) && (d[b] = a[b]);
    if (c && c.defaultProps) for(b in a = c.defaultProps, a)void 0 === d[b] && (d[b] = a[b]);
    return {
        $$typeof: k,
        type: c,
        key: e,
        ref: h,
        props: d,
        _owner: n.current
    };
}
__webpack_unused_export__ = l;
exports.jsx = q;
exports.jsxs = q;


/***/ }),

/***/ 8113:
/***/ ((__unused_webpack_module, exports) => {

"use strict";
/**
 * @license React
 * react.shared-subset.production.min.js
 *
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */ 
var m = Object.assign, n = {
    current: null
};
function p() {
    return new Map();
}
if ("function" === typeof fetch) {
    var q = fetch, r = function(a, b) {
        var d = n.current;
        if (!d || b && b.signal && b.signal !== d.getCacheSignal()) return q(a, b);
        if ("string" !== typeof a || b) {
            var c = new Request(a, b);
            if ("GET" !== c.method && "HEAD" !== c.method || c.keepalive) return q(a, b);
            var e = JSON.stringify([
                c.method,
                Array.from(c.headers.entries()),
                c.mode,
                c.redirect,
                c.credentials,
                c.referrer,
                c.referrerPolicy,
                c.integrity
            ]);
            c = c.url;
        } else e = '["GET",[],null,"follow",null,null,null,null]', c = a;
        var f = d.getCacheForType(p);
        d = f.get(c);
        if (void 0 === d) a = q(a, b), f.set(c, [
            e,
            a
        ]);
        else {
            c = 0;
            for(f = d.length; c < f; c += 2){
                var h = d[c + 1];
                if (d[c] === e) return a = h, a.then(function(g) {
                    return g.clone();
                });
            }
            a = q(a, b);
            d.push(e, a);
        }
        return a.then(function(g) {
            return g.clone();
        });
    };
    m(r, q);
    try {
        fetch = r;
    } catch (a) {
        try {
            globalThis.fetch = r;
        } catch (b) {
            console.warn("React was unable to patch the fetch() function in this environment. Suspensey APIs might not work correctly as a result.");
        }
    }
}
var t = Symbol.for("react.element"), u = Symbol.for("react.portal"), v = Symbol.for("react.fragment"), w = Symbol.for("react.strict_mode"), x = Symbol.for("react.profiler"), y = Symbol.for("react.provider"), z = Symbol.for("react.server_context"), A = Symbol.for("react.forward_ref"), B = Symbol.for("react.suspense"), C = Symbol.for("react.memo"), aa = Symbol.for("react.lazy"), D = Symbol.for("react.default_value"), E = Symbol.iterator;
function ba(a) {
    if (null === a || "object" !== typeof a) return null;
    a = E && a[E] || a["@@iterator"];
    return "function" === typeof a ? a : null;
}
function F(a) {
    for(var b = "https://reactjs.org/docs/error-decoder.html?invariant=" + a, d = 1; d < arguments.length; d++)b += "&args[]=" + encodeURIComponent(arguments[d]);
    return "Minified React error #" + a + "; visit " + b + " for the full message or use the non-minified dev environment for full errors and additional helpful warnings.";
}
var G = {
    isMounted: function() {
        return !1;
    },
    enqueueForceUpdate: function() {},
    enqueueReplaceState: function() {},
    enqueueSetState: function() {}
}, H = {};
function I(a, b, d) {
    this.props = a;
    this.context = b;
    this.refs = H;
    this.updater = d || G;
}
I.prototype.isReactComponent = {};
I.prototype.setState = function(a, b) {
    if ("object" !== typeof a && "function" !== typeof a && null != a) throw Error(F(85));
    this.updater.enqueueSetState(this, a, b, "setState");
};
I.prototype.forceUpdate = function(a) {
    this.updater.enqueueForceUpdate(this, a, "forceUpdate");
};
function J() {}
J.prototype = I.prototype;
function K(a, b, d) {
    this.props = a;
    this.context = b;
    this.refs = H;
    this.updater = d || G;
}
var L = K.prototype = new J();
L.constructor = K;
m(L, I.prototype);
L.isPureReactComponent = !0;
var M = Array.isArray, N = Object.prototype.hasOwnProperty, O = {
    current: null
}, P = {
    key: !0,
    ref: !0,
    __self: !0,
    __source: !0
};
function ca(a, b) {
    return {
        $$typeof: t,
        type: a.type,
        key: b,
        ref: a.ref,
        props: a.props,
        _owner: a._owner
    };
}
function Q(a) {
    return "object" === typeof a && null !== a && a.$$typeof === t;
}
function escape(a) {
    var b = {
        "=": "=0",
        ":": "=2"
    };
    return "$" + a.replace(/[=:]/g, function(d) {
        return b[d];
    });
}
var R = /\/+/g;
function S(a, b) {
    return "object" === typeof a && null !== a && null != a.key ? escape("" + a.key) : b.toString(36);
}
function T(a, b, d, c, e) {
    var f = typeof a;
    if ("undefined" === f || "boolean" === f) a = null;
    var h = !1;
    if (null === a) h = !0;
    else switch(f){
        case "string":
        case "number":
            h = !0;
            break;
        case "object":
            switch(a.$$typeof){
                case t:
                case u:
                    h = !0;
            }
    }
    if (h) return h = a, e = e(h), a = "" === c ? "." + S(h, 0) : c, M(e) ? (d = "", null != a && (d = a.replace(R, "$&/") + "/"), T(e, b, d, "", function(l) {
        return l;
    })) : null != e && (Q(e) && (e = ca(e, d + (!e.key || h && h.key === e.key ? "" : ("" + e.key).replace(R, "$&/") + "/") + a)), b.push(e)), 1;
    h = 0;
    c = "" === c ? "." : c + ":";
    if (M(a)) for(var g = 0; g < a.length; g++){
        f = a[g];
        var k = c + S(f, g);
        h += T(f, b, d, k, e);
    }
    else if (k = ba(a), "function" === typeof k) for(a = k.call(a), g = 0; !(f = a.next()).done;)f = f.value, k = c + S(f, g++), h += T(f, b, d, k, e);
    else if ("object" === f) throw b = String(a), Error(F(31, "[object Object]" === b ? "object with keys {" + Object.keys(a).join(", ") + "}" : b));
    return h;
}
function U(a, b, d) {
    if (null == a) return a;
    var c = [], e = 0;
    T(a, c, "", "", function(f) {
        return b.call(d, f, e++);
    });
    return c;
}
function da(a) {
    if (-1 === a._status) {
        var b = a._result;
        b = b();
        b.then(function(d) {
            if (0 === a._status || -1 === a._status) a._status = 1, a._result = d;
        }, function(d) {
            if (0 === a._status || -1 === a._status) a._status = 2, a._result = d;
        });
        -1 === a._status && (a._status = 0, a._result = b);
    }
    if (1 === a._status) return a._result.default;
    throw a._result;
}
function ea() {
    return new WeakMap();
}
function V() {
    return {
        s: 0,
        v: void 0,
        o: null,
        p: null
    };
}
var W = {
    current: null
}, X = {
    transition: null
}, Y = {
    ReactCurrentDispatcher: W,
    ReactCurrentCache: n,
    ReactCurrentBatchConfig: X,
    ReactCurrentOwner: O,
    ContextRegistry: {}
}, Z = Y.ContextRegistry;
exports.Children = {
    map: U,
    forEach: function(a, b, d) {
        U(a, function() {
            b.apply(this, arguments);
        }, d);
    },
    count: function(a) {
        var b = 0;
        U(a, function() {
            b++;
        });
        return b;
    },
    toArray: function(a) {
        return U(a, function(b) {
            return b;
        }) || [];
    },
    only: function(a) {
        if (!Q(a)) throw Error(F(143));
        return a;
    }
};
exports.Fragment = v;
exports.Profiler = x;
exports.StrictMode = w;
exports.Suspense = B;
exports.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED = Y;
exports.cache = function(a) {
    return function() {
        var b = n.current;
        if (!b) return a.apply(null, arguments);
        var d = b.getCacheForType(ea);
        b = d.get(a);
        void 0 === b && (b = V(), d.set(a, b));
        d = 0;
        for(var c = arguments.length; d < c; d++){
            var e = arguments[d];
            if ("function" === typeof e || "object" === typeof e && null !== e) {
                var f = b.o;
                null === f && (b.o = f = new WeakMap());
                b = f.get(e);
                void 0 === b && (b = V(), f.set(e, b));
            } else f = b.p, null === f && (b.p = f = new Map()), b = f.get(e), void 0 === b && (b = V(), f.set(e, b));
        }
        if (1 === b.s) return b.v;
        if (2 === b.s) throw b.v;
        try {
            var h = a.apply(null, arguments);
            d = b;
            d.s = 1;
            return d.v = h;
        } catch (g) {
            throw h = b, h.s = 2, h.v = g, g;
        }
    };
};
exports.cloneElement = function(a, b, d) {
    if (null === a || void 0 === a) throw Error(F(267, a));
    var c = m({}, a.props), e = a.key, f = a.ref, h = a._owner;
    if (null != b) {
        void 0 !== b.ref && (f = b.ref, h = O.current);
        void 0 !== b.key && (e = "" + b.key);
        if (a.type && a.type.defaultProps) var g = a.type.defaultProps;
        for(k in b)N.call(b, k) && !P.hasOwnProperty(k) && (c[k] = void 0 === b[k] && void 0 !== g ? g[k] : b[k]);
    }
    var k = arguments.length - 2;
    if (1 === k) c.children = d;
    else if (1 < k) {
        g = Array(k);
        for(var l = 0; l < k; l++)g[l] = arguments[l + 2];
        c.children = g;
    }
    return {
        $$typeof: t,
        type: a.type,
        key: e,
        ref: f,
        props: c,
        _owner: h
    };
};
exports.createElement = function(a, b, d) {
    var c, e = {}, f = null, h = null;
    if (null != b) for(c in void 0 !== b.ref && (h = b.ref), void 0 !== b.key && (f = "" + b.key), b)N.call(b, c) && !P.hasOwnProperty(c) && (e[c] = b[c]);
    var g = arguments.length - 2;
    if (1 === g) e.children = d;
    else if (1 < g) {
        for(var k = Array(g), l = 0; l < g; l++)k[l] = arguments[l + 2];
        e.children = k;
    }
    if (a && a.defaultProps) for(c in g = a.defaultProps, g)void 0 === e[c] && (e[c] = g[c]);
    return {
        $$typeof: t,
        type: a,
        key: f,
        ref: h,
        props: e,
        _owner: O.current
    };
};
exports.createRef = function() {
    return {
        current: null
    };
};
exports.createServerContext = function(a, b) {
    var d = !0;
    if (!Z[a]) {
        d = !1;
        var c = {
            $$typeof: z,
            _currentValue: b,
            _currentValue2: b,
            _defaultValue: b,
            _threadCount: 0,
            Provider: null,
            Consumer: null,
            _globalName: a
        };
        c.Provider = {
            $$typeof: y,
            _context: c
        };
        Z[a] = c;
    }
    c = Z[a];
    if (c._defaultValue === D) c._defaultValue = b, c._currentValue === D && (c._currentValue = b), c._currentValue2 === D && (c._currentValue2 = b);
    else if (d) throw Error(F(429, a));
    return c;
};
exports.forwardRef = function(a) {
    return {
        $$typeof: A,
        render: a
    };
};
exports.isValidElement = Q;
exports.lazy = function(a) {
    return {
        $$typeof: aa,
        _payload: {
            _status: -1,
            _result: a
        },
        _init: da
    };
};
exports.memo = function(a, b) {
    return {
        $$typeof: C,
        type: a,
        compare: void 0 === b ? null : b
    };
};
exports.startTransition = function(a) {
    var b = X.transition;
    X.transition = {};
    try {
        a();
    } finally{
        X.transition = b;
    }
};
exports.use = function(a) {
    return W.current.use(a);
};
exports.useCallback = function(a, b) {
    return W.current.useCallback(a, b);
};
exports.useContext = function(a) {
    return W.current.useContext(a);
};
exports.useDebugValue = function() {};
exports.useId = function() {
    return W.current.useId();
};
exports.useMemo = function(a, b) {
    return W.current.useMemo(a, b);
};
exports.version = "18.3.0-next-3706edb81-20230308";


/***/ }),

/***/ 715:
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

"use strict";

if (true) {
    module.exports = __webpack_require__(9877);
} else {}


/***/ }),

/***/ 3229:
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

"use strict";

if (true) {
    module.exports = __webpack_require__(8113);
} else {}


/***/ }),

/***/ 1621:
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

module.exports = __webpack_require__(3849)


/***/ }),

/***/ 9907:
/***/ ((__unused_webpack___webpack_module__, __webpack_exports__, __webpack_require__) => {

"use strict";

// EXPORTS
__webpack_require__.d(__webpack_exports__, {
  "createClient": () => (/* binding */ createClient)
});

// UNUSED EXPORTS: FunctionRegion, FunctionsError, FunctionsFetchError, FunctionsHttpError, FunctionsRelayError, PostgrestError, REALTIME_CHANNEL_STATES, REALTIME_LISTEN_TYPES, REALTIME_POSTGRES_CHANGES_LISTEN_EVENT, REALTIME_PRESENCE_LISTEN_EVENTS, REALTIME_SUBSCRIBE_STATES, RealtimeChannel, RealtimeClient, RealtimePresence, SupabaseClient, WebSocketFactory, __esModule

// EXTERNAL MODULE: ./node_modules/@supabase/functions-js/dist/main/index.js
var main = __webpack_require__(6927);
;// CONCATENATED MODULE: ./node_modules/@supabase/postgrest-js/dist/index.mjs
//#region src/PostgrestError.ts
/**
* Error format
*
* {@link https://postgrest.org/en/stable/api.html?highlight=options#errors-and-http-status-codes}
*/
var PostgrestError = class extends Error {
	/**
	* @example
	* ```ts
	* import PostgrestError from '@supabase/postgrest-js'
	*
	* throw new PostgrestError({
	*   message: 'Row level security prevented the request',
	*   details: 'RLS denied the insert',
	*   hint: 'Check your policies',
	*   code: 'PGRST301',
	* })
	* ```
	*/
	constructor(context) {
		super(context.message);
		this.name = "PostgrestError";
		this.details = context.details;
		this.hint = context.hint;
		this.code = context.code;
	}
};

//#endregion
//#region src/PostgrestBuilder.ts
var PostgrestBuilder = class {
	/**
	* Creates a builder configured for a specific PostgREST request.
	*
	* @example
	* ```ts
	* import PostgrestQueryBuilder from '@supabase/postgrest-js'
	*
	* const builder = new PostgrestQueryBuilder(
	*   new URL('https://xyzcompany.supabase.co/rest/v1/users'),
	*   { headers: new Headers({ apikey: 'public-anon-key' }) }
	* )
	* ```
	*/
	constructor(builder) {
		var _builder$shouldThrowO, _builder$isMaybeSingl, _builder$urlLengthLim;
		this.shouldThrowOnError = false;
		this.method = builder.method;
		this.url = builder.url;
		this.headers = new Headers(builder.headers);
		this.schema = builder.schema;
		this.body = builder.body;
		this.shouldThrowOnError = (_builder$shouldThrowO = builder.shouldThrowOnError) !== null && _builder$shouldThrowO !== void 0 ? _builder$shouldThrowO : false;
		this.signal = builder.signal;
		this.isMaybeSingle = (_builder$isMaybeSingl = builder.isMaybeSingle) !== null && _builder$isMaybeSingl !== void 0 ? _builder$isMaybeSingl : false;
		this.urlLengthLimit = (_builder$urlLengthLim = builder.urlLengthLimit) !== null && _builder$urlLengthLim !== void 0 ? _builder$urlLengthLim : 8e3;
		if (builder.fetch) this.fetch = builder.fetch;
		else this.fetch = fetch;
	}
	/**
	* If there's an error with the query, throwOnError will reject the promise by
	* throwing the error instead of returning it as part of a successful response.
	*
	* {@link https://github.com/supabase/supabase-js/issues/92}
	*/
	throwOnError() {
		this.shouldThrowOnError = true;
		return this;
	}
	/**
	* Set an HTTP header for the request.
	*/
	setHeader(name, value) {
		this.headers = new Headers(this.headers);
		this.headers.set(name, value);
		return this;
	}
	then(onfulfilled, onrejected) {
		var _this = this;
		if (this.schema === void 0) {} else if (["GET", "HEAD"].includes(this.method)) this.headers.set("Accept-Profile", this.schema);
		else this.headers.set("Content-Profile", this.schema);
		if (this.method !== "GET" && this.method !== "HEAD") this.headers.set("Content-Type", "application/json");
		const _fetch = this.fetch;
		let res = _fetch(this.url.toString(), {
			method: this.method,
			headers: this.headers,
			body: JSON.stringify(this.body),
			signal: this.signal
		}).then(async (res$1) => {
			let error = null;
			let data = null;
			let count = null;
			let status = res$1.status;
			let statusText = res$1.statusText;
			if (res$1.ok) {
				var _this$headers$get2, _res$headers$get;
				if (_this.method !== "HEAD") {
					var _this$headers$get;
					const body = await res$1.text();
					if (body === "") {} else if (_this.headers.get("Accept") === "text/csv") data = body;
					else if (_this.headers.get("Accept") && ((_this$headers$get = _this.headers.get("Accept")) === null || _this$headers$get === void 0 ? void 0 : _this$headers$get.includes("application/vnd.pgrst.plan+text"))) data = body;
					else data = JSON.parse(body);
				}
				const countHeader = (_this$headers$get2 = _this.headers.get("Prefer")) === null || _this$headers$get2 === void 0 ? void 0 : _this$headers$get2.match(/count=(exact|planned|estimated)/);
				const contentRange = (_res$headers$get = res$1.headers.get("content-range")) === null || _res$headers$get === void 0 ? void 0 : _res$headers$get.split("/");
				if (countHeader && contentRange && contentRange.length > 1) count = parseInt(contentRange[1]);
				if (_this.isMaybeSingle && _this.method === "GET" && Array.isArray(data)) if (data.length > 1) {
					error = {
						code: "PGRST116",
						details: `Results contain ${data.length} rows, application/vnd.pgrst.object+json requires 1 row`,
						hint: null,
						message: "JSON object requested, multiple (or no) rows returned"
					};
					data = null;
					count = null;
					status = 406;
					statusText = "Not Acceptable";
				} else if (data.length === 1) data = data[0];
				else data = null;
			} else {
				var _error$details;
				const body = await res$1.text();
				try {
					error = JSON.parse(body);
					if (Array.isArray(error) && res$1.status === 404) {
						data = [];
						error = null;
						status = 200;
						statusText = "OK";
					}
				} catch (_unused) {
					if (res$1.status === 404 && body === "") {
						status = 204;
						statusText = "No Content";
					} else error = { message: body };
				}
				if (error && _this.isMaybeSingle && (error === null || error === void 0 || (_error$details = error.details) === null || _error$details === void 0 ? void 0 : _error$details.includes("0 rows"))) {
					error = null;
					status = 200;
					statusText = "OK";
				}
				if (error && _this.shouldThrowOnError) throw new PostgrestError(error);
			}
			return {
				error,
				data,
				count,
				status,
				statusText
			};
		});
		if (!this.shouldThrowOnError) res = res.catch((fetchError) => {
			var _fetchError$name2;
			let errorDetails = "";
			let hint = "";
			let code = "";
			const cause = fetchError === null || fetchError === void 0 ? void 0 : fetchError.cause;
			if (cause) {
				var _cause$message, _cause$code, _fetchError$name, _cause$name;
				const causeMessage = (_cause$message = cause === null || cause === void 0 ? void 0 : cause.message) !== null && _cause$message !== void 0 ? _cause$message : "";
				const causeCode = (_cause$code = cause === null || cause === void 0 ? void 0 : cause.code) !== null && _cause$code !== void 0 ? _cause$code : "";
				errorDetails = `${(_fetchError$name = fetchError === null || fetchError === void 0 ? void 0 : fetchError.name) !== null && _fetchError$name !== void 0 ? _fetchError$name : "FetchError"}: ${fetchError === null || fetchError === void 0 ? void 0 : fetchError.message}`;
				errorDetails += `\n\nCaused by: ${(_cause$name = cause === null || cause === void 0 ? void 0 : cause.name) !== null && _cause$name !== void 0 ? _cause$name : "Error"}: ${causeMessage}`;
				if (causeCode) errorDetails += ` (${causeCode})`;
				if (cause === null || cause === void 0 ? void 0 : cause.stack) errorDetails += `\n${cause.stack}`;
			} else {
				var _fetchError$stack;
				errorDetails = (_fetchError$stack = fetchError === null || fetchError === void 0 ? void 0 : fetchError.stack) !== null && _fetchError$stack !== void 0 ? _fetchError$stack : "";
			}
			const urlLength = this.url.toString().length;
			if ((fetchError === null || fetchError === void 0 ? void 0 : fetchError.name) === "AbortError" || (fetchError === null || fetchError === void 0 ? void 0 : fetchError.code) === "ABORT_ERR") {
				code = "";
				hint = "Request was aborted (timeout or manual cancellation)";
				if (urlLength > this.urlLengthLimit) hint += `. Note: Your request URL is ${urlLength} characters, which may exceed server limits. If selecting many fields, consider using views. If filtering with large arrays (e.g., .in('id', [many IDs])), consider using an RPC function to pass values server-side.`;
			} else if ((cause === null || cause === void 0 ? void 0 : cause.name) === "HeadersOverflowError" || (cause === null || cause === void 0 ? void 0 : cause.code) === "UND_ERR_HEADERS_OVERFLOW") {
				code = "";
				hint = "HTTP headers exceeded server limits (typically 16KB)";
				if (urlLength > this.urlLengthLimit) hint += `. Your request URL is ${urlLength} characters. If selecting many fields, consider using views. If filtering with large arrays (e.g., .in('id', [200+ IDs])), consider using an RPC function instead.`;
			}
			return {
				error: {
					message: `${(_fetchError$name2 = fetchError === null || fetchError === void 0 ? void 0 : fetchError.name) !== null && _fetchError$name2 !== void 0 ? _fetchError$name2 : "FetchError"}: ${fetchError === null || fetchError === void 0 ? void 0 : fetchError.message}`,
					details: errorDetails,
					hint,
					code
				},
				data: null,
				count: null,
				status: 0,
				statusText: ""
			};
		});
		return res.then(onfulfilled, onrejected);
	}
	/**
	* Override the type of the returned `data`.
	*
	* @typeParam NewResult - The new result type to override with
	* @deprecated Use overrideTypes<yourType, { merge: false }>() method at the end of your call chain instead
	*/
	returns() {
		/* istanbul ignore next */
		return this;
	}
	/**
	* Override the type of the returned `data` field in the response.
	*
	* @typeParam NewResult - The new type to cast the response data to
	* @typeParam Options - Optional type configuration (defaults to { merge: true })
	* @typeParam Options.merge - When true, merges the new type with existing return type. When false, replaces the existing types entirely (defaults to true)
	* @example
	* ```typescript
	* // Merge with existing types (default behavior)
	* const query = supabase
	*   .from('users')
	*   .select()
	*   .overrideTypes<{ custom_field: string }>()
	*
	* // Replace existing types completely
	* const replaceQuery = supabase
	*   .from('users')
	*   .select()
	*   .overrideTypes<{ id: number; name: string }, { merge: false }>()
	* ```
	* @returns A PostgrestBuilder instance with the new type
	*/
	overrideTypes() {
		return this;
	}
};

//#endregion
//#region src/PostgrestTransformBuilder.ts
var PostgrestTransformBuilder = class extends PostgrestBuilder {
	/**
	* Perform a SELECT on the query result.
	*
	* By default, `.insert()`, `.update()`, `.upsert()`, and `.delete()` do not
	* return modified rows. By calling this method, modified rows are returned in
	* `data`.
	*
	* @param columns - The columns to retrieve, separated by commas
	*/
	select(columns) {
		let quoted = false;
		const cleanedColumns = (columns !== null && columns !== void 0 ? columns : "*").split("").map((c) => {
			if (/\s/.test(c) && !quoted) return "";
			if (c === "\"") quoted = !quoted;
			return c;
		}).join("");
		this.url.searchParams.set("select", cleanedColumns);
		this.headers.append("Prefer", "return=representation");
		return this;
	}
	/**
	* Order the query result by `column`.
	*
	* You can call this method multiple times to order by multiple columns.
	*
	* You can order referenced tables, but it only affects the ordering of the
	* parent table if you use `!inner` in the query.
	*
	* @param column - The column to order by
	* @param options - Named parameters
	* @param options.ascending - If `true`, the result will be in ascending order
	* @param options.nullsFirst - If `true`, `null`s appear first. If `false`,
	* `null`s appear last.
	* @param options.referencedTable - Set this to order a referenced table by
	* its columns
	* @param options.foreignTable - Deprecated, use `options.referencedTable`
	* instead
	*/
	order(column, { ascending = true, nullsFirst, foreignTable, referencedTable = foreignTable } = {}) {
		const key = referencedTable ? `${referencedTable}.order` : "order";
		const existingOrder = this.url.searchParams.get(key);
		this.url.searchParams.set(key, `${existingOrder ? `${existingOrder},` : ""}${column}.${ascending ? "asc" : "desc"}${nullsFirst === void 0 ? "" : nullsFirst ? ".nullsfirst" : ".nullslast"}`);
		return this;
	}
	/**
	* Limit the query result by `count`.
	*
	* @param count - The maximum number of rows to return
	* @param options - Named parameters
	* @param options.referencedTable - Set this to limit rows of referenced
	* tables instead of the parent table
	* @param options.foreignTable - Deprecated, use `options.referencedTable`
	* instead
	*/
	limit(count, { foreignTable, referencedTable = foreignTable } = {}) {
		const key = typeof referencedTable === "undefined" ? "limit" : `${referencedTable}.limit`;
		this.url.searchParams.set(key, `${count}`);
		return this;
	}
	/**
	* Limit the query result by starting at an offset `from` and ending at the offset `to`.
	* Only records within this range are returned.
	* This respects the query order and if there is no order clause the range could behave unexpectedly.
	* The `from` and `to` values are 0-based and inclusive: `range(1, 3)` will include the second, third
	* and fourth rows of the query.
	*
	* @param from - The starting index from which to limit the result
	* @param to - The last index to which to limit the result
	* @param options - Named parameters
	* @param options.referencedTable - Set this to limit rows of referenced
	* tables instead of the parent table
	* @param options.foreignTable - Deprecated, use `options.referencedTable`
	* instead
	*/
	range(from, to, { foreignTable, referencedTable = foreignTable } = {}) {
		const keyOffset = typeof referencedTable === "undefined" ? "offset" : `${referencedTable}.offset`;
		const keyLimit = typeof referencedTable === "undefined" ? "limit" : `${referencedTable}.limit`;
		this.url.searchParams.set(keyOffset, `${from}`);
		this.url.searchParams.set(keyLimit, `${to - from + 1}`);
		return this;
	}
	/**
	* Set the AbortSignal for the fetch request.
	*
	* @param signal - The AbortSignal to use for the fetch request
	*/
	abortSignal(signal) {
		this.signal = signal;
		return this;
	}
	/**
	* Return `data` as a single object instead of an array of objects.
	*
	* Query result must be one row (e.g. using `.limit(1)`), otherwise this
	* returns an error.
	*/
	single() {
		this.headers.set("Accept", "application/vnd.pgrst.object+json");
		return this;
	}
	/**
	* Return `data` as a single object instead of an array of objects.
	*
	* Query result must be zero or one row (e.g. using `.limit(1)`), otherwise
	* this returns an error.
	*/
	maybeSingle() {
		if (this.method === "GET") this.headers.set("Accept", "application/json");
		else this.headers.set("Accept", "application/vnd.pgrst.object+json");
		this.isMaybeSingle = true;
		return this;
	}
	/**
	* Return `data` as a string in CSV format.
	*/
	csv() {
		this.headers.set("Accept", "text/csv");
		return this;
	}
	/**
	* Return `data` as an object in [GeoJSON](https://geojson.org) format.
	*/
	geojson() {
		this.headers.set("Accept", "application/geo+json");
		return this;
	}
	/**
	* Return `data` as the EXPLAIN plan for the query.
	*
	* You need to enable the
	* [db_plan_enabled](https://supabase.com/docs/guides/database/debugging-performance#enabling-explain)
	* setting before using this method.
	*
	* @param options - Named parameters
	*
	* @param options.analyze - If `true`, the query will be executed and the
	* actual run time will be returned
	*
	* @param options.verbose - If `true`, the query identifier will be returned
	* and `data` will include the output columns of the query
	*
	* @param options.settings - If `true`, include information on configuration
	* parameters that affect query planning
	*
	* @param options.buffers - If `true`, include information on buffer usage
	*
	* @param options.wal - If `true`, include information on WAL record generation
	*
	* @param options.format - The format of the output, can be `"text"` (default)
	* or `"json"`
	*/
	explain({ analyze = false, verbose = false, settings = false, buffers = false, wal = false, format = "text" } = {}) {
		var _this$headers$get;
		const options = [
			analyze ? "analyze" : null,
			verbose ? "verbose" : null,
			settings ? "settings" : null,
			buffers ? "buffers" : null,
			wal ? "wal" : null
		].filter(Boolean).join("|");
		const forMediatype = (_this$headers$get = this.headers.get("Accept")) !== null && _this$headers$get !== void 0 ? _this$headers$get : "application/json";
		this.headers.set("Accept", `application/vnd.pgrst.plan+${format}; for="${forMediatype}"; options=${options};`);
		if (format === "json") return this;
		else return this;
	}
	/**
	* Rollback the query.
	*
	* `data` will still be returned, but the query is not committed.
	*/
	rollback() {
		this.headers.append("Prefer", "tx=rollback");
		return this;
	}
	/**
	* Override the type of the returned `data`.
	*
	* @typeParam NewResult - The new result type to override with
	* @deprecated Use overrideTypes<yourType, { merge: false }>() method at the end of your call chain instead
	*/
	returns() {
		return this;
	}
	/**
	* Set the maximum number of rows that can be affected by the query.
	* Only available in PostgREST v13+ and only works with PATCH and DELETE methods.
	*
	* @param value - The maximum number of rows that can be affected
	*/
	maxAffected(value) {
		this.headers.append("Prefer", "handling=strict");
		this.headers.append("Prefer", `max-affected=${value}`);
		return this;
	}
};

//#endregion
//#region src/PostgrestFilterBuilder.ts
const PostgrestReservedCharsRegexp = /* @__PURE__ */ new RegExp("[,()]");
var PostgrestFilterBuilder = class extends PostgrestTransformBuilder {
	/**
	* Match only rows where `column` is equal to `value`.
	*
	* To check if the value of `column` is NULL, you should use `.is()` instead.
	*
	* @param column - The column to filter on
	* @param value - The value to filter with
	*/
	eq(column, value) {
		this.url.searchParams.append(column, `eq.${value}`);
		return this;
	}
	/**
	* Match only rows where `column` is not equal to `value`.
	*
	* @param column - The column to filter on
	* @param value - The value to filter with
	*/
	neq(column, value) {
		this.url.searchParams.append(column, `neq.${value}`);
		return this;
	}
	/**
	* Match only rows where `column` is greater than `value`.
	*
	* @param column - The column to filter on
	* @param value - The value to filter with
	*/
	gt(column, value) {
		this.url.searchParams.append(column, `gt.${value}`);
		return this;
	}
	/**
	* Match only rows where `column` is greater than or equal to `value`.
	*
	* @param column - The column to filter on
	* @param value - The value to filter with
	*/
	gte(column, value) {
		this.url.searchParams.append(column, `gte.${value}`);
		return this;
	}
	/**
	* Match only rows where `column` is less than `value`.
	*
	* @param column - The column to filter on
	* @param value - The value to filter with
	*/
	lt(column, value) {
		this.url.searchParams.append(column, `lt.${value}`);
		return this;
	}
	/**
	* Match only rows where `column` is less than or equal to `value`.
	*
	* @param column - The column to filter on
	* @param value - The value to filter with
	*/
	lte(column, value) {
		this.url.searchParams.append(column, `lte.${value}`);
		return this;
	}
	/**
	* Match only rows where `column` matches `pattern` case-sensitively.
	*
	* @param column - The column to filter on
	* @param pattern - The pattern to match with
	*/
	like(column, pattern) {
		this.url.searchParams.append(column, `like.${pattern}`);
		return this;
	}
	/**
	* Match only rows where `column` matches all of `patterns` case-sensitively.
	*
	* @param column - The column to filter on
	* @param patterns - The patterns to match with
	*/
	likeAllOf(column, patterns) {
		this.url.searchParams.append(column, `like(all).{${patterns.join(",")}}`);
		return this;
	}
	/**
	* Match only rows where `column` matches any of `patterns` case-sensitively.
	*
	* @param column - The column to filter on
	* @param patterns - The patterns to match with
	*/
	likeAnyOf(column, patterns) {
		this.url.searchParams.append(column, `like(any).{${patterns.join(",")}}`);
		return this;
	}
	/**
	* Match only rows where `column` matches `pattern` case-insensitively.
	*
	* @param column - The column to filter on
	* @param pattern - The pattern to match with
	*/
	ilike(column, pattern) {
		this.url.searchParams.append(column, `ilike.${pattern}`);
		return this;
	}
	/**
	* Match only rows where `column` matches all of `patterns` case-insensitively.
	*
	* @param column - The column to filter on
	* @param patterns - The patterns to match with
	*/
	ilikeAllOf(column, patterns) {
		this.url.searchParams.append(column, `ilike(all).{${patterns.join(",")}}`);
		return this;
	}
	/**
	* Match only rows where `column` matches any of `patterns` case-insensitively.
	*
	* @param column - The column to filter on
	* @param patterns - The patterns to match with
	*/
	ilikeAnyOf(column, patterns) {
		this.url.searchParams.append(column, `ilike(any).{${patterns.join(",")}}`);
		return this;
	}
	/**
	* Match only rows where `column` matches the PostgreSQL regex `pattern`
	* case-sensitively (using the `~` operator).
	*
	* @param column - The column to filter on
	* @param pattern - The PostgreSQL regular expression pattern to match with
	*/
	regexMatch(column, pattern) {
		this.url.searchParams.append(column, `match.${pattern}`);
		return this;
	}
	/**
	* Match only rows where `column` matches the PostgreSQL regex `pattern`
	* case-insensitively (using the `~*` operator).
	*
	* @param column - The column to filter on
	* @param pattern - The PostgreSQL regular expression pattern to match with
	*/
	regexIMatch(column, pattern) {
		this.url.searchParams.append(column, `imatch.${pattern}`);
		return this;
	}
	/**
	* Match only rows where `column` IS `value`.
	*
	* For non-boolean columns, this is only relevant for checking if the value of
	* `column` is NULL by setting `value` to `null`.
	*
	* For boolean columns, you can also set `value` to `true` or `false` and it
	* will behave the same way as `.eq()`.
	*
	* @param column - The column to filter on
	* @param value - The value to filter with
	*/
	is(column, value) {
		this.url.searchParams.append(column, `is.${value}`);
		return this;
	}
	/**
	* Match only rows where `column` IS DISTINCT FROM `value`.
	*
	* Unlike `.neq()`, this treats `NULL` as a comparable value. Two `NULL` values
	* are considered equal (not distinct), and comparing `NULL` with any non-NULL
	* value returns true (distinct).
	*
	* @param column - The column to filter on
	* @param value - The value to filter with
	*/
	isDistinct(column, value) {
		this.url.searchParams.append(column, `isdistinct.${value}`);
		return this;
	}
	/**
	* Match only rows where `column` is included in the `values` array.
	*
	* @param column - The column to filter on
	* @param values - The values array to filter with
	*/
	in(column, values) {
		const cleanedValues = Array.from(new Set(values)).map((s) => {
			if (typeof s === "string" && PostgrestReservedCharsRegexp.test(s)) return `"${s}"`;
			else return `${s}`;
		}).join(",");
		this.url.searchParams.append(column, `in.(${cleanedValues})`);
		return this;
	}
	/**
	* Match only rows where `column` is NOT included in the `values` array.
	*
	* @param column - The column to filter on
	* @param values - The values array to filter with
	*/
	notIn(column, values) {
		const cleanedValues = Array.from(new Set(values)).map((s) => {
			if (typeof s === "string" && PostgrestReservedCharsRegexp.test(s)) return `"${s}"`;
			else return `${s}`;
		}).join(",");
		this.url.searchParams.append(column, `not.in.(${cleanedValues})`);
		return this;
	}
	/**
	* Only relevant for jsonb, array, and range columns. Match only rows where
	* `column` contains every element appearing in `value`.
	*
	* @param column - The jsonb, array, or range column to filter on
	* @param value - The jsonb, array, or range value to filter with
	*/
	contains(column, value) {
		if (typeof value === "string") this.url.searchParams.append(column, `cs.${value}`);
		else if (Array.isArray(value)) this.url.searchParams.append(column, `cs.{${value.join(",")}}`);
		else this.url.searchParams.append(column, `cs.${JSON.stringify(value)}`);
		return this;
	}
	/**
	* Only relevant for jsonb, array, and range columns. Match only rows where
	* every element appearing in `column` is contained by `value`.
	*
	* @param column - The jsonb, array, or range column to filter on
	* @param value - The jsonb, array, or range value to filter with
	*/
	containedBy(column, value) {
		if (typeof value === "string") this.url.searchParams.append(column, `cd.${value}`);
		else if (Array.isArray(value)) this.url.searchParams.append(column, `cd.{${value.join(",")}}`);
		else this.url.searchParams.append(column, `cd.${JSON.stringify(value)}`);
		return this;
	}
	/**
	* Only relevant for range columns. Match only rows where every element in
	* `column` is greater than any element in `range`.
	*
	* @param column - The range column to filter on
	* @param range - The range to filter with
	*/
	rangeGt(column, range) {
		this.url.searchParams.append(column, `sr.${range}`);
		return this;
	}
	/**
	* Only relevant for range columns. Match only rows where every element in
	* `column` is either contained in `range` or greater than any element in
	* `range`.
	*
	* @param column - The range column to filter on
	* @param range - The range to filter with
	*/
	rangeGte(column, range) {
		this.url.searchParams.append(column, `nxl.${range}`);
		return this;
	}
	/**
	* Only relevant for range columns. Match only rows where every element in
	* `column` is less than any element in `range`.
	*
	* @param column - The range column to filter on
	* @param range - The range to filter with
	*/
	rangeLt(column, range) {
		this.url.searchParams.append(column, `sl.${range}`);
		return this;
	}
	/**
	* Only relevant for range columns. Match only rows where every element in
	* `column` is either contained in `range` or less than any element in
	* `range`.
	*
	* @param column - The range column to filter on
	* @param range - The range to filter with
	*/
	rangeLte(column, range) {
		this.url.searchParams.append(column, `nxr.${range}`);
		return this;
	}
	/**
	* Only relevant for range columns. Match only rows where `column` is
	* mutually exclusive to `range` and there can be no element between the two
	* ranges.
	*
	* @param column - The range column to filter on
	* @param range - The range to filter with
	*/
	rangeAdjacent(column, range) {
		this.url.searchParams.append(column, `adj.${range}`);
		return this;
	}
	/**
	* Only relevant for array and range columns. Match only rows where
	* `column` and `value` have an element in common.
	*
	* @param column - The array or range column to filter on
	* @param value - The array or range value to filter with
	*/
	overlaps(column, value) {
		if (typeof value === "string") this.url.searchParams.append(column, `ov.${value}`);
		else this.url.searchParams.append(column, `ov.{${value.join(",")}}`);
		return this;
	}
	/**
	* Only relevant for text and tsvector columns. Match only rows where
	* `column` matches the query string in `query`.
	*
	* @param column - The text or tsvector column to filter on
	* @param query - The query text to match with
	* @param options - Named parameters
	* @param options.config - The text search configuration to use
	* @param options.type - Change how the `query` text is interpreted
	*/
	textSearch(column, query, { config, type } = {}) {
		let typePart = "";
		if (type === "plain") typePart = "pl";
		else if (type === "phrase") typePart = "ph";
		else if (type === "websearch") typePart = "w";
		const configPart = config === void 0 ? "" : `(${config})`;
		this.url.searchParams.append(column, `${typePart}fts${configPart}.${query}`);
		return this;
	}
	/**
	* Match only rows where each column in `query` keys is equal to its
	* associated value. Shorthand for multiple `.eq()`s.
	*
	* @param query - The object to filter with, with column names as keys mapped
	* to their filter values
	*/
	match(query) {
		Object.entries(query).forEach(([column, value]) => {
			this.url.searchParams.append(column, `eq.${value}`);
		});
		return this;
	}
	/**
	* Match only rows which doesn't satisfy the filter.
	*
	* Unlike most filters, `opearator` and `value` are used as-is and need to
	* follow [PostgREST
	* syntax](https://postgrest.org/en/stable/api.html#operators). You also need
	* to make sure they are properly sanitized.
	*
	* @param column - The column to filter on
	* @param operator - The operator to be negated to filter with, following
	* PostgREST syntax
	* @param value - The value to filter with, following PostgREST syntax
	*/
	not(column, operator, value) {
		this.url.searchParams.append(column, `not.${operator}.${value}`);
		return this;
	}
	/**
	* Match only rows which satisfy at least one of the filters.
	*
	* Unlike most filters, `filters` is used as-is and needs to follow [PostgREST
	* syntax](https://postgrest.org/en/stable/api.html#operators). You also need
	* to make sure it's properly sanitized.
	*
	* It's currently not possible to do an `.or()` filter across multiple tables.
	*
	* @param filters - The filters to use, following PostgREST syntax
	* @param options - Named parameters
	* @param options.referencedTable - Set this to filter on referenced tables
	* instead of the parent table
	* @param options.foreignTable - Deprecated, use `referencedTable` instead
	*/
	or(filters, { foreignTable, referencedTable = foreignTable } = {}) {
		const key = referencedTable ? `${referencedTable}.or` : "or";
		this.url.searchParams.append(key, `(${filters})`);
		return this;
	}
	/**
	* Match only rows which satisfy the filter. This is an escape hatch - you
	* should use the specific filter methods wherever possible.
	*
	* Unlike most filters, `opearator` and `value` are used as-is and need to
	* follow [PostgREST
	* syntax](https://postgrest.org/en/stable/api.html#operators). You also need
	* to make sure they are properly sanitized.
	*
	* @param column - The column to filter on
	* @param operator - The operator to filter with, following PostgREST syntax
	* @param value - The value to filter with, following PostgREST syntax
	*/
	filter(column, operator, value) {
		this.url.searchParams.append(column, `${operator}.${value}`);
		return this;
	}
};

//#endregion
//#region src/PostgrestQueryBuilder.ts
var PostgrestQueryBuilder = class {
	/**
	* Creates a query builder scoped to a Postgres table or view.
	*
	* @example
	* ```ts
	* import PostgrestQueryBuilder from '@supabase/postgrest-js'
	*
	* const query = new PostgrestQueryBuilder(
	*   new URL('https://xyzcompany.supabase.co/rest/v1/users'),
	*   { headers: { apikey: 'public-anon-key' } }
	* )
	* ```
	*/
	constructor(url, { headers = {}, schema, fetch: fetch$1, urlLengthLimit = 8e3 }) {
		this.url = url;
		this.headers = new Headers(headers);
		this.schema = schema;
		this.fetch = fetch$1;
		this.urlLengthLimit = urlLengthLimit;
	}
	/**
	* Clone URL and headers to prevent shared state between operations.
	*/
	cloneRequestState() {
		return {
			url: new URL(this.url.toString()),
			headers: new Headers(this.headers)
		};
	}
	/**
	* Perform a SELECT query on the table or view.
	*
	* @param columns - The columns to retrieve, separated by commas. Columns can be renamed when returned with `customName:columnName`
	*
	* @param options - Named parameters
	*
	* @param options.head - When set to `true`, `data` will not be returned.
	* Useful if you only need the count.
	*
	* @param options.count - Count algorithm to use to count rows in the table or view.
	*
	* `"exact"`: Exact but slow count algorithm. Performs a `COUNT(*)` under the
	* hood.
	*
	* `"planned"`: Approximated but fast count algorithm. Uses the Postgres
	* statistics under the hood.
	*
	* `"estimated"`: Uses exact count for low numbers and planned count for high
	* numbers.
	*
	* @remarks
	* When using `count` with `.range()` or `.limit()`, the returned `count` is the total number of rows
	* that match your filters, not the number of rows in the current page. Use this to build pagination UI.
	*/
	select(columns, options) {
		const { head = false, count } = options !== null && options !== void 0 ? options : {};
		const method = head ? "HEAD" : "GET";
		let quoted = false;
		const cleanedColumns = (columns !== null && columns !== void 0 ? columns : "*").split("").map((c) => {
			if (/\s/.test(c) && !quoted) return "";
			if (c === "\"") quoted = !quoted;
			return c;
		}).join("");
		const { url, headers } = this.cloneRequestState();
		url.searchParams.set("select", cleanedColumns);
		if (count) headers.append("Prefer", `count=${count}`);
		return new PostgrestFilterBuilder({
			method,
			url,
			headers,
			schema: this.schema,
			fetch: this.fetch,
			urlLengthLimit: this.urlLengthLimit
		});
	}
	/**
	* Perform an INSERT into the table or view.
	*
	* By default, inserted rows are not returned. To return it, chain the call
	* with `.select()`.
	*
	* @param values - The values to insert. Pass an object to insert a single row
	* or an array to insert multiple rows.
	*
	* @param options - Named parameters
	*
	* @param options.count - Count algorithm to use to count inserted rows.
	*
	* `"exact"`: Exact but slow count algorithm. Performs a `COUNT(*)` under the
	* hood.
	*
	* `"planned"`: Approximated but fast count algorithm. Uses the Postgres
	* statistics under the hood.
	*
	* `"estimated"`: Uses exact count for low numbers and planned count for high
	* numbers.
	*
	* @param options.defaultToNull - Make missing fields default to `null`.
	* Otherwise, use the default value for the column. Only applies for bulk
	* inserts.
	*/
	insert(values, { count, defaultToNull = true } = {}) {
		var _this$fetch;
		const method = "POST";
		const { url, headers } = this.cloneRequestState();
		if (count) headers.append("Prefer", `count=${count}`);
		if (!defaultToNull) headers.append("Prefer", `missing=default`);
		if (Array.isArray(values)) {
			const columns = values.reduce((acc, x) => acc.concat(Object.keys(x)), []);
			if (columns.length > 0) {
				const uniqueColumns = [...new Set(columns)].map((column) => `"${column}"`);
				url.searchParams.set("columns", uniqueColumns.join(","));
			}
		}
		return new PostgrestFilterBuilder({
			method,
			url,
			headers,
			schema: this.schema,
			body: values,
			fetch: (_this$fetch = this.fetch) !== null && _this$fetch !== void 0 ? _this$fetch : fetch,
			urlLengthLimit: this.urlLengthLimit
		});
	}
	/**
	* Perform an UPSERT on the table or view. Depending on the column(s) passed
	* to `onConflict`, `.upsert()` allows you to perform the equivalent of
	* `.insert()` if a row with the corresponding `onConflict` columns doesn't
	* exist, or if it does exist, perform an alternative action depending on
	* `ignoreDuplicates`.
	*
	* By default, upserted rows are not returned. To return it, chain the call
	* with `.select()`.
	*
	* @param values - The values to upsert with. Pass an object to upsert a
	* single row or an array to upsert multiple rows.
	*
	* @param options - Named parameters
	*
	* @param options.onConflict - Comma-separated UNIQUE column(s) to specify how
	* duplicate rows are determined. Two rows are duplicates if all the
	* `onConflict` columns are equal.
	*
	* @param options.ignoreDuplicates - If `true`, duplicate rows are ignored. If
	* `false`, duplicate rows are merged with existing rows.
	*
	* @param options.count - Count algorithm to use to count upserted rows.
	*
	* `"exact"`: Exact but slow count algorithm. Performs a `COUNT(*)` under the
	* hood.
	*
	* `"planned"`: Approximated but fast count algorithm. Uses the Postgres
	* statistics under the hood.
	*
	* `"estimated"`: Uses exact count for low numbers and planned count for high
	* numbers.
	*
	* @param options.defaultToNull - Make missing fields default to `null`.
	* Otherwise, use the default value for the column. This only applies when
	* inserting new rows, not when merging with existing rows under
	* `ignoreDuplicates: false`. This also only applies when doing bulk upserts.
	*
	* @example Upsert a single row using a unique key
	* ```ts
	* // Upserting a single row, overwriting based on the 'username' unique column
	* const { data, error } = await supabase
	*   .from('users')
	*   .upsert({ username: 'supabot' }, { onConflict: 'username' })
	*
	* // Example response:
	* // {
	* //   data: [
	* //     { id: 4, message: 'bar', username: 'supabot' }
	* //   ],
	* //   error: null
	* // }
	* ```
	*
	* @example Upsert with conflict resolution and exact row counting
	* ```ts
	* // Upserting and returning exact count
	* const { data, error, count } = await supabase
	*   .from('users')
	*   .upsert(
	*     {
	*       id: 3,
	*       message: 'foo',
	*       username: 'supabot'
	*     },
	*     {
	*       onConflict: 'username',
	*       count: 'exact'
	*     }
	*   )
	*
	* // Example response:
	* // {
	* //   data: [
	* //     {
	* //       id: 42,
	* //       handle: "saoirse",
	* //       display_name: "Saoirse"
	* //     }
	* //   ],
	* //   count: 1,
	* //   error: null
	* // }
	* ```
	*/
	upsert(values, { onConflict, ignoreDuplicates = false, count, defaultToNull = true } = {}) {
		var _this$fetch2;
		const method = "POST";
		const { url, headers } = this.cloneRequestState();
		headers.append("Prefer", `resolution=${ignoreDuplicates ? "ignore" : "merge"}-duplicates`);
		if (onConflict !== void 0) url.searchParams.set("on_conflict", onConflict);
		if (count) headers.append("Prefer", `count=${count}`);
		if (!defaultToNull) headers.append("Prefer", "missing=default");
		if (Array.isArray(values)) {
			const columns = values.reduce((acc, x) => acc.concat(Object.keys(x)), []);
			if (columns.length > 0) {
				const uniqueColumns = [...new Set(columns)].map((column) => `"${column}"`);
				url.searchParams.set("columns", uniqueColumns.join(","));
			}
		}
		return new PostgrestFilterBuilder({
			method,
			url,
			headers,
			schema: this.schema,
			body: values,
			fetch: (_this$fetch2 = this.fetch) !== null && _this$fetch2 !== void 0 ? _this$fetch2 : fetch,
			urlLengthLimit: this.urlLengthLimit
		});
	}
	/**
	* Perform an UPDATE on the table or view.
	*
	* By default, updated rows are not returned. To return it, chain the call
	* with `.select()` after filters.
	*
	* @param values - The values to update with
	*
	* @param options - Named parameters
	*
	* @param options.count - Count algorithm to use to count updated rows.
	*
	* `"exact"`: Exact but slow count algorithm. Performs a `COUNT(*)` under the
	* hood.
	*
	* `"planned"`: Approximated but fast count algorithm. Uses the Postgres
	* statistics under the hood.
	*
	* `"estimated"`: Uses exact count for low numbers and planned count for high
	* numbers.
	*/
	update(values, { count } = {}) {
		var _this$fetch3;
		const method = "PATCH";
		const { url, headers } = this.cloneRequestState();
		if (count) headers.append("Prefer", `count=${count}`);
		return new PostgrestFilterBuilder({
			method,
			url,
			headers,
			schema: this.schema,
			body: values,
			fetch: (_this$fetch3 = this.fetch) !== null && _this$fetch3 !== void 0 ? _this$fetch3 : fetch,
			urlLengthLimit: this.urlLengthLimit
		});
	}
	/**
	* Perform a DELETE on the table or view.
	*
	* By default, deleted rows are not returned. To return it, chain the call
	* with `.select()` after filters.
	*
	* @param options - Named parameters
	*
	* @param options.count - Count algorithm to use to count deleted rows.
	*
	* `"exact"`: Exact but slow count algorithm. Performs a `COUNT(*)` under the
	* hood.
	*
	* `"planned"`: Approximated but fast count algorithm. Uses the Postgres
	* statistics under the hood.
	*
	* `"estimated"`: Uses exact count for low numbers and planned count for high
	* numbers.
	*/
	delete({ count } = {}) {
		var _this$fetch4;
		const method = "DELETE";
		const { url, headers } = this.cloneRequestState();
		if (count) headers.append("Prefer", `count=${count}`);
		return new PostgrestFilterBuilder({
			method,
			url,
			headers,
			schema: this.schema,
			fetch: (_this$fetch4 = this.fetch) !== null && _this$fetch4 !== void 0 ? _this$fetch4 : fetch,
			urlLengthLimit: this.urlLengthLimit
		});
	}
};

//#endregion
//#region \0@oxc-project+runtime@0.101.0/helpers/typeof.js
function _typeof(o) {
	"@babel/helpers - typeof";
	return _typeof = "function" == typeof Symbol && "symbol" == typeof Symbol.iterator ? function(o$1) {
		return typeof o$1;
	} : function(o$1) {
		return o$1 && "function" == typeof Symbol && o$1.constructor === Symbol && o$1 !== Symbol.prototype ? "symbol" : typeof o$1;
	}, _typeof(o);
}

//#endregion
//#region \0@oxc-project+runtime@0.101.0/helpers/toPrimitive.js
function toPrimitive(t, r) {
	if ("object" != _typeof(t) || !t) return t;
	var e = t[Symbol.toPrimitive];
	if (void 0 !== e) {
		var i = e.call(t, r || "default");
		if ("object" != _typeof(i)) return i;
		throw new TypeError("@@toPrimitive must return a primitive value.");
	}
	return ("string" === r ? String : Number)(t);
}

//#endregion
//#region \0@oxc-project+runtime@0.101.0/helpers/toPropertyKey.js
function toPropertyKey(t) {
	var i = toPrimitive(t, "string");
	return "symbol" == _typeof(i) ? i : i + "";
}

//#endregion
//#region \0@oxc-project+runtime@0.101.0/helpers/defineProperty.js
function _defineProperty(e, r, t) {
	return (r = toPropertyKey(r)) in e ? Object.defineProperty(e, r, {
		value: t,
		enumerable: !0,
		configurable: !0,
		writable: !0
	}) : e[r] = t, e;
}

//#endregion
//#region \0@oxc-project+runtime@0.101.0/helpers/objectSpread2.js
function ownKeys(e, r) {
	var t = Object.keys(e);
	if (Object.getOwnPropertySymbols) {
		var o = Object.getOwnPropertySymbols(e);
		r && (o = o.filter(function(r$1) {
			return Object.getOwnPropertyDescriptor(e, r$1).enumerable;
		})), t.push.apply(t, o);
	}
	return t;
}
function _objectSpread2(e) {
	for (var r = 1; r < arguments.length; r++) {
		var t = null != arguments[r] ? arguments[r] : {};
		r % 2 ? ownKeys(Object(t), !0).forEach(function(r$1) {
			_defineProperty(e, r$1, t[r$1]);
		}) : Object.getOwnPropertyDescriptors ? Object.defineProperties(e, Object.getOwnPropertyDescriptors(t)) : ownKeys(Object(t)).forEach(function(r$1) {
			Object.defineProperty(e, r$1, Object.getOwnPropertyDescriptor(t, r$1));
		});
	}
	return e;
}

//#endregion
//#region src/PostgrestClient.ts
/**
* PostgREST client.
*
* @typeParam Database - Types for the schema from the [type
* generator](https://supabase.com/docs/reference/javascript/next/typescript-support)
*
* @typeParam SchemaName - Postgres schema to switch to. Must be a string
* literal, the same one passed to the constructor. If the schema is not
* `"public"`, this must be supplied manually.
*/
var PostgrestClient = class PostgrestClient {
	/**
	* Creates a PostgREST client.
	*
	* @param url - URL of the PostgREST endpoint
	* @param options - Named parameters
	* @param options.headers - Custom headers
	* @param options.schema - Postgres schema to switch to
	* @param options.fetch - Custom fetch
	* @param options.timeout - Optional timeout in milliseconds for all requests. When set, requests will automatically abort after this duration to prevent indefinite hangs.
	* @param options.urlLengthLimit - Maximum URL length in characters before warnings/errors are triggered. Defaults to 8000.
	* @example
	* ```ts
	* import PostgrestClient from '@supabase/postgrest-js'
	*
	* const postgrest = new PostgrestClient('https://xyzcompany.supabase.co/rest/v1', {
	*   headers: { apikey: 'public-anon-key' },
	*   schema: 'public',
	*   timeout: 30000, // 30 second timeout
	* })
	* ```
	*/
	constructor(url, { headers = {}, schema, fetch: fetch$1, timeout, urlLengthLimit = 8e3 } = {}) {
		this.url = url;
		this.headers = new Headers(headers);
		this.schemaName = schema;
		this.urlLengthLimit = urlLengthLimit;
		const originalFetch = fetch$1 !== null && fetch$1 !== void 0 ? fetch$1 : globalThis.fetch;
		if (timeout !== void 0 && timeout > 0) this.fetch = (input, init) => {
			const controller = new AbortController();
			const timeoutId = setTimeout(() => controller.abort(), timeout);
			const existingSignal = init === null || init === void 0 ? void 0 : init.signal;
			if (existingSignal) {
				if (existingSignal.aborted) {
					clearTimeout(timeoutId);
					return originalFetch(input, init);
				}
				const abortHandler = () => {
					clearTimeout(timeoutId);
					controller.abort();
				};
				existingSignal.addEventListener("abort", abortHandler, { once: true });
				return originalFetch(input, _objectSpread2(_objectSpread2({}, init), {}, { signal: controller.signal })).finally(() => {
					clearTimeout(timeoutId);
					existingSignal.removeEventListener("abort", abortHandler);
				});
			}
			return originalFetch(input, _objectSpread2(_objectSpread2({}, init), {}, { signal: controller.signal })).finally(() => clearTimeout(timeoutId));
		};
		else this.fetch = originalFetch;
	}
	/**
	* Perform a query on a table or a view.
	*
	* @param relation - The table or view name to query
	*/
	from(relation) {
		if (!relation || typeof relation !== "string" || relation.trim() === "") throw new Error("Invalid relation name: relation must be a non-empty string.");
		return new PostgrestQueryBuilder(new URL(`${this.url}/${relation}`), {
			headers: new Headers(this.headers),
			schema: this.schemaName,
			fetch: this.fetch,
			urlLengthLimit: this.urlLengthLimit
		});
	}
	/**
	* Select a schema to query or perform an function (rpc) call.
	*
	* The schema needs to be on the list of exposed schemas inside Supabase.
	*
	* @param schema - The schema to query
	*/
	schema(schema) {
		return new PostgrestClient(this.url, {
			headers: this.headers,
			schema,
			fetch: this.fetch,
			urlLengthLimit: this.urlLengthLimit
		});
	}
	/**
	* Perform a function call.
	*
	* @param fn - The function name to call
	* @param args - The arguments to pass to the function call
	* @param options - Named parameters
	* @param options.head - When set to `true`, `data` will not be returned.
	* Useful if you only need the count.
	* @param options.get - When set to `true`, the function will be called with
	* read-only access mode.
	* @param options.count - Count algorithm to use to count rows returned by the
	* function. Only applicable for [set-returning
	* functions](https://www.postgresql.org/docs/current/functions-srf.html).
	*
	* `"exact"`: Exact but slow count algorithm. Performs a `COUNT(*)` under the
	* hood.
	*
	* `"planned"`: Approximated but fast count algorithm. Uses the Postgres
	* statistics under the hood.
	*
	* `"estimated"`: Uses exact count for low numbers and planned count for high
	* numbers.
	*
	* @example
	* ```ts
	* // For cross-schema functions where type inference fails, use overrideTypes:
	* const { data } = await supabase
	*   .schema('schema_b')
	*   .rpc('function_a', {})
	*   .overrideTypes<{ id: string; user_id: string }[]>()
	* ```
	*/
	rpc(fn, args = {}, { head = false, get = false, count } = {}) {
		var _this$fetch;
		let method;
		const url = new URL(`${this.url}/rpc/${fn}`);
		let body;
		const _isObject = (v) => v !== null && typeof v === "object" && (!Array.isArray(v) || v.some(_isObject));
		const _hasObjectArg = head && Object.values(args).some(_isObject);
		if (_hasObjectArg) {
			method = "POST";
			body = args;
		} else if (head || get) {
			method = head ? "HEAD" : "GET";
			Object.entries(args).filter(([_, value]) => value !== void 0).map(([name, value]) => [name, Array.isArray(value) ? `{${value.join(",")}}` : `${value}`]).forEach(([name, value]) => {
				url.searchParams.append(name, value);
			});
		} else {
			method = "POST";
			body = args;
		}
		const headers = new Headers(this.headers);
		if (_hasObjectArg) headers.set("Prefer", count ? `count=${count},return=minimal` : "return=minimal");
		else if (count) headers.set("Prefer", `count=${count}`);
		return new PostgrestFilterBuilder({
			method,
			url,
			headers,
			schema: this.schemaName,
			body,
			fetch: (_this$fetch = this.fetch) !== null && _this$fetch !== void 0 ? _this$fetch : fetch,
			urlLengthLimit: this.urlLengthLimit
		});
	}
};

//#endregion
//#region src/index.ts
var src_default = {
	PostgrestClient,
	PostgrestQueryBuilder,
	PostgrestFilterBuilder,
	PostgrestTransformBuilder,
	PostgrestBuilder,
	PostgrestError
};

//#endregion

//# sourceMappingURL=index.mjs.map
// EXTERNAL MODULE: ./node_modules/@supabase/realtime-js/dist/main/index.js
var dist_main = __webpack_require__(9626);
;// CONCATENATED MODULE: ./node_modules/iceberg-js/dist/index.mjs
// src/errors/IcebergError.ts
var IcebergError = class extends Error {
  constructor(message, opts) {
    super(message);
    this.name = "IcebergError";
    this.status = opts.status;
    this.icebergType = opts.icebergType;
    this.icebergCode = opts.icebergCode;
    this.details = opts.details;
    this.isCommitStateUnknown = opts.icebergType === "CommitStateUnknownException" || [500, 502, 504].includes(opts.status) && opts.icebergType?.includes("CommitState") === true;
  }
  /**
   * Returns true if the error is a 404 Not Found error.
   */
  isNotFound() {
    return this.status === 404;
  }
  /**
   * Returns true if the error is a 409 Conflict error.
   */
  isConflict() {
    return this.status === 409;
  }
  /**
   * Returns true if the error is a 419 Authentication Timeout error.
   */
  isAuthenticationTimeout() {
    return this.status === 419;
  }
};

// src/utils/url.ts
function buildUrl(baseUrl, path, query) {
  const url = new URL(path, baseUrl);
  if (query) {
    for (const [key, value] of Object.entries(query)) {
      if (value !== void 0) {
        url.searchParams.set(key, value);
      }
    }
  }
  return url.toString();
}

// src/http/createFetchClient.ts
async function buildAuthHeaders(auth) {
  if (!auth || auth.type === "none") {
    return {};
  }
  if (auth.type === "bearer") {
    return { Authorization: `Bearer ${auth.token}` };
  }
  if (auth.type === "header") {
    return { [auth.name]: auth.value };
  }
  if (auth.type === "custom") {
    return await auth.getHeaders();
  }
  return {};
}
function createFetchClient(options) {
  const fetchFn = options.fetchImpl ?? globalThis.fetch;
  return {
    async request({
      method,
      path,
      query,
      body,
      headers
    }) {
      const url = buildUrl(options.baseUrl, path, query);
      const authHeaders = await buildAuthHeaders(options.auth);
      const res = await fetchFn(url, {
        method,
        headers: {
          ...body ? { "Content-Type": "application/json" } : {},
          ...authHeaders,
          ...headers
        },
        body: body ? JSON.stringify(body) : void 0
      });
      const text = await res.text();
      const isJson = (res.headers.get("content-type") || "").includes("application/json");
      const data = isJson && text ? JSON.parse(text) : text;
      if (!res.ok) {
        const errBody = isJson ? data : void 0;
        const errorDetail = errBody?.error;
        throw new IcebergError(
          errorDetail?.message ?? `Request failed with status ${res.status}`,
          {
            status: res.status,
            icebergType: errorDetail?.type,
            icebergCode: errorDetail?.code,
            details: errBody
          }
        );
      }
      return { status: res.status, headers: res.headers, data };
    }
  };
}

// src/catalog/namespaces.ts
function namespaceToPath(namespace) {
  return namespace.join("");
}
var NamespaceOperations = class {
  constructor(client, prefix = "") {
    this.client = client;
    this.prefix = prefix;
  }
  async listNamespaces(parent) {
    const query = parent ? { parent: namespaceToPath(parent.namespace) } : void 0;
    const response = await this.client.request({
      method: "GET",
      path: `${this.prefix}/namespaces`,
      query
    });
    return response.data.namespaces.map((ns) => ({ namespace: ns }));
  }
  async createNamespace(id, metadata) {
    const request = {
      namespace: id.namespace,
      properties: metadata?.properties
    };
    const response = await this.client.request({
      method: "POST",
      path: `${this.prefix}/namespaces`,
      body: request
    });
    return response.data;
  }
  async dropNamespace(id) {
    await this.client.request({
      method: "DELETE",
      path: `${this.prefix}/namespaces/${namespaceToPath(id.namespace)}`
    });
  }
  async loadNamespaceMetadata(id) {
    const response = await this.client.request({
      method: "GET",
      path: `${this.prefix}/namespaces/${namespaceToPath(id.namespace)}`
    });
    return {
      properties: response.data.properties
    };
  }
  async namespaceExists(id) {
    try {
      await this.client.request({
        method: "HEAD",
        path: `${this.prefix}/namespaces/${namespaceToPath(id.namespace)}`
      });
      return true;
    } catch (error) {
      if (error instanceof IcebergError && error.status === 404) {
        return false;
      }
      throw error;
    }
  }
  async createNamespaceIfNotExists(id, metadata) {
    try {
      return await this.createNamespace(id, metadata);
    } catch (error) {
      if (error instanceof IcebergError && error.status === 409) {
        return;
      }
      throw error;
    }
  }
};

// src/catalog/tables.ts
function namespaceToPath2(namespace) {
  return namespace.join("");
}
var TableOperations = class {
  constructor(client, prefix = "", accessDelegation) {
    this.client = client;
    this.prefix = prefix;
    this.accessDelegation = accessDelegation;
  }
  async listTables(namespace) {
    const response = await this.client.request({
      method: "GET",
      path: `${this.prefix}/namespaces/${namespaceToPath2(namespace.namespace)}/tables`
    });
    return response.data.identifiers;
  }
  async createTable(namespace, request) {
    const headers = {};
    if (this.accessDelegation) {
      headers["X-Iceberg-Access-Delegation"] = this.accessDelegation;
    }
    const response = await this.client.request({
      method: "POST",
      path: `${this.prefix}/namespaces/${namespaceToPath2(namespace.namespace)}/tables`,
      body: request,
      headers
    });
    return response.data.metadata;
  }
  async updateTable(id, request) {
    const response = await this.client.request({
      method: "POST",
      path: `${this.prefix}/namespaces/${namespaceToPath2(id.namespace)}/tables/${id.name}`,
      body: request
    });
    return {
      "metadata-location": response.data["metadata-location"],
      metadata: response.data.metadata
    };
  }
  async dropTable(id, options) {
    await this.client.request({
      method: "DELETE",
      path: `${this.prefix}/namespaces/${namespaceToPath2(id.namespace)}/tables/${id.name}`,
      query: { purgeRequested: String(options?.purge ?? false) }
    });
  }
  async loadTable(id) {
    const headers = {};
    if (this.accessDelegation) {
      headers["X-Iceberg-Access-Delegation"] = this.accessDelegation;
    }
    const response = await this.client.request({
      method: "GET",
      path: `${this.prefix}/namespaces/${namespaceToPath2(id.namespace)}/tables/${id.name}`,
      headers
    });
    return response.data.metadata;
  }
  async tableExists(id) {
    const headers = {};
    if (this.accessDelegation) {
      headers["X-Iceberg-Access-Delegation"] = this.accessDelegation;
    }
    try {
      await this.client.request({
        method: "HEAD",
        path: `${this.prefix}/namespaces/${namespaceToPath2(id.namespace)}/tables/${id.name}`,
        headers
      });
      return true;
    } catch (error) {
      if (error instanceof IcebergError && error.status === 404) {
        return false;
      }
      throw error;
    }
  }
  async createTableIfNotExists(namespace, request) {
    try {
      return await this.createTable(namespace, request);
    } catch (error) {
      if (error instanceof IcebergError && error.status === 409) {
        return await this.loadTable({ namespace: namespace.namespace, name: request.name });
      }
      throw error;
    }
  }
};

// src/catalog/IcebergRestCatalog.ts
var IcebergRestCatalog = class {
  /**
   * Creates a new Iceberg REST Catalog client.
   *
   * @param options - Configuration options for the catalog client
   */
  constructor(options) {
    let prefix = "v1";
    if (options.catalogName) {
      prefix += `/${options.catalogName}`;
    }
    const baseUrl = options.baseUrl.endsWith("/") ? options.baseUrl : `${options.baseUrl}/`;
    this.client = createFetchClient({
      baseUrl,
      auth: options.auth,
      fetchImpl: options.fetch
    });
    this.accessDelegation = options.accessDelegation?.join(",");
    this.namespaceOps = new NamespaceOperations(this.client, prefix);
    this.tableOps = new TableOperations(this.client, prefix, this.accessDelegation);
  }
  /**
   * Lists all namespaces in the catalog.
   *
   * @param parent - Optional parent namespace to list children under
   * @returns Array of namespace identifiers
   *
   * @example
   * ```typescript
   * // List all top-level namespaces
   * const namespaces = await catalog.listNamespaces();
   *
   * // List namespaces under a parent
   * const children = await catalog.listNamespaces({ namespace: ['analytics'] });
   * ```
   */
  async listNamespaces(parent) {
    return this.namespaceOps.listNamespaces(parent);
  }
  /**
   * Creates a new namespace in the catalog.
   *
   * @param id - Namespace identifier to create
   * @param metadata - Optional metadata properties for the namespace
   * @returns Response containing the created namespace and its properties
   *
   * @example
   * ```typescript
   * const response = await catalog.createNamespace(
   *   { namespace: ['analytics'] },
   *   { properties: { owner: 'data-team' } }
   * );
   * console.log(response.namespace); // ['analytics']
   * console.log(response.properties); // { owner: 'data-team', ... }
   * ```
   */
  async createNamespace(id, metadata) {
    return this.namespaceOps.createNamespace(id, metadata);
  }
  /**
   * Drops a namespace from the catalog.
   *
   * The namespace must be empty (contain no tables) before it can be dropped.
   *
   * @param id - Namespace identifier to drop
   *
   * @example
   * ```typescript
   * await catalog.dropNamespace({ namespace: ['analytics'] });
   * ```
   */
  async dropNamespace(id) {
    await this.namespaceOps.dropNamespace(id);
  }
  /**
   * Loads metadata for a namespace.
   *
   * @param id - Namespace identifier to load
   * @returns Namespace metadata including properties
   *
   * @example
   * ```typescript
   * const metadata = await catalog.loadNamespaceMetadata({ namespace: ['analytics'] });
   * console.log(metadata.properties);
   * ```
   */
  async loadNamespaceMetadata(id) {
    return this.namespaceOps.loadNamespaceMetadata(id);
  }
  /**
   * Lists all tables in a namespace.
   *
   * @param namespace - Namespace identifier to list tables from
   * @returns Array of table identifiers
   *
   * @example
   * ```typescript
   * const tables = await catalog.listTables({ namespace: ['analytics'] });
   * console.log(tables); // [{ namespace: ['analytics'], name: 'events' }, ...]
   * ```
   */
  async listTables(namespace) {
    return this.tableOps.listTables(namespace);
  }
  /**
   * Creates a new table in the catalog.
   *
   * @param namespace - Namespace to create the table in
   * @param request - Table creation request including name, schema, partition spec, etc.
   * @returns Table metadata for the created table
   *
   * @example
   * ```typescript
   * const metadata = await catalog.createTable(
   *   { namespace: ['analytics'] },
   *   {
   *     name: 'events',
   *     schema: {
   *       type: 'struct',
   *       fields: [
   *         { id: 1, name: 'id', type: 'long', required: true },
   *         { id: 2, name: 'timestamp', type: 'timestamp', required: true }
   *       ],
   *       'schema-id': 0
   *     },
   *     'partition-spec': {
   *       'spec-id': 0,
   *       fields: [
   *         { source_id: 2, field_id: 1000, name: 'ts_day', transform: 'day' }
   *       ]
   *     }
   *   }
   * );
   * ```
   */
  async createTable(namespace, request) {
    return this.tableOps.createTable(namespace, request);
  }
  /**
   * Updates an existing table's metadata.
   *
   * Can update the schema, partition spec, or properties of a table.
   *
   * @param id - Table identifier to update
   * @param request - Update request with fields to modify
   * @returns Response containing the metadata location and updated table metadata
   *
   * @example
   * ```typescript
   * const response = await catalog.updateTable(
   *   { namespace: ['analytics'], name: 'events' },
   *   {
   *     properties: { 'read.split.target-size': '134217728' }
   *   }
   * );
   * console.log(response['metadata-location']); // s3://...
   * console.log(response.metadata); // TableMetadata object
   * ```
   */
  async updateTable(id, request) {
    return this.tableOps.updateTable(id, request);
  }
  /**
   * Drops a table from the catalog.
   *
   * @param id - Table identifier to drop
   *
   * @example
   * ```typescript
   * await catalog.dropTable({ namespace: ['analytics'], name: 'events' });
   * ```
   */
  async dropTable(id, options) {
    await this.tableOps.dropTable(id, options);
  }
  /**
   * Loads metadata for a table.
   *
   * @param id - Table identifier to load
   * @returns Table metadata including schema, partition spec, location, etc.
   *
   * @example
   * ```typescript
   * const metadata = await catalog.loadTable({ namespace: ['analytics'], name: 'events' });
   * console.log(metadata.schema);
   * console.log(metadata.location);
   * ```
   */
  async loadTable(id) {
    return this.tableOps.loadTable(id);
  }
  /**
   * Checks if a namespace exists in the catalog.
   *
   * @param id - Namespace identifier to check
   * @returns True if the namespace exists, false otherwise
   *
   * @example
   * ```typescript
   * const exists = await catalog.namespaceExists({ namespace: ['analytics'] });
   * console.log(exists); // true or false
   * ```
   */
  async namespaceExists(id) {
    return this.namespaceOps.namespaceExists(id);
  }
  /**
   * Checks if a table exists in the catalog.
   *
   * @param id - Table identifier to check
   * @returns True if the table exists, false otherwise
   *
   * @example
   * ```typescript
   * const exists = await catalog.tableExists({ namespace: ['analytics'], name: 'events' });
   * console.log(exists); // true or false
   * ```
   */
  async tableExists(id) {
    return this.tableOps.tableExists(id);
  }
  /**
   * Creates a namespace if it does not exist.
   *
   * If the namespace already exists, returns void. If created, returns the response.
   *
   * @param id - Namespace identifier to create
   * @param metadata - Optional metadata properties for the namespace
   * @returns Response containing the created namespace and its properties, or void if it already exists
   *
   * @example
   * ```typescript
   * const response = await catalog.createNamespaceIfNotExists(
   *   { namespace: ['analytics'] },
   *   { properties: { owner: 'data-team' } }
   * );
   * if (response) {
   *   console.log('Created:', response.namespace);
   * } else {
   *   console.log('Already exists');
   * }
   * ```
   */
  async createNamespaceIfNotExists(id, metadata) {
    return this.namespaceOps.createNamespaceIfNotExists(id, metadata);
  }
  /**
   * Creates a table if it does not exist.
   *
   * If the table already exists, returns its metadata instead.
   *
   * @param namespace - Namespace to create the table in
   * @param request - Table creation request including name, schema, partition spec, etc.
   * @returns Table metadata for the created or existing table
   *
   * @example
   * ```typescript
   * const metadata = await catalog.createTableIfNotExists(
   *   { namespace: ['analytics'] },
   *   {
   *     name: 'events',
   *     schema: {
   *       type: 'struct',
   *       fields: [
   *         { id: 1, name: 'id', type: 'long', required: true },
   *         { id: 2, name: 'timestamp', type: 'timestamp', required: true }
   *       ],
   *       'schema-id': 0
   *     }
   *   }
   * );
   * ```
   */
  async createTableIfNotExists(namespace, request) {
    return this.tableOps.createTableIfNotExists(namespace, request);
  }
};

// src/catalog/types.ts
var DECIMAL_REGEX = /^decimal\s*\(\s*(\d+)\s*,\s*(\d+)\s*\)$/;
var FIXED_REGEX = /^fixed\s*\[\s*(\d+)\s*\]$/;
function parseDecimalType(type) {
  const match = type.match(DECIMAL_REGEX);
  if (!match) return null;
  return {
    precision: parseInt(match[1], 10),
    scale: parseInt(match[2], 10)
  };
}
function parseFixedType(type) {
  const match = type.match(FIXED_REGEX);
  if (!match) return null;
  return {
    length: parseInt(match[1], 10)
  };
}
function isDecimalType(type) {
  return DECIMAL_REGEX.test(type);
}
function isFixedType(type) {
  return FIXED_REGEX.test(type);
}
function typesEqual(a, b) {
  const decimalA = parseDecimalType(a);
  const decimalB = parseDecimalType(b);
  if (decimalA && decimalB) {
    return decimalA.precision === decimalB.precision && decimalA.scale === decimalB.scale;
  }
  const fixedA = parseFixedType(a);
  const fixedB = parseFixedType(b);
  if (fixedA && fixedB) {
    return fixedA.length === fixedB.length;
  }
  return a === b;
}
function getCurrentSchema(metadata) {
  return metadata.schemas.find((s) => s["schema-id"] === metadata["current-schema-id"]);
}


//# sourceMappingURL=index.mjs.map
//# sourceMappingURL=index.mjs.map
;// CONCATENATED MODULE: ./node_modules/@supabase/storage-js/dist/index.mjs


//#region src/lib/common/errors.ts
/**
* Base error class for all Storage errors
* Supports both 'storage' and 'vectors' namespaces
*/
var StorageError = class extends Error {
	constructor(message, namespace = "storage", status, statusCode) {
		super(message);
		this.__isStorageError = true;
		this.namespace = namespace;
		this.name = namespace === "vectors" ? "StorageVectorsError" : "StorageError";
		this.status = status;
		this.statusCode = statusCode;
	}
};
/**
* Type guard to check if an error is a StorageError
* @param error - The error to check
* @returns True if the error is a StorageError
*/
function isStorageError(error) {
	return typeof error === "object" && error !== null && "__isStorageError" in error;
}
/**
* API error returned from Storage service
* Includes HTTP status code and service-specific error code
*/
var StorageApiError = class extends StorageError {
	constructor(message, status, statusCode, namespace = "storage") {
		super(message, namespace, status, statusCode);
		this.name = namespace === "vectors" ? "StorageVectorsApiError" : "StorageApiError";
		this.status = status;
		this.statusCode = statusCode;
	}
	toJSON() {
		return {
			name: this.name,
			message: this.message,
			status: this.status,
			statusCode: this.statusCode
		};
	}
};
/**
* Unknown error that doesn't match expected error patterns
* Wraps the original error for debugging
*/
var StorageUnknownError = class extends StorageError {
	constructor(message, originalError, namespace = "storage") {
		super(message, namespace);
		this.name = namespace === "vectors" ? "StorageVectorsUnknownError" : "StorageUnknownError";
		this.originalError = originalError;
	}
};
/**
* @deprecated Use StorageError with namespace='vectors' instead
* Alias for backward compatibility with existing vector storage code
*/
var StorageVectorsError = class extends (/* unused pure expression or super */ null && (StorageError)) {
	constructor(message) {
		super(message, "vectors");
	}
};
/**
* Type guard to check if an error is a StorageVectorsError
* @param error - The error to check
* @returns True if the error is a StorageVectorsError
*/
function isStorageVectorsError(error) {
	return isStorageError(error) && error["namespace"] === "vectors";
}
/**
* @deprecated Use StorageApiError with namespace='vectors' instead
* Alias for backward compatibility with existing vector storage code
*/
var StorageVectorsApiError = class extends (/* unused pure expression or super */ null && (StorageApiError)) {
	constructor(message, status, statusCode) {
		super(message, status, statusCode, "vectors");
	}
};
/**
* @deprecated Use StorageUnknownError with namespace='vectors' instead
* Alias for backward compatibility with existing vector storage code
*/
var StorageVectorsUnknownError = class extends (/* unused pure expression or super */ null && (StorageUnknownError)) {
	constructor(message, originalError) {
		super(message, originalError, "vectors");
	}
};
/**
* Error codes specific to S3 Vectors API
* Maps AWS service errors to application-friendly error codes
*/
let StorageVectorsErrorCode = /* @__PURE__ */ function(StorageVectorsErrorCode$1) {
	/** Internal server fault (HTTP 500) */
	StorageVectorsErrorCode$1["InternalError"] = "InternalError";
	/** Resource already exists / conflict (HTTP 409) */
	StorageVectorsErrorCode$1["S3VectorConflictException"] = "S3VectorConflictException";
	/** Resource not found (HTTP 404) */
	StorageVectorsErrorCode$1["S3VectorNotFoundException"] = "S3VectorNotFoundException";
	/** Delete bucket while not empty (HTTP 400) */
	StorageVectorsErrorCode$1["S3VectorBucketNotEmpty"] = "S3VectorBucketNotEmpty";
	/** Exceeds bucket quota/limit (HTTP 400) */
	StorageVectorsErrorCode$1["S3VectorMaxBucketsExceeded"] = "S3VectorMaxBucketsExceeded";
	/** Exceeds index quota/limit (HTTP 400) */
	StorageVectorsErrorCode$1["S3VectorMaxIndexesExceeded"] = "S3VectorMaxIndexesExceeded";
	return StorageVectorsErrorCode$1;
}({});

//#endregion
//#region src/lib/common/helpers.ts
/**
* Resolves the fetch implementation to use
* Uses custom fetch if provided, otherwise uses native fetch
*
* @param customFetch - Optional custom fetch implementation
* @returns Resolved fetch function
*/
const resolveFetch = (customFetch) => {
	if (customFetch) return (...args) => customFetch(...args);
	return (...args) => fetch(...args);
};
/**
* Determine if input is a plain object
* An object is plain if it's created by either {}, new Object(), or Object.create(null)
*
* @param value - Value to check
* @returns True if value is a plain object
* @source https://github.com/sindresorhus/is-plain-obj
*/
const isPlainObject = (value) => {
	if (typeof value !== "object" || value === null) return false;
	const prototype = Object.getPrototypeOf(value);
	return (prototype === null || prototype === Object.prototype || Object.getPrototypeOf(prototype) === null) && !(Symbol.toStringTag in value) && !(Symbol.iterator in value);
};
/**
* Recursively converts object keys from snake_case to camelCase
* Used for normalizing API responses
*
* @param item - Object to convert
* @returns Converted object with camelCase keys
*/
const recursiveToCamel = (item) => {
	if (Array.isArray(item)) return item.map((el) => recursiveToCamel(el));
	else if (typeof item === "function" || item !== Object(item)) return item;
	const result = {};
	Object.entries(item).forEach(([key, value]) => {
		const newKey = key.replace(/([-_][a-z])/gi, (c) => c.toUpperCase().replace(/[-_]/g, ""));
		result[newKey] = recursiveToCamel(value);
	});
	return result;
};
/**
* Validates if a given bucket name is valid according to Supabase Storage API rules
* Mirrors backend validation from: storage/src/storage/limits.ts:isValidBucketName()
*
* Rules:
* - Length: 1-100 characters
* - Allowed characters: alphanumeric (a-z, A-Z, 0-9), underscore (_), and safe special characters
* - Safe special characters: ! - . * ' ( ) space & $ @ = ; : + , ?
* - Forbidden: path separators (/, \), path traversal (..), leading/trailing whitespace
*
* AWS S3 Reference: https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html
*
* @param bucketName - The bucket name to validate
* @returns true if valid, false otherwise
*/
const isValidBucketName = (bucketName) => {
	if (!bucketName || typeof bucketName !== "string") return false;
	if (bucketName.length === 0 || bucketName.length > 100) return false;
	if (bucketName.trim() !== bucketName) return false;
	if (bucketName.includes("/") || bucketName.includes("\\")) return false;
	return /^[\w!.\*'() &$@=;:+,?-]+$/.test(bucketName);
};

//#endregion
//#region \0@oxc-project+runtime@0.101.0/helpers/typeof.js
function dist_typeof(o) {
	"@babel/helpers - typeof";
	return dist_typeof = "function" == typeof Symbol && "symbol" == typeof Symbol.iterator ? function(o$1) {
		return typeof o$1;
	} : function(o$1) {
		return o$1 && "function" == typeof Symbol && o$1.constructor === Symbol && o$1 !== Symbol.prototype ? "symbol" : typeof o$1;
	}, dist_typeof(o);
}

//#endregion
//#region \0@oxc-project+runtime@0.101.0/helpers/toPrimitive.js
function dist_toPrimitive(t, r) {
	if ("object" != dist_typeof(t) || !t) return t;
	var e = t[Symbol.toPrimitive];
	if (void 0 !== e) {
		var i = e.call(t, r || "default");
		if ("object" != dist_typeof(i)) return i;
		throw new TypeError("@@toPrimitive must return a primitive value.");
	}
	return ("string" === r ? String : Number)(t);
}

//#endregion
//#region \0@oxc-project+runtime@0.101.0/helpers/toPropertyKey.js
function dist_toPropertyKey(t) {
	var i = dist_toPrimitive(t, "string");
	return "symbol" == dist_typeof(i) ? i : i + "";
}

//#endregion
//#region \0@oxc-project+runtime@0.101.0/helpers/defineProperty.js
function dist_defineProperty(e, r, t) {
	return (r = dist_toPropertyKey(r)) in e ? Object.defineProperty(e, r, {
		value: t,
		enumerable: !0,
		configurable: !0,
		writable: !0
	}) : e[r] = t, e;
}

//#endregion
//#region \0@oxc-project+runtime@0.101.0/helpers/objectSpread2.js
function dist_ownKeys(e, r) {
	var t = Object.keys(e);
	if (Object.getOwnPropertySymbols) {
		var o = Object.getOwnPropertySymbols(e);
		r && (o = o.filter(function(r$1) {
			return Object.getOwnPropertyDescriptor(e, r$1).enumerable;
		})), t.push.apply(t, o);
	}
	return t;
}
function dist_objectSpread2(e) {
	for (var r = 1; r < arguments.length; r++) {
		var t = null != arguments[r] ? arguments[r] : {};
		r % 2 ? dist_ownKeys(Object(t), !0).forEach(function(r$1) {
			dist_defineProperty(e, r$1, t[r$1]);
		}) : Object.getOwnPropertyDescriptors ? Object.defineProperties(e, Object.getOwnPropertyDescriptors(t)) : dist_ownKeys(Object(t)).forEach(function(r$1) {
			Object.defineProperty(e, r$1, Object.getOwnPropertyDescriptor(t, r$1));
		});
	}
	return e;
}

//#endregion
//#region src/lib/common/fetch.ts
/**
* Extracts error message from various error response formats
* @param err - Error object from API
* @returns Human-readable error message
*/
const _getErrorMessage = (err) => {
	var _err$error;
	return err.msg || err.message || err.error_description || (typeof err.error === "string" ? err.error : (_err$error = err.error) === null || _err$error === void 0 ? void 0 : _err$error.message) || JSON.stringify(err);
};
/**
* Handles fetch errors and converts them to Storage error types
* @param error - The error caught from fetch
* @param reject - Promise rejection function
* @param options - Fetch options that may affect error handling
* @param namespace - Error namespace ('storage' or 'vectors')
*/
const handleError = async (error, reject, options, namespace) => {
	if (error && typeof error === "object" && "status" in error && "ok" in error && typeof error.status === "number" && !(options === null || options === void 0 ? void 0 : options.noResolveJson)) {
		const responseError = error;
		const status = responseError.status || 500;
		if (typeof responseError.json === "function") responseError.json().then((err) => {
			const statusCode = (err === null || err === void 0 ? void 0 : err.statusCode) || (err === null || err === void 0 ? void 0 : err.code) || status + "";
			reject(new StorageApiError(_getErrorMessage(err), status, statusCode, namespace));
		}).catch(() => {
			if (namespace === "vectors") {
				const statusCode = status + "";
				reject(new StorageApiError(responseError.statusText || `HTTP ${status} error`, status, statusCode, namespace));
			} else {
				const statusCode = status + "";
				reject(new StorageApiError(responseError.statusText || `HTTP ${status} error`, status, statusCode, namespace));
			}
		});
		else {
			const statusCode = status + "";
			reject(new StorageApiError(responseError.statusText || `HTTP ${status} error`, status, statusCode, namespace));
		}
	} else reject(new StorageUnknownError(_getErrorMessage(error), error, namespace));
};
/**
* Builds request parameters for fetch calls
* @param method - HTTP method
* @param options - Custom fetch options
* @param parameters - Additional fetch parameters like AbortSignal
* @param body - Request body (will be JSON stringified if plain object)
* @returns Complete fetch request parameters
*/
const _getRequestParams = (method, options, parameters, body) => {
	const params = {
		method,
		headers: (options === null || options === void 0 ? void 0 : options.headers) || {}
	};
	if (method === "GET" || method === "HEAD" || !body) return dist_objectSpread2(dist_objectSpread2({}, params), parameters);
	if (isPlainObject(body)) {
		params.headers = dist_objectSpread2({ "Content-Type": "application/json" }, options === null || options === void 0 ? void 0 : options.headers);
		params.body = JSON.stringify(body);
	} else params.body = body;
	if (options === null || options === void 0 ? void 0 : options.duplex) params.duplex = options.duplex;
	return dist_objectSpread2(dist_objectSpread2({}, params), parameters);
};
/**
* Internal request handler that wraps fetch with error handling
* @param fetcher - Fetch function to use
* @param method - HTTP method
* @param url - Request URL
* @param options - Custom fetch options
* @param parameters - Additional fetch parameters
* @param body - Request body
* @param namespace - Error namespace ('storage' or 'vectors')
* @returns Promise with parsed response or error
*/
async function _handleRequest(fetcher, method, url, options, parameters, body, namespace) {
	return new Promise((resolve, reject) => {
		fetcher(url, _getRequestParams(method, options, parameters, body)).then((result) => {
			if (!result.ok) throw result;
			if (options === null || options === void 0 ? void 0 : options.noResolveJson) return result;
			if (namespace === "vectors") {
				const contentType = result.headers.get("content-type");
				if (result.headers.get("content-length") === "0" || result.status === 204) return {};
				if (!contentType || !contentType.includes("application/json")) return {};
			}
			return result.json();
		}).then((data) => resolve(data)).catch((error) => handleError(error, reject, options, namespace));
	});
}
/**
* Creates a fetch API with the specified namespace
* @param namespace - Error namespace ('storage' or 'vectors')
* @returns Object with HTTP method functions
*/
function createFetchApi(namespace = "storage") {
	return {
		get: async (fetcher, url, options, parameters) => {
			return _handleRequest(fetcher, "GET", url, options, parameters, void 0, namespace);
		},
		post: async (fetcher, url, body, options, parameters) => {
			return _handleRequest(fetcher, "POST", url, options, parameters, body, namespace);
		},
		put: async (fetcher, url, body, options, parameters) => {
			return _handleRequest(fetcher, "PUT", url, options, parameters, body, namespace);
		},
		head: async (fetcher, url, options, parameters) => {
			return _handleRequest(fetcher, "HEAD", url, dist_objectSpread2(dist_objectSpread2({}, options), {}, { noResolveJson: true }), parameters, void 0, namespace);
		},
		remove: async (fetcher, url, body, options, parameters) => {
			return _handleRequest(fetcher, "DELETE", url, options, parameters, body, namespace);
		}
	};
}
const defaultApi = createFetchApi("storage");
const { get, post, put, head, remove } = defaultApi;
const vectorsApi = createFetchApi("vectors");

//#endregion
//#region src/lib/common/BaseApiClient.ts
/**
* @ignore
* Base API client class for all Storage API classes
* Provides common infrastructure for error handling and configuration
*
* @typeParam TError - The error type (StorageError or subclass)
*/
var BaseApiClient = class {
	/**
	* Creates a new BaseApiClient instance
	* @param url - Base URL for API requests
	* @param headers - Default headers for API requests
	* @param fetch - Optional custom fetch implementation
	* @param namespace - Error namespace ('storage' or 'vectors')
	*/
	constructor(url, headers = {}, fetch$1, namespace = "storage") {
		this.shouldThrowOnError = false;
		this.url = url;
		this.headers = headers;
		this.fetch = resolveFetch(fetch$1);
		this.namespace = namespace;
	}
	/**
	* Enable throwing errors instead of returning them.
	* When enabled, errors are thrown instead of returned in { data, error } format.
	*
	* @returns this - For method chaining
	*/
	throwOnError() {
		this.shouldThrowOnError = true;
		return this;
	}
	/**
	* Set an HTTP header for the request.
	* Creates a shallow copy of headers to avoid mutating shared state.
	*
	* @param name - Header name
	* @param value - Header value
	* @returns this - For method chaining
	*/
	setHeader(name, value) {
		this.headers = dist_objectSpread2(dist_objectSpread2({}, this.headers), {}, { [name]: value });
		return this;
	}
	/**
	* Handles API operation with standardized error handling
	* Eliminates repetitive try-catch blocks across all API methods
	*
	* This wrapper:
	* 1. Executes the operation
	* 2. Returns { data, error: null } on success
	* 3. Returns { data: null, error } on failure (if shouldThrowOnError is false)
	* 4. Throws error on failure (if shouldThrowOnError is true)
	*
	* @typeParam T - The expected data type from the operation
	* @param operation - Async function that performs the API call
	* @returns Promise with { data, error } tuple
	*
	* @example
	* ```typescript
	* async listBuckets() {
	*   return this.handleOperation(async () => {
	*     return await get(this.fetch, `${this.url}/bucket`, {
	*       headers: this.headers,
	*     })
	*   })
	* }
	* ```
	*/
	async handleOperation(operation) {
		var _this = this;
		try {
			return {
				data: await operation(),
				error: null
			};
		} catch (error) {
			if (_this.shouldThrowOnError) throw error;
			if (isStorageError(error)) return {
				data: null,
				error
			};
			throw error;
		}
	}
};

//#endregion
//#region src/packages/StreamDownloadBuilder.ts
var StreamDownloadBuilder = class {
	constructor(downloadFn, shouldThrowOnError) {
		this.downloadFn = downloadFn;
		this.shouldThrowOnError = shouldThrowOnError;
	}
	then(onfulfilled, onrejected) {
		return this.execute().then(onfulfilled, onrejected);
	}
	async execute() {
		var _this = this;
		try {
			return {
				data: (await _this.downloadFn()).body,
				error: null
			};
		} catch (error) {
			if (_this.shouldThrowOnError) throw error;
			if (isStorageError(error)) return {
				data: null,
				error
			};
			throw error;
		}
	}
};

//#endregion
//#region src/packages/BlobDownloadBuilder.ts
let _Symbol$toStringTag;
_Symbol$toStringTag = Symbol.toStringTag;
var BlobDownloadBuilder = class {
	constructor(downloadFn, shouldThrowOnError) {
		this.downloadFn = downloadFn;
		this.shouldThrowOnError = shouldThrowOnError;
		this[_Symbol$toStringTag] = "BlobDownloadBuilder";
		this.promise = null;
	}
	asStream() {
		return new StreamDownloadBuilder(this.downloadFn, this.shouldThrowOnError);
	}
	then(onfulfilled, onrejected) {
		return this.getPromise().then(onfulfilled, onrejected);
	}
	catch(onrejected) {
		return this.getPromise().catch(onrejected);
	}
	finally(onfinally) {
		return this.getPromise().finally(onfinally);
	}
	getPromise() {
		if (!this.promise) this.promise = this.execute();
		return this.promise;
	}
	async execute() {
		var _this = this;
		try {
			return {
				data: await (await _this.downloadFn()).blob(),
				error: null
			};
		} catch (error) {
			if (_this.shouldThrowOnError) throw error;
			if (isStorageError(error)) return {
				data: null,
				error
			};
			throw error;
		}
	}
};

//#endregion
//#region src/packages/StorageFileApi.ts
const DEFAULT_SEARCH_OPTIONS = {
	limit: 100,
	offset: 0,
	sortBy: {
		column: "name",
		order: "asc"
	}
};
const DEFAULT_FILE_OPTIONS = {
	cacheControl: "3600",
	contentType: "text/plain;charset=UTF-8",
	upsert: false
};
var StorageFileApi = class extends BaseApiClient {
	constructor(url, headers = {}, bucketId, fetch$1) {
		super(url, headers, fetch$1, "storage");
		this.bucketId = bucketId;
	}
	/**
	* Uploads a file to an existing bucket or replaces an existing file at the specified path with a new one.
	*
	* @param method HTTP method.
	* @param path The relative file path. Should be of the format `folder/subfolder/filename.png`. The bucket must already exist before attempting to upload.
	* @param fileBody The body of the file to be stored in the bucket.
	*/
	async uploadOrUpdate(method, path, fileBody, fileOptions) {
		var _this = this;
		return _this.handleOperation(async () => {
			let body;
			const options = dist_objectSpread2(dist_objectSpread2({}, DEFAULT_FILE_OPTIONS), fileOptions);
			let headers = dist_objectSpread2(dist_objectSpread2({}, _this.headers), method === "POST" && { "x-upsert": String(options.upsert) });
			const metadata = options.metadata;
			if (typeof Blob !== "undefined" && fileBody instanceof Blob) {
				body = new FormData();
				body.append("cacheControl", options.cacheControl);
				if (metadata) body.append("metadata", _this.encodeMetadata(metadata));
				body.append("", fileBody);
			} else if (typeof FormData !== "undefined" && fileBody instanceof FormData) {
				body = fileBody;
				if (!body.has("cacheControl")) body.append("cacheControl", options.cacheControl);
				if (metadata && !body.has("metadata")) body.append("metadata", _this.encodeMetadata(metadata));
			} else {
				body = fileBody;
				headers["cache-control"] = `max-age=${options.cacheControl}`;
				headers["content-type"] = options.contentType;
				if (metadata) headers["x-metadata"] = _this.toBase64(_this.encodeMetadata(metadata));
				if ((typeof ReadableStream !== "undefined" && body instanceof ReadableStream || body && typeof body === "object" && "pipe" in body && typeof body.pipe === "function") && !options.duplex) options.duplex = "half";
			}
			if (fileOptions === null || fileOptions === void 0 ? void 0 : fileOptions.headers) headers = dist_objectSpread2(dist_objectSpread2({}, headers), fileOptions.headers);
			const cleanPath = _this._removeEmptyFolders(path);
			const _path = _this._getFinalPath(cleanPath);
			const data = await (method == "PUT" ? put : post)(_this.fetch, `${_this.url}/object/${_path}`, body, dist_objectSpread2({ headers }, (options === null || options === void 0 ? void 0 : options.duplex) ? { duplex: options.duplex } : {}));
			return {
				path: cleanPath,
				id: data.Id,
				fullPath: data.Key
			};
		});
	}
	/**
	* Uploads a file to an existing bucket.
	*
	* @category File Buckets
	* @param path The file path, including the file name. Should be of the format `folder/subfolder/filename.png`. The bucket must already exist before attempting to upload.
	* @param fileBody The body of the file to be stored in the bucket.
	* @param fileOptions Optional file upload options including cacheControl, contentType, upsert, and metadata.
	* @returns Promise with response containing file path, id, and fullPath or error
	*
	* @example Upload file
	* ```js
	* const avatarFile = event.target.files[0]
	* const { data, error } = await supabase
	*   .storage
	*   .from('avatars')
	*   .upload('public/avatar1.png', avatarFile, {
	*     cacheControl: '3600',
	*     upsert: false
	*   })
	* ```
	*
	* Response:
	* ```json
	* {
	*   "data": {
	*     "path": "public/avatar1.png",
	*     "fullPath": "avatars/public/avatar1.png"
	*   },
	*   "error": null
	* }
	* ```
	*
	* @example Upload file using `ArrayBuffer` from base64 file data
	* ```js
	* import { decode } from 'base64-arraybuffer'
	*
	* const { data, error } = await supabase
	*   .storage
	*   .from('avatars')
	*   .upload('public/avatar1.png', decode('base64FileData'), {
	*     contentType: 'image/png'
	*   })
	* ```
	*/
	async upload(path, fileBody, fileOptions) {
		return this.uploadOrUpdate("POST", path, fileBody, fileOptions);
	}
	/**
	* Upload a file with a token generated from `createSignedUploadUrl`.
	*
	* @category File Buckets
	* @param path The file path, including the file name. Should be of the format `folder/subfolder/filename.png`. The bucket must already exist before attempting to upload.
	* @param token The token generated from `createSignedUploadUrl`
	* @param fileBody The body of the file to be stored in the bucket.
	* @param fileOptions HTTP headers (cacheControl, contentType, etc.).
	* **Note:** The `upsert` option has no effect here. To enable upsert behavior,
	* pass `{ upsert: true }` when calling `createSignedUploadUrl()` instead.
	* @returns Promise with response containing file path and fullPath or error
	*
	* @example Upload to a signed URL
	* ```js
	* const { data, error } = await supabase
	*   .storage
	*   .from('avatars')
	*   .uploadToSignedUrl('folder/cat.jpg', 'token-from-createSignedUploadUrl', file)
	* ```
	*
	* Response:
	* ```json
	* {
	*   "data": {
	*     "path": "folder/cat.jpg",
	*     "fullPath": "avatars/folder/cat.jpg"
	*   },
	*   "error": null
	* }
	* ```
	*/
	async uploadToSignedUrl(path, token, fileBody, fileOptions) {
		var _this3 = this;
		const cleanPath = _this3._removeEmptyFolders(path);
		const _path = _this3._getFinalPath(cleanPath);
		const url = new URL(_this3.url + `/object/upload/sign/${_path}`);
		url.searchParams.set("token", token);
		return _this3.handleOperation(async () => {
			let body;
			const options = dist_objectSpread2({ upsert: DEFAULT_FILE_OPTIONS.upsert }, fileOptions);
			const headers = dist_objectSpread2(dist_objectSpread2({}, _this3.headers), { "x-upsert": String(options.upsert) });
			if (typeof Blob !== "undefined" && fileBody instanceof Blob) {
				body = new FormData();
				body.append("cacheControl", options.cacheControl);
				body.append("", fileBody);
			} else if (typeof FormData !== "undefined" && fileBody instanceof FormData) {
				body = fileBody;
				body.append("cacheControl", options.cacheControl);
			} else {
				body = fileBody;
				headers["cache-control"] = `max-age=${options.cacheControl}`;
				headers["content-type"] = options.contentType;
			}
			return {
				path: cleanPath,
				fullPath: (await put(_this3.fetch, url.toString(), body, { headers })).Key
			};
		});
	}
	/**
	* Creates a signed upload URL.
	* Signed upload URLs can be used to upload files to the bucket without further authentication.
	* They are valid for 2 hours.
	*
	* @category File Buckets
	* @param path The file path, including the current file name. For example `folder/image.png`.
	* @param options.upsert If set to true, allows the file to be overwritten if it already exists.
	* @returns Promise with response containing signed upload URL, token, and path or error
	*
	* @example Create Signed Upload URL
	* ```js
	* const { data, error } = await supabase
	*   .storage
	*   .from('avatars')
	*   .createSignedUploadUrl('folder/cat.jpg')
	* ```
	*
	* Response:
	* ```json
	* {
	*   "data": {
	*     "signedUrl": "https://example.supabase.co/storage/v1/object/upload/sign/avatars/folder/cat.jpg?token=<TOKEN>",
	*     "path": "folder/cat.jpg",
	*     "token": "<TOKEN>"
	*   },
	*   "error": null
	* }
	* ```
	*/
	async createSignedUploadUrl(path, options) {
		var _this4 = this;
		return _this4.handleOperation(async () => {
			let _path = _this4._getFinalPath(path);
			const headers = dist_objectSpread2({}, _this4.headers);
			if (options === null || options === void 0 ? void 0 : options.upsert) headers["x-upsert"] = "true";
			const data = await post(_this4.fetch, `${_this4.url}/object/upload/sign/${_path}`, {}, { headers });
			const url = new URL(_this4.url + data.url);
			const token = url.searchParams.get("token");
			if (!token) throw new StorageError("No token returned by API");
			return {
				signedUrl: url.toString(),
				path,
				token
			};
		});
	}
	/**
	* Replaces an existing file at the specified path with a new one.
	*
	* @category File Buckets
	* @param path The relative file path. Should be of the format `folder/subfolder/filename.png`. The bucket must already exist before attempting to update.
	* @param fileBody The body of the file to be stored in the bucket.
	* @param fileOptions Optional file upload options including cacheControl, contentType, upsert, and metadata.
	* @returns Promise with response containing file path, id, and fullPath or error
	*
	* @example Update file
	* ```js
	* const avatarFile = event.target.files[0]
	* const { data, error } = await supabase
	*   .storage
	*   .from('avatars')
	*   .update('public/avatar1.png', avatarFile, {
	*     cacheControl: '3600',
	*     upsert: true
	*   })
	* ```
	*
	* Response:
	* ```json
	* {
	*   "data": {
	*     "path": "public/avatar1.png",
	*     "fullPath": "avatars/public/avatar1.png"
	*   },
	*   "error": null
	* }
	* ```
	*
	* @example Update file using `ArrayBuffer` from base64 file data
	* ```js
	* import {decode} from 'base64-arraybuffer'
	*
	* const { data, error } = await supabase
	*   .storage
	*   .from('avatars')
	*   .update('public/avatar1.png', decode('base64FileData'), {
	*     contentType: 'image/png'
	*   })
	* ```
	*/
	async update(path, fileBody, fileOptions) {
		return this.uploadOrUpdate("PUT", path, fileBody, fileOptions);
	}
	/**
	* Moves an existing file to a new path in the same bucket.
	*
	* @category File Buckets
	* @param fromPath The original file path, including the current file name. For example `folder/image.png`.
	* @param toPath The new file path, including the new file name. For example `folder/image-new.png`.
	* @param options The destination options.
	* @returns Promise with response containing success message or error
	*
	* @example Move file
	* ```js
	* const { data, error } = await supabase
	*   .storage
	*   .from('avatars')
	*   .move('public/avatar1.png', 'private/avatar2.png')
	* ```
	*
	* Response:
	* ```json
	* {
	*   "data": {
	*     "message": "Successfully moved"
	*   },
	*   "error": null
	* }
	* ```
	*/
	async move(fromPath, toPath, options) {
		var _this6 = this;
		return _this6.handleOperation(async () => {
			return await post(_this6.fetch, `${_this6.url}/object/move`, {
				bucketId: _this6.bucketId,
				sourceKey: fromPath,
				destinationKey: toPath,
				destinationBucket: options === null || options === void 0 ? void 0 : options.destinationBucket
			}, { headers: _this6.headers });
		});
	}
	/**
	* Copies an existing file to a new path in the same bucket.
	*
	* @category File Buckets
	* @param fromPath The original file path, including the current file name. For example `folder/image.png`.
	* @param toPath The new file path, including the new file name. For example `folder/image-copy.png`.
	* @param options The destination options.
	* @returns Promise with response containing copied file path or error
	*
	* @example Copy file
	* ```js
	* const { data, error } = await supabase
	*   .storage
	*   .from('avatars')
	*   .copy('public/avatar1.png', 'private/avatar2.png')
	* ```
	*
	* Response:
	* ```json
	* {
	*   "data": {
	*     "path": "avatars/private/avatar2.png"
	*   },
	*   "error": null
	* }
	* ```
	*/
	async copy(fromPath, toPath, options) {
		var _this7 = this;
		return _this7.handleOperation(async () => {
			return { path: (await post(_this7.fetch, `${_this7.url}/object/copy`, {
				bucketId: _this7.bucketId,
				sourceKey: fromPath,
				destinationKey: toPath,
				destinationBucket: options === null || options === void 0 ? void 0 : options.destinationBucket
			}, { headers: _this7.headers })).Key };
		});
	}
	/**
	* Creates a signed URL. Use a signed URL to share a file for a fixed amount of time.
	*
	* @category File Buckets
	* @param path The file path, including the current file name. For example `folder/image.png`.
	* @param expiresIn The number of seconds until the signed URL expires. For example, `60` for a URL which is valid for one minute.
	* @param options.download triggers the file as a download if set to true. Set this parameter as the name of the file if you want to trigger the download with a different filename.
	* @param options.transform Transform the asset before serving it to the client.
	* @returns Promise with response containing signed URL or error
	*
	* @example Create Signed URL
	* ```js
	* const { data, error } = await supabase
	*   .storage
	*   .from('avatars')
	*   .createSignedUrl('folder/avatar1.png', 60)
	* ```
	*
	* Response:
	* ```json
	* {
	*   "data": {
	*     "signedUrl": "https://example.supabase.co/storage/v1/object/sign/avatars/folder/avatar1.png?token=<TOKEN>"
	*   },
	*   "error": null
	* }
	* ```
	*
	* @example Create a signed URL for an asset with transformations
	* ```js
	* const { data } = await supabase
	*   .storage
	*   .from('avatars')
	*   .createSignedUrl('folder/avatar1.png', 60, {
	*     transform: {
	*       width: 100,
	*       height: 100,
	*     }
	*   })
	* ```
	*
	* @example Create a signed URL which triggers the download of the asset
	* ```js
	* const { data } = await supabase
	*   .storage
	*   .from('avatars')
	*   .createSignedUrl('folder/avatar1.png', 60, {
	*     download: true,
	*   })
	* ```
	*/
	async createSignedUrl(path, expiresIn, options) {
		var _this8 = this;
		return _this8.handleOperation(async () => {
			let _path = _this8._getFinalPath(path);
			let data = await post(_this8.fetch, `${_this8.url}/object/sign/${_path}`, dist_objectSpread2({ expiresIn }, (options === null || options === void 0 ? void 0 : options.transform) ? { transform: options.transform } : {}), { headers: _this8.headers });
			const downloadQueryParam = (options === null || options === void 0 ? void 0 : options.download) ? `&download=${options.download === true ? "" : options.download}` : "";
			return { signedUrl: encodeURI(`${_this8.url}${data.signedURL}${downloadQueryParam}`) };
		});
	}
	/**
	* Creates multiple signed URLs. Use a signed URL to share a file for a fixed amount of time.
	*
	* @category File Buckets
	* @param paths The file paths to be downloaded, including the current file names. For example `['folder/image.png', 'folder2/image2.png']`.
	* @param expiresIn The number of seconds until the signed URLs expire. For example, `60` for URLs which are valid for one minute.
	* @param options.download triggers the file as a download if set to true. Set this parameter as the name of the file if you want to trigger the download with a different filename.
	* @returns Promise with response containing array of objects with signedUrl, path, and error or error
	*
	* @example Create Signed URLs
	* ```js
	* const { data, error } = await supabase
	*   .storage
	*   .from('avatars')
	*   .createSignedUrls(['folder/avatar1.png', 'folder/avatar2.png'], 60)
	* ```
	*
	* Response:
	* ```json
	* {
	*   "data": [
	*     {
	*       "error": null,
	*       "path": "folder/avatar1.png",
	*       "signedURL": "/object/sign/avatars/folder/avatar1.png?token=<TOKEN>",
	*       "signedUrl": "https://example.supabase.co/storage/v1/object/sign/avatars/folder/avatar1.png?token=<TOKEN>"
	*     },
	*     {
	*       "error": null,
	*       "path": "folder/avatar2.png",
	*       "signedURL": "/object/sign/avatars/folder/avatar2.png?token=<TOKEN>",
	*       "signedUrl": "https://example.supabase.co/storage/v1/object/sign/avatars/folder/avatar2.png?token=<TOKEN>"
	*     }
	*   ],
	*   "error": null
	* }
	* ```
	*/
	async createSignedUrls(paths, expiresIn, options) {
		var _this9 = this;
		return _this9.handleOperation(async () => {
			const data = await post(_this9.fetch, `${_this9.url}/object/sign/${_this9.bucketId}`, {
				expiresIn,
				paths
			}, { headers: _this9.headers });
			const downloadQueryParam = (options === null || options === void 0 ? void 0 : options.download) ? `&download=${options.download === true ? "" : options.download}` : "";
			return data.map((datum) => dist_objectSpread2(dist_objectSpread2({}, datum), {}, { signedUrl: datum.signedURL ? encodeURI(`${_this9.url}${datum.signedURL}${downloadQueryParam}`) : null }));
		});
	}
	/**
	* Downloads a file from a private bucket. For public buckets, make a request to the URL returned from `getPublicUrl` instead.
	*
	* @category File Buckets
	* @param path The full path and file name of the file to be downloaded. For example `folder/image.png`.
	* @param options.transform Transform the asset before serving it to the client.
	* @param parameters Additional fetch parameters like signal for cancellation. Supports standard fetch options including cache control.
	* @returns BlobDownloadBuilder instance for downloading the file
	*
	* @example Download file
	* ```js
	* const { data, error } = await supabase
	*   .storage
	*   .from('avatars')
	*   .download('folder/avatar1.png')
	* ```
	*
	* Response:
	* ```json
	* {
	*   "data": <BLOB>,
	*   "error": null
	* }
	* ```
	*
	* @example Download file with transformations
	* ```js
	* const { data, error } = await supabase
	*   .storage
	*   .from('avatars')
	*   .download('folder/avatar1.png', {
	*     transform: {
	*       width: 100,
	*       height: 100,
	*       quality: 80
	*     }
	*   })
	* ```
	*
	* @example Download with cache control (useful in Edge Functions)
	* ```js
	* const { data, error } = await supabase
	*   .storage
	*   .from('avatars')
	*   .download('folder/avatar1.png', {}, { cache: 'no-store' })
	* ```
	*
	* @example Download with abort signal
	* ```js
	* const controller = new AbortController()
	* setTimeout(() => controller.abort(), 5000)
	*
	* const { data, error } = await supabase
	*   .storage
	*   .from('avatars')
	*   .download('folder/avatar1.png', {}, { signal: controller.signal })
	* ```
	*/
	download(path, options, parameters) {
		const renderPath = typeof (options === null || options === void 0 ? void 0 : options.transform) !== "undefined" ? "render/image/authenticated" : "object";
		const transformationQuery = this.transformOptsToQueryString((options === null || options === void 0 ? void 0 : options.transform) || {});
		const queryString = transformationQuery ? `?${transformationQuery}` : "";
		const _path = this._getFinalPath(path);
		const downloadFn = () => get(this.fetch, `${this.url}/${renderPath}/${_path}${queryString}`, {
			headers: this.headers,
			noResolveJson: true
		}, parameters);
		return new BlobDownloadBuilder(downloadFn, this.shouldThrowOnError);
	}
	/**
	* Retrieves the details of an existing file.
	*
	* @category File Buckets
	* @param path The file path, including the file name. For example `folder/image.png`.
	* @returns Promise with response containing file metadata or error
	*
	* @example Get file info
	* ```js
	* const { data, error } = await supabase
	*   .storage
	*   .from('avatars')
	*   .info('folder/avatar1.png')
	* ```
	*/
	async info(path) {
		var _this10 = this;
		const _path = _this10._getFinalPath(path);
		return _this10.handleOperation(async () => {
			return recursiveToCamel(await get(_this10.fetch, `${_this10.url}/object/info/${_path}`, { headers: _this10.headers }));
		});
	}
	/**
	* Checks the existence of a file.
	*
	* @category File Buckets
	* @param path The file path, including the file name. For example `folder/image.png`.
	* @returns Promise with response containing boolean indicating file existence or error
	*
	* @example Check file existence
	* ```js
	* const { data, error } = await supabase
	*   .storage
	*   .from('avatars')
	*   .exists('folder/avatar1.png')
	* ```
	*/
	async exists(path) {
		var _this11 = this;
		const _path = _this11._getFinalPath(path);
		try {
			await head(_this11.fetch, `${_this11.url}/object/${_path}`, { headers: _this11.headers });
			return {
				data: true,
				error: null
			};
		} catch (error) {
			if (_this11.shouldThrowOnError) throw error;
			if (isStorageError(error) && error instanceof StorageUnknownError) {
				const originalError = error.originalError;
				if ([400, 404].includes(originalError === null || originalError === void 0 ? void 0 : originalError.status)) return {
					data: false,
					error
				};
			}
			throw error;
		}
	}
	/**
	* A simple convenience function to get the URL for an asset in a public bucket. If you do not want to use this function, you can construct the public URL by concatenating the bucket URL with the path to the asset.
	* This function does not verify if the bucket is public. If a public URL is created for a bucket which is not public, you will not be able to download the asset.
	*
	* @category File Buckets
	* @param path The path and name of the file to generate the public URL for. For example `folder/image.png`.
	* @param options.download Triggers the file as a download if set to true. Set this parameter as the name of the file if you want to trigger the download with a different filename.
	* @param options.transform Transform the asset before serving it to the client.
	* @returns Object with public URL
	*
	* @example Returns the URL for an asset in a public bucket
	* ```js
	* const { data } = supabase
	*   .storage
	*   .from('public-bucket')
	*   .getPublicUrl('folder/avatar1.png')
	* ```
	*
	* Response:
	* ```json
	* {
	*   "data": {
	*     "publicUrl": "https://example.supabase.co/storage/v1/object/public/public-bucket/folder/avatar1.png"
	*   }
	* }
	* ```
	*
	* @example Returns the URL for an asset in a public bucket with transformations
	* ```js
	* const { data } = supabase
	*   .storage
	*   .from('public-bucket')
	*   .getPublicUrl('folder/avatar1.png', {
	*     transform: {
	*       width: 100,
	*       height: 100,
	*     }
	*   })
	* ```
	*
	* @example Returns the URL which triggers the download of an asset in a public bucket
	* ```js
	* const { data } = supabase
	*   .storage
	*   .from('public-bucket')
	*   .getPublicUrl('folder/avatar1.png', {
	*     download: true,
	*   })
	* ```
	*/
	getPublicUrl(path, options) {
		const _path = this._getFinalPath(path);
		const _queryString = [];
		const downloadQueryParam = (options === null || options === void 0 ? void 0 : options.download) ? `download=${options.download === true ? "" : options.download}` : "";
		if (downloadQueryParam !== "") _queryString.push(downloadQueryParam);
		const renderPath = typeof (options === null || options === void 0 ? void 0 : options.transform) !== "undefined" ? "render/image" : "object";
		const transformationQuery = this.transformOptsToQueryString((options === null || options === void 0 ? void 0 : options.transform) || {});
		if (transformationQuery !== "") _queryString.push(transformationQuery);
		let queryString = _queryString.join("&");
		if (queryString !== "") queryString = `?${queryString}`;
		return { data: { publicUrl: encodeURI(`${this.url}/${renderPath}/public/${_path}${queryString}`) } };
	}
	/**
	* Deletes files within the same bucket
	*
	* @category File Buckets
	* @param paths An array of files to delete, including the path and file name. For example [`'folder/image.png'`].
	* @returns Promise with response containing array of deleted file objects or error
	*
	* @example Delete file
	* ```js
	* const { data, error } = await supabase
	*   .storage
	*   .from('avatars')
	*   .remove(['folder/avatar1.png'])
	* ```
	*
	* Response:
	* ```json
	* {
	*   "data": [],
	*   "error": null
	* }
	* ```
	*/
	async remove(paths) {
		var _this12 = this;
		return _this12.handleOperation(async () => {
			return await remove(_this12.fetch, `${_this12.url}/object/${_this12.bucketId}`, { prefixes: paths }, { headers: _this12.headers });
		});
	}
	/**
	* Get file metadata
	* @param id the file id to retrieve metadata
	*/
	/**
	* Update file metadata
	* @param id the file id to update metadata
	* @param meta the new file metadata
	*/
	/**
	* Lists all the files and folders within a path of the bucket.
	*
	* @category File Buckets
	* @param path The folder path.
	* @param options Search options including limit (defaults to 100), offset, sortBy, and search
	* @param parameters Optional fetch parameters including signal for cancellation
	* @returns Promise with response containing array of files or error
	*
	* @example List files in a bucket
	* ```js
	* const { data, error } = await supabase
	*   .storage
	*   .from('avatars')
	*   .list('folder', {
	*     limit: 100,
	*     offset: 0,
	*     sortBy: { column: 'name', order: 'asc' },
	*   })
	* ```
	*
	* Response:
	* ```json
	* {
	*   "data": [
	*     {
	*       "name": "avatar1.png",
	*       "id": "e668cf7f-821b-4a2f-9dce-7dfa5dd1cfd2",
	*       "updated_at": "2024-05-22T23:06:05.580Z",
	*       "created_at": "2024-05-22T23:04:34.443Z",
	*       "last_accessed_at": "2024-05-22T23:04:34.443Z",
	*       "metadata": {
	*         "eTag": "\"c5e8c553235d9af30ef4f6e280790b92\"",
	*         "size": 32175,
	*         "mimetype": "image/png",
	*         "cacheControl": "max-age=3600",
	*         "lastModified": "2024-05-22T23:06:05.574Z",
	*         "contentLength": 32175,
	*         "httpStatusCode": 200
	*       }
	*     }
	*   ],
	*   "error": null
	* }
	* ```
	*
	* @example Search files in a bucket
	* ```js
	* const { data, error } = await supabase
	*   .storage
	*   .from('avatars')
	*   .list('folder', {
	*     limit: 100,
	*     offset: 0,
	*     sortBy: { column: 'name', order: 'asc' },
	*     search: 'jon'
	*   })
	* ```
	*/
	async list(path, options, parameters) {
		var _this13 = this;
		return _this13.handleOperation(async () => {
			const body = dist_objectSpread2(dist_objectSpread2(dist_objectSpread2({}, DEFAULT_SEARCH_OPTIONS), options), {}, { prefix: path || "" });
			return await post(_this13.fetch, `${_this13.url}/object/list/${_this13.bucketId}`, body, { headers: _this13.headers }, parameters);
		});
	}
	/**
	* @experimental this method signature might change in the future
	*
	* @category File Buckets
	* @param options search options
	* @param parameters
	*/
	async listV2(options, parameters) {
		var _this14 = this;
		return _this14.handleOperation(async () => {
			const body = dist_objectSpread2({}, options);
			return await post(_this14.fetch, `${_this14.url}/object/list-v2/${_this14.bucketId}`, body, { headers: _this14.headers }, parameters);
		});
	}
	encodeMetadata(metadata) {
		return JSON.stringify(metadata);
	}
	toBase64(data) {
		if (typeof Buffer !== "undefined") return Buffer.from(data).toString("base64");
		return btoa(data);
	}
	_getFinalPath(path) {
		return `${this.bucketId}/${path.replace(/^\/+/, "")}`;
	}
	_removeEmptyFolders(path) {
		return path.replace(/^\/|\/$/g, "").replace(/\/+/g, "/");
	}
	transformOptsToQueryString(transform) {
		const params = [];
		if (transform.width) params.push(`width=${transform.width}`);
		if (transform.height) params.push(`height=${transform.height}`);
		if (transform.resize) params.push(`resize=${transform.resize}`);
		if (transform.format) params.push(`format=${transform.format}`);
		if (transform.quality) params.push(`quality=${transform.quality}`);
		return params.join("&");
	}
};

//#endregion
//#region src/lib/version.ts
const version = "2.98.0";

//#endregion
//#region src/lib/constants.ts
const DEFAULT_HEADERS = { "X-Client-Info": `storage-js/${version}` };

//#endregion
//#region src/packages/StorageBucketApi.ts
var StorageBucketApi = class extends BaseApiClient {
	constructor(url, headers = {}, fetch$1, opts) {
		const baseUrl = new URL(url);
		if (opts === null || opts === void 0 ? void 0 : opts.useNewHostname) {
			if (/supabase\.(co|in|red)$/.test(baseUrl.hostname) && !baseUrl.hostname.includes("storage.supabase.")) baseUrl.hostname = baseUrl.hostname.replace("supabase.", "storage.supabase.");
		}
		const finalUrl = baseUrl.href.replace(/\/$/, "");
		const finalHeaders = dist_objectSpread2(dist_objectSpread2({}, DEFAULT_HEADERS), headers);
		super(finalUrl, finalHeaders, fetch$1, "storage");
	}
	/**
	* Retrieves the details of all Storage buckets within an existing project.
	*
	* @category File Buckets
	* @param options Query parameters for listing buckets
	* @param options.limit Maximum number of buckets to return
	* @param options.offset Number of buckets to skip
	* @param options.sortColumn Column to sort by ('id', 'name', 'created_at', 'updated_at')
	* @param options.sortOrder Sort order ('asc' or 'desc')
	* @param options.search Search term to filter bucket names
	* @returns Promise with response containing array of buckets or error
	*
	* @example List buckets
	* ```js
	* const { data, error } = await supabase
	*   .storage
	*   .listBuckets()
	* ```
	*
	* @example List buckets with options
	* ```js
	* const { data, error } = await supabase
	*   .storage
	*   .listBuckets({
	*     limit: 10,
	*     offset: 0,
	*     sortColumn: 'created_at',
	*     sortOrder: 'desc',
	*     search: 'prod'
	*   })
	* ```
	*/
	async listBuckets(options) {
		var _this = this;
		return _this.handleOperation(async () => {
			const queryString = _this.listBucketOptionsToQueryString(options);
			return await get(_this.fetch, `${_this.url}/bucket${queryString}`, { headers: _this.headers });
		});
	}
	/**
	* Retrieves the details of an existing Storage bucket.
	*
	* @category File Buckets
	* @param id The unique identifier of the bucket you would like to retrieve.
	* @returns Promise with response containing bucket details or error
	*
	* @example Get bucket
	* ```js
	* const { data, error } = await supabase
	*   .storage
	*   .getBucket('avatars')
	* ```
	*
	* Response:
	* ```json
	* {
	*   "data": {
	*     "id": "avatars",
	*     "name": "avatars",
	*     "owner": "",
	*     "public": false,
	*     "file_size_limit": 1024,
	*     "allowed_mime_types": [
	*       "image/png"
	*     ],
	*     "created_at": "2024-05-22T22:26:05.100Z",
	*     "updated_at": "2024-05-22T22:26:05.100Z"
	*   },
	*   "error": null
	* }
	* ```
	*/
	async getBucket(id) {
		var _this2 = this;
		return _this2.handleOperation(async () => {
			return await get(_this2.fetch, `${_this2.url}/bucket/${id}`, { headers: _this2.headers });
		});
	}
	/**
	* Creates a new Storage bucket
	*
	* @category File Buckets
	* @param id A unique identifier for the bucket you are creating.
	* @param options.public The visibility of the bucket. Public buckets don't require an authorization token to download objects, but still require a valid token for all other operations. By default, buckets are private.
	* @param options.fileSizeLimit specifies the max file size in bytes that can be uploaded to this bucket.
	* The global file size limit takes precedence over this value.
	* The default value is null, which doesn't set a per bucket file size limit.
	* @param options.allowedMimeTypes specifies the allowed mime types that this bucket can accept during upload.
	* The default value is null, which allows files with all mime types to be uploaded.
	* Each mime type specified can be a wildcard, e.g. image/*, or a specific mime type, e.g. image/png.
	* @param options.type (private-beta) specifies the bucket type. see `BucketType` for more details.
	*   - default bucket type is `STANDARD`
	* @returns Promise with response containing newly created bucket name or error
	*
	* @example Create bucket
	* ```js
	* const { data, error } = await supabase
	*   .storage
	*   .createBucket('avatars', {
	*     public: false,
	*     allowedMimeTypes: ['image/png'],
	*     fileSizeLimit: 1024
	*   })
	* ```
	*
	* Response:
	* ```json
	* {
	*   "data": {
	*     "name": "avatars"
	*   },
	*   "error": null
	* }
	* ```
	*/
	async createBucket(id, options = { public: false }) {
		var _this3 = this;
		return _this3.handleOperation(async () => {
			return await post(_this3.fetch, `${_this3.url}/bucket`, {
				id,
				name: id,
				type: options.type,
				public: options.public,
				file_size_limit: options.fileSizeLimit,
				allowed_mime_types: options.allowedMimeTypes
			}, { headers: _this3.headers });
		});
	}
	/**
	* Updates a Storage bucket
	*
	* @category File Buckets
	* @param id A unique identifier for the bucket you are updating.
	* @param options.public The visibility of the bucket. Public buckets don't require an authorization token to download objects, but still require a valid token for all other operations.
	* @param options.fileSizeLimit specifies the max file size in bytes that can be uploaded to this bucket.
	* The global file size limit takes precedence over this value.
	* The default value is null, which doesn't set a per bucket file size limit.
	* @param options.allowedMimeTypes specifies the allowed mime types that this bucket can accept during upload.
	* The default value is null, which allows files with all mime types to be uploaded.
	* Each mime type specified can be a wildcard, e.g. image/*, or a specific mime type, e.g. image/png.
	* @returns Promise with response containing success message or error
	*
	* @example Update bucket
	* ```js
	* const { data, error } = await supabase
	*   .storage
	*   .updateBucket('avatars', {
	*     public: false,
	*     allowedMimeTypes: ['image/png'],
	*     fileSizeLimit: 1024
	*   })
	* ```
	*
	* Response:
	* ```json
	* {
	*   "data": {
	*     "message": "Successfully updated"
	*   },
	*   "error": null
	* }
	* ```
	*/
	async updateBucket(id, options) {
		var _this4 = this;
		return _this4.handleOperation(async () => {
			return await put(_this4.fetch, `${_this4.url}/bucket/${id}`, {
				id,
				name: id,
				public: options.public,
				file_size_limit: options.fileSizeLimit,
				allowed_mime_types: options.allowedMimeTypes
			}, { headers: _this4.headers });
		});
	}
	/**
	* Removes all objects inside a single bucket.
	*
	* @category File Buckets
	* @param id The unique identifier of the bucket you would like to empty.
	* @returns Promise with success message or error
	*
	* @example Empty bucket
	* ```js
	* const { data, error } = await supabase
	*   .storage
	*   .emptyBucket('avatars')
	* ```
	*
	* Response:
	* ```json
	* {
	*   "data": {
	*     "message": "Successfully emptied"
	*   },
	*   "error": null
	* }
	* ```
	*/
	async emptyBucket(id) {
		var _this5 = this;
		return _this5.handleOperation(async () => {
			return await post(_this5.fetch, `${_this5.url}/bucket/${id}/empty`, {}, { headers: _this5.headers });
		});
	}
	/**
	* Deletes an existing bucket. A bucket can't be deleted with existing objects inside it.
	* You must first `empty()` the bucket.
	*
	* @category File Buckets
	* @param id The unique identifier of the bucket you would like to delete.
	* @returns Promise with success message or error
	*
	* @example Delete bucket
	* ```js
	* const { data, error } = await supabase
	*   .storage
	*   .deleteBucket('avatars')
	* ```
	*
	* Response:
	* ```json
	* {
	*   "data": {
	*     "message": "Successfully deleted"
	*   },
	*   "error": null
	* }
	* ```
	*/
	async deleteBucket(id) {
		var _this6 = this;
		return _this6.handleOperation(async () => {
			return await remove(_this6.fetch, `${_this6.url}/bucket/${id}`, {}, { headers: _this6.headers });
		});
	}
	listBucketOptionsToQueryString(options) {
		const params = {};
		if (options) {
			if ("limit" in options) params.limit = String(options.limit);
			if ("offset" in options) params.offset = String(options.offset);
			if (options.search) params.search = options.search;
			if (options.sortColumn) params.sortColumn = options.sortColumn;
			if (options.sortOrder) params.sortOrder = options.sortOrder;
		}
		return Object.keys(params).length > 0 ? "?" + new URLSearchParams(params).toString() : "";
	}
};

//#endregion
//#region src/packages/StorageAnalyticsClient.ts
/**
* Client class for managing Analytics Buckets using Iceberg tables
* Provides methods for creating, listing, and deleting analytics buckets
*/
var StorageAnalyticsClient = class extends BaseApiClient {
	/**
	* @alpha
	*
	* Creates a new StorageAnalyticsClient instance
	*
	* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
	*
	* @category Analytics Buckets
	* @param url - The base URL for the storage API
	* @param headers - HTTP headers to include in requests
	* @param fetch - Optional custom fetch implementation
	*
	* @example
	* ```typescript
	* const client = new StorageAnalyticsClient(url, headers)
	* ```
	*/
	constructor(url, headers = {}, fetch$1) {
		const finalUrl = url.replace(/\/$/, "");
		const finalHeaders = dist_objectSpread2(dist_objectSpread2({}, DEFAULT_HEADERS), headers);
		super(finalUrl, finalHeaders, fetch$1, "storage");
	}
	/**
	* @alpha
	*
	* Creates a new analytics bucket using Iceberg tables
	* Analytics buckets are optimized for analytical queries and data processing
	*
	* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
	*
	* @category Analytics Buckets
	* @param name A unique name for the bucket you are creating
	* @returns Promise with response containing newly created analytics bucket or error
	*
	* @example Create analytics bucket
	* ```js
	* const { data, error } = await supabase
	*   .storage
	*   .analytics
	*   .createBucket('analytics-data')
	* ```
	*
	* Response:
	* ```json
	* {
	*   "data": {
	*     "name": "analytics-data",
	*     "type": "ANALYTICS",
	*     "format": "iceberg",
	*     "created_at": "2024-05-22T22:26:05.100Z",
	*     "updated_at": "2024-05-22T22:26:05.100Z"
	*   },
	*   "error": null
	* }
	* ```
	*/
	async createBucket(name) {
		var _this = this;
		return _this.handleOperation(async () => {
			return await post(_this.fetch, `${_this.url}/bucket`, { name }, { headers: _this.headers });
		});
	}
	/**
	* @alpha
	*
	* Retrieves the details of all Analytics Storage buckets within an existing project
	* Only returns buckets of type 'ANALYTICS'
	*
	* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
	*
	* @category Analytics Buckets
	* @param options Query parameters for listing buckets
	* @param options.limit Maximum number of buckets to return
	* @param options.offset Number of buckets to skip
	* @param options.sortColumn Column to sort by ('name', 'created_at', 'updated_at')
	* @param options.sortOrder Sort order ('asc' or 'desc')
	* @param options.search Search term to filter bucket names
	* @returns Promise with response containing array of analytics buckets or error
	*
	* @example List analytics buckets
	* ```js
	* const { data, error } = await supabase
	*   .storage
	*   .analytics
	*   .listBuckets({
	*     limit: 10,
	*     offset: 0,
	*     sortColumn: 'created_at',
	*     sortOrder: 'desc'
	*   })
	* ```
	*
	* Response:
	* ```json
	* {
	*   "data": [
	*     {
	*       "name": "analytics-data",
	*       "type": "ANALYTICS",
	*       "format": "iceberg",
	*       "created_at": "2024-05-22T22:26:05.100Z",
	*       "updated_at": "2024-05-22T22:26:05.100Z"
	*     }
	*   ],
	*   "error": null
	* }
	* ```
	*/
	async listBuckets(options) {
		var _this2 = this;
		return _this2.handleOperation(async () => {
			const queryParams = new URLSearchParams();
			if ((options === null || options === void 0 ? void 0 : options.limit) !== void 0) queryParams.set("limit", options.limit.toString());
			if ((options === null || options === void 0 ? void 0 : options.offset) !== void 0) queryParams.set("offset", options.offset.toString());
			if (options === null || options === void 0 ? void 0 : options.sortColumn) queryParams.set("sortColumn", options.sortColumn);
			if (options === null || options === void 0 ? void 0 : options.sortOrder) queryParams.set("sortOrder", options.sortOrder);
			if (options === null || options === void 0 ? void 0 : options.search) queryParams.set("search", options.search);
			const queryString = queryParams.toString();
			const url = queryString ? `${_this2.url}/bucket?${queryString}` : `${_this2.url}/bucket`;
			return await get(_this2.fetch, url, { headers: _this2.headers });
		});
	}
	/**
	* @alpha
	*
	* Deletes an existing analytics bucket
	* A bucket can't be deleted with existing objects inside it
	* You must first empty the bucket before deletion
	*
	* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
	*
	* @category Analytics Buckets
	* @param bucketName The unique identifier of the bucket you would like to delete
	* @returns Promise with response containing success message or error
	*
	* @example Delete analytics bucket
	* ```js
	* const { data, error } = await supabase
	*   .storage
	*   .analytics
	*   .deleteBucket('analytics-data')
	* ```
	*
	* Response:
	* ```json
	* {
	*   "data": {
	*     "message": "Successfully deleted"
	*   },
	*   "error": null
	* }
	* ```
	*/
	async deleteBucket(bucketName) {
		var _this3 = this;
		return _this3.handleOperation(async () => {
			return await remove(_this3.fetch, `${_this3.url}/bucket/${bucketName}`, {}, { headers: _this3.headers });
		});
	}
	/**
	* @alpha
	*
	* Get an Iceberg REST Catalog client configured for a specific analytics bucket
	* Use this to perform advanced table and namespace operations within the bucket
	* The returned client provides full access to the Apache Iceberg REST Catalog API
	* with the Supabase `{ data, error }` pattern for consistent error handling on all operations.
	*
	* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
	*
	* @category Analytics Buckets
	* @param bucketName - The name of the analytics bucket (warehouse) to connect to
	* @returns The wrapped Iceberg catalog client
	* @throws {StorageError} If the bucket name is invalid
	*
	* @example Get catalog and create table
	* ```js
	* // First, create an analytics bucket
	* const { data: bucket, error: bucketError } = await supabase
	*   .storage
	*   .analytics
	*   .createBucket('analytics-data')
	*
	* // Get the Iceberg catalog for that bucket
	* const catalog = supabase.storage.analytics.from('analytics-data')
	*
	* // Create a namespace
	* const { error: nsError } = await catalog.createNamespace({ namespace: ['default'] })
	*
	* // Create a table with schema
	* const { data: tableMetadata, error: tableError } = await catalog.createTable(
	*   { namespace: ['default'] },
	*   {
	*     name: 'events',
	*     schema: {
	*       type: 'struct',
	*       fields: [
	*         { id: 1, name: 'id', type: 'long', required: true },
	*         { id: 2, name: 'timestamp', type: 'timestamp', required: true },
	*         { id: 3, name: 'user_id', type: 'string', required: false }
	*       ],
	*       'schema-id': 0,
	*       'identifier-field-ids': [1]
	*     },
	*     'partition-spec': {
	*       'spec-id': 0,
	*       fields: []
	*     },
	*     'write-order': {
	*       'order-id': 0,
	*       fields: []
	*     },
	*     properties: {
	*       'write.format.default': 'parquet'
	*     }
	*   }
	* )
	* ```
	*
	* @example List tables in namespace
	* ```js
	* const catalog = supabase.storage.analytics.from('analytics-data')
	*
	* // List all tables in the default namespace
	* const { data: tables, error: listError } = await catalog.listTables({ namespace: ['default'] })
	* if (listError) {
	*   if (listError.isNotFound()) {
	*     console.log('Namespace not found')
	*   }
	*   return
	* }
	* console.log(tables) // [{ namespace: ['default'], name: 'events' }]
	* ```
	*
	* @example Working with namespaces
	* ```js
	* const catalog = supabase.storage.analytics.from('analytics-data')
	*
	* // List all namespaces
	* const { data: namespaces } = await catalog.listNamespaces()
	*
	* // Create namespace with properties
	* await catalog.createNamespace(
	*   { namespace: ['production'] },
	*   { properties: { owner: 'data-team', env: 'prod' } }
	* )
	* ```
	*
	* @example Cleanup operations
	* ```js
	* const catalog = supabase.storage.analytics.from('analytics-data')
	*
	* // Drop table with purge option (removes all data)
	* const { error: dropError } = await catalog.dropTable(
	*   { namespace: ['default'], name: 'events' },
	*   { purge: true }
	* )
	*
	* if (dropError?.isNotFound()) {
	*   console.log('Table does not exist')
	* }
	*
	* // Drop namespace (must be empty)
	* await catalog.dropNamespace({ namespace: ['default'] })
	* ```
	*
	* @remarks
	* This method provides a bridge between Supabase's bucket management and the standard
	* Apache Iceberg REST Catalog API. The bucket name maps to the Iceberg warehouse parameter.
	* All authentication and configuration is handled automatically using your Supabase credentials.
	*
	* **Error Handling**: Invalid bucket names throw immediately. All catalog
	* operations return `{ data, error }` where errors are `IcebergError` instances from iceberg-js.
	* Use helper methods like `error.isNotFound()` or check `error.status` for specific error handling.
	* Use `.throwOnError()` on the analytics client if you prefer exceptions for catalog operations.
	*
	* **Cleanup Operations**: When using `dropTable`, the `purge: true` option permanently
	* deletes all table data. Without it, the table is marked as deleted but data remains.
	*
	* **Library Dependency**: The returned catalog wraps `IcebergRestCatalog` from iceberg-js.
	* For complete API documentation and advanced usage, refer to the
	* [iceberg-js documentation](https://supabase.github.io/iceberg-js/).
	*/
	from(bucketName) {
		var _this4 = this;
		if (!isValidBucketName(bucketName)) throw new StorageError("Invalid bucket name: File, folder, and bucket names must follow AWS object key naming guidelines and should avoid the use of any other characters.");
		const catalog = new IcebergRestCatalog({
			baseUrl: this.url,
			catalogName: bucketName,
			auth: {
				type: "custom",
				getHeaders: async () => _this4.headers
			},
			fetch: this.fetch
		});
		const shouldThrowOnError = this.shouldThrowOnError;
		return new Proxy(catalog, { get(target, prop) {
			const value = target[prop];
			if (typeof value !== "function") return value;
			return async (...args) => {
				try {
					return {
						data: await value.apply(target, args),
						error: null
					};
				} catch (error) {
					if (shouldThrowOnError) throw error;
					return {
						data: null,
						error
					};
				}
			};
		} });
	}
};

//#endregion
//#region src/packages/VectorIndexApi.ts
/**
* @hidden
* Base implementation for vector index operations.
* Use {@link VectorBucketScope} via `supabase.storage.vectors.from('bucket')` instead.
*/
var VectorIndexApi = class extends BaseApiClient {
	/** Creates a new VectorIndexApi instance */
	constructor(url, headers = {}, fetch$1) {
		const finalUrl = url.replace(/\/$/, "");
		const finalHeaders = dist_objectSpread2(dist_objectSpread2({}, DEFAULT_HEADERS), {}, { "Content-Type": "application/json" }, headers);
		super(finalUrl, finalHeaders, fetch$1, "vectors");
	}
	/** Creates a new vector index within a bucket */
	async createIndex(options) {
		var _this = this;
		return _this.handleOperation(async () => {
			return await vectorsApi.post(_this.fetch, `${_this.url}/CreateIndex`, options, { headers: _this.headers }) || {};
		});
	}
	/** Retrieves metadata for a specific vector index */
	async getIndex(vectorBucketName, indexName) {
		var _this2 = this;
		return _this2.handleOperation(async () => {
			return await vectorsApi.post(_this2.fetch, `${_this2.url}/GetIndex`, {
				vectorBucketName,
				indexName
			}, { headers: _this2.headers });
		});
	}
	/** Lists vector indexes within a bucket with optional filtering and pagination */
	async listIndexes(options) {
		var _this3 = this;
		return _this3.handleOperation(async () => {
			return await vectorsApi.post(_this3.fetch, `${_this3.url}/ListIndexes`, options, { headers: _this3.headers });
		});
	}
	/** Deletes a vector index and all its data */
	async deleteIndex(vectorBucketName, indexName) {
		var _this4 = this;
		return _this4.handleOperation(async () => {
			return await vectorsApi.post(_this4.fetch, `${_this4.url}/DeleteIndex`, {
				vectorBucketName,
				indexName
			}, { headers: _this4.headers }) || {};
		});
	}
};

//#endregion
//#region src/packages/VectorDataApi.ts
/**
* @hidden
* Base implementation for vector data operations.
* Use {@link VectorIndexScope} via `supabase.storage.vectors.from('bucket').index('idx')` instead.
*/
var VectorDataApi = class extends BaseApiClient {
	/** Creates a new VectorDataApi instance */
	constructor(url, headers = {}, fetch$1) {
		const finalUrl = url.replace(/\/$/, "");
		const finalHeaders = dist_objectSpread2(dist_objectSpread2({}, DEFAULT_HEADERS), {}, { "Content-Type": "application/json" }, headers);
		super(finalUrl, finalHeaders, fetch$1, "vectors");
	}
	/** Inserts or updates vectors in batch (1-500 per request) */
	async putVectors(options) {
		var _this = this;
		if (options.vectors.length < 1 || options.vectors.length > 500) throw new Error("Vector batch size must be between 1 and 500 items");
		return _this.handleOperation(async () => {
			return await vectorsApi.post(_this.fetch, `${_this.url}/PutVectors`, options, { headers: _this.headers }) || {};
		});
	}
	/** Retrieves vectors by their keys in batch */
	async getVectors(options) {
		var _this2 = this;
		return _this2.handleOperation(async () => {
			return await vectorsApi.post(_this2.fetch, `${_this2.url}/GetVectors`, options, { headers: _this2.headers });
		});
	}
	/** Lists vectors in an index with pagination */
	async listVectors(options) {
		var _this3 = this;
		if (options.segmentCount !== void 0) {
			if (options.segmentCount < 1 || options.segmentCount > 16) throw new Error("segmentCount must be between 1 and 16");
			if (options.segmentIndex !== void 0) {
				if (options.segmentIndex < 0 || options.segmentIndex >= options.segmentCount) throw new Error(`segmentIndex must be between 0 and ${options.segmentCount - 1}`);
			}
		}
		return _this3.handleOperation(async () => {
			return await vectorsApi.post(_this3.fetch, `${_this3.url}/ListVectors`, options, { headers: _this3.headers });
		});
	}
	/** Queries for similar vectors using approximate nearest neighbor search */
	async queryVectors(options) {
		var _this4 = this;
		return _this4.handleOperation(async () => {
			return await vectorsApi.post(_this4.fetch, `${_this4.url}/QueryVectors`, options, { headers: _this4.headers });
		});
	}
	/** Deletes vectors by their keys in batch (1-500 per request) */
	async deleteVectors(options) {
		var _this5 = this;
		if (options.keys.length < 1 || options.keys.length > 500) throw new Error("Keys batch size must be between 1 and 500 items");
		return _this5.handleOperation(async () => {
			return await vectorsApi.post(_this5.fetch, `${_this5.url}/DeleteVectors`, options, { headers: _this5.headers }) || {};
		});
	}
};

//#endregion
//#region src/packages/VectorBucketApi.ts
/**
* @hidden
* Base implementation for vector bucket operations.
* Use {@link StorageVectorsClient} via `supabase.storage.vectors` instead.
*/
var VectorBucketApi = class extends BaseApiClient {
	/** Creates a new VectorBucketApi instance */
	constructor(url, headers = {}, fetch$1) {
		const finalUrl = url.replace(/\/$/, "");
		const finalHeaders = dist_objectSpread2(dist_objectSpread2({}, DEFAULT_HEADERS), {}, { "Content-Type": "application/json" }, headers);
		super(finalUrl, finalHeaders, fetch$1, "vectors");
	}
	/** Creates a new vector bucket */
	async createBucket(vectorBucketName) {
		var _this = this;
		return _this.handleOperation(async () => {
			return await vectorsApi.post(_this.fetch, `${_this.url}/CreateVectorBucket`, { vectorBucketName }, { headers: _this.headers }) || {};
		});
	}
	/** Retrieves metadata for a specific vector bucket */
	async getBucket(vectorBucketName) {
		var _this2 = this;
		return _this2.handleOperation(async () => {
			return await vectorsApi.post(_this2.fetch, `${_this2.url}/GetVectorBucket`, { vectorBucketName }, { headers: _this2.headers });
		});
	}
	/** Lists vector buckets with optional filtering and pagination */
	async listBuckets(options = {}) {
		var _this3 = this;
		return _this3.handleOperation(async () => {
			return await vectorsApi.post(_this3.fetch, `${_this3.url}/ListVectorBuckets`, options, { headers: _this3.headers });
		});
	}
	/** Deletes a vector bucket (must be empty first) */
	async deleteBucket(vectorBucketName) {
		var _this4 = this;
		return _this4.handleOperation(async () => {
			return await vectorsApi.post(_this4.fetch, `${_this4.url}/DeleteVectorBucket`, { vectorBucketName }, { headers: _this4.headers }) || {};
		});
	}
};

//#endregion
//#region src/packages/StorageVectorsClient.ts
/**
*
* @alpha
*
* Main client for interacting with S3 Vectors API
* Provides access to bucket, index, and vector data operations
*
* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
*
* **Usage Patterns:**
*
* ```typescript
* const { data, error } = await supabase
*  .storage
*  .vectors
*  .createBucket('embeddings-prod')
*
* // Access index operations via buckets
* const bucket = supabase.storage.vectors.from('embeddings-prod')
* await bucket.createIndex({
*   indexName: 'documents',
*   dataType: 'float32',
*   dimension: 1536,
*   distanceMetric: 'cosine'
* })
*
* // Access vector operations via index
* const index = bucket.index('documents')
* await index.putVectors({
*   vectors: [
*     { key: 'doc-1', data: { float32: [...] }, metadata: { title: 'Intro' } }
*   ]
* })
*
* // Query similar vectors
* const { data } = await index.queryVectors({
*   queryVector: { float32: [...] },
*   topK: 5,
*   returnDistance: true
* })
* ```
*/
var StorageVectorsClient = class extends VectorBucketApi {
	/**
	* @alpha
	*
	* Creates a StorageVectorsClient that can manage buckets, indexes, and vectors.
	*
	* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
	*
	* @category Vector Buckets
	* @param url - Base URL of the Storage Vectors REST API.
	* @param options.headers - Optional headers (for example `Authorization`) applied to every request.
	* @param options.fetch - Optional custom `fetch` implementation for non-browser runtimes.
	*
	* @example
	* ```typescript
	* const client = new StorageVectorsClient(url, options)
	* ```
	*/
	constructor(url, options = {}) {
		super(url, options.headers || {}, options.fetch);
	}
	/**
	*
	* @alpha
	*
	* Access operations for a specific vector bucket
	* Returns a scoped client for index and vector operations within the bucket
	*
	* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
	*
	* @category Vector Buckets
	* @param vectorBucketName - Name of the vector bucket
	* @returns Bucket-scoped client with index and vector operations
	*
	* @example
	* ```typescript
	* const bucket = supabase.storage.vectors.from('embeddings-prod')
	* ```
	*/
	from(vectorBucketName) {
		return new VectorBucketScope(this.url, this.headers, vectorBucketName, this.fetch);
	}
	/**
	*
	* @alpha
	*
	* Creates a new vector bucket
	* Vector buckets are containers for vector indexes and their data
	*
	* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
	*
	* @category Vector Buckets
	* @param vectorBucketName - Unique name for the vector bucket
	* @returns Promise with empty response on success or error
	*
	* @example
	* ```typescript
	* const { data, error } = await supabase
	*   .storage
	*   .vectors
	*   .createBucket('embeddings-prod')
	* ```
	*/
	async createBucket(vectorBucketName) {
		var _superprop_getCreateBucket = () => super.createBucket, _this = this;
		return _superprop_getCreateBucket().call(_this, vectorBucketName);
	}
	/**
	*
	* @alpha
	*
	* Retrieves metadata for a specific vector bucket
	*
	* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
	*
	* @category Vector Buckets
	* @param vectorBucketName - Name of the vector bucket
	* @returns Promise with bucket metadata or error
	*
	* @example
	* ```typescript
	* const { data, error } = await supabase
	*   .storage
	*   .vectors
	*   .getBucket('embeddings-prod')
	*
	* console.log('Bucket created:', data?.vectorBucket.creationTime)
	* ```
	*/
	async getBucket(vectorBucketName) {
		var _superprop_getGetBucket = () => super.getBucket, _this2 = this;
		return _superprop_getGetBucket().call(_this2, vectorBucketName);
	}
	/**
	*
	* @alpha
	*
	* Lists all vector buckets with optional filtering and pagination
	*
	* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
	*
	* @category Vector Buckets
	* @param options - Optional filters (prefix, maxResults, nextToken)
	* @returns Promise with list of buckets or error
	*
	* @example
	* ```typescript
	* const { data, error } = await supabase
	*   .storage
	*   .vectors
	*   .listBuckets({ prefix: 'embeddings-' })
	*
	* data?.vectorBuckets.forEach(bucket => {
	*   console.log(bucket.vectorBucketName)
	* })
	* ```
	*/
	async listBuckets(options = {}) {
		var _superprop_getListBuckets = () => super.listBuckets, _this3 = this;
		return _superprop_getListBuckets().call(_this3, options);
	}
	/**
	*
	* @alpha
	*
	* Deletes a vector bucket (bucket must be empty)
	* All indexes must be deleted before deleting the bucket
	*
	* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
	*
	* @category Vector Buckets
	* @param vectorBucketName - Name of the vector bucket to delete
	* @returns Promise with empty response on success or error
	*
	* @example
	* ```typescript
	* const { data, error } = await supabase
	*   .storage
	*   .vectors
	*   .deleteBucket('embeddings-old')
	* ```
	*/
	async deleteBucket(vectorBucketName) {
		var _superprop_getDeleteBucket = () => super.deleteBucket, _this4 = this;
		return _superprop_getDeleteBucket().call(_this4, vectorBucketName);
	}
};
/**
*
* @alpha
*
* Scoped client for operations within a specific vector bucket
* Provides index management and access to vector operations
*
* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
*/
var VectorBucketScope = class extends VectorIndexApi {
	/**
	* @alpha
	*
	* Creates a helper that automatically scopes all index operations to the provided bucket.
	*
	* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
	*
	* @category Vector Buckets
	* @example
	* ```typescript
	* const bucket = supabase.storage.vectors.from('embeddings-prod')
	* ```
	*/
	constructor(url, headers, vectorBucketName, fetch$1) {
		super(url, headers, fetch$1);
		this.vectorBucketName = vectorBucketName;
	}
	/**
	*
	* @alpha
	*
	* Creates a new vector index in this bucket
	* Convenience method that automatically includes the bucket name
	*
	* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
	*
	* @category Vector Buckets
	* @param options - Index configuration (vectorBucketName is automatically set)
	* @returns Promise with empty response on success or error
	*
	* @example
	* ```typescript
	* const bucket = supabase.storage.vectors.from('embeddings-prod')
	* await bucket.createIndex({
	*   indexName: 'documents-openai',
	*   dataType: 'float32',
	*   dimension: 1536,
	*   distanceMetric: 'cosine',
	*   metadataConfiguration: {
	*     nonFilterableMetadataKeys: ['raw_text']
	*   }
	* })
	* ```
	*/
	async createIndex(options) {
		var _superprop_getCreateIndex = () => super.createIndex, _this5 = this;
		return _superprop_getCreateIndex().call(_this5, dist_objectSpread2(dist_objectSpread2({}, options), {}, { vectorBucketName: _this5.vectorBucketName }));
	}
	/**
	*
	* @alpha
	*
	* Lists indexes in this bucket
	* Convenience method that automatically includes the bucket name
	*
	* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
	*
	* @category Vector Buckets
	* @param options - Listing options (vectorBucketName is automatically set)
	* @returns Promise with response containing indexes array and pagination token or error
	*
	* @example
	* ```typescript
	* const bucket = supabase.storage.vectors.from('embeddings-prod')
	* const { data } = await bucket.listIndexes({ prefix: 'documents-' })
	* ```
	*/
	async listIndexes(options = {}) {
		var _superprop_getListIndexes = () => super.listIndexes, _this6 = this;
		return _superprop_getListIndexes().call(_this6, dist_objectSpread2(dist_objectSpread2({}, options), {}, { vectorBucketName: _this6.vectorBucketName }));
	}
	/**
	*
	* @alpha
	*
	* Retrieves metadata for a specific index in this bucket
	* Convenience method that automatically includes the bucket name
	*
	* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
	*
	* @category Vector Buckets
	* @param indexName - Name of the index to retrieve
	* @returns Promise with index metadata or error
	*
	* @example
	* ```typescript
	* const bucket = supabase.storage.vectors.from('embeddings-prod')
	* const { data } = await bucket.getIndex('documents-openai')
	* console.log('Dimension:', data?.index.dimension)
	* ```
	*/
	async getIndex(indexName) {
		var _superprop_getGetIndex = () => super.getIndex, _this7 = this;
		return _superprop_getGetIndex().call(_this7, _this7.vectorBucketName, indexName);
	}
	/**
	*
	* @alpha
	*
	* Deletes an index from this bucket
	* Convenience method that automatically includes the bucket name
	*
	* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
	*
	* @category Vector Buckets
	* @param indexName - Name of the index to delete
	* @returns Promise with empty response on success or error
	*
	* @example
	* ```typescript
	* const bucket = supabase.storage.vectors.from('embeddings-prod')
	* await bucket.deleteIndex('old-index')
	* ```
	*/
	async deleteIndex(indexName) {
		var _superprop_getDeleteIndex = () => super.deleteIndex, _this8 = this;
		return _superprop_getDeleteIndex().call(_this8, _this8.vectorBucketName, indexName);
	}
	/**
	*
	* @alpha
	*
	* Access operations for a specific index within this bucket
	* Returns a scoped client for vector data operations
	*
	* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
	*
	* @category Vector Buckets
	* @param indexName - Name of the index
	* @returns Index-scoped client with vector data operations
	*
	* @example
	* ```typescript
	* const index = supabase.storage.vectors.from('embeddings-prod').index('documents-openai')
	*
	* // Insert vectors
	* await index.putVectors({
	*   vectors: [
	*     { key: 'doc-1', data: { float32: [...] }, metadata: { title: 'Intro' } }
	*   ]
	* })
	*
	* // Query similar vectors
	* const { data } = await index.queryVectors({
	*   queryVector: { float32: [...] },
	*   topK: 5
	* })
	* ```
	*/
	index(indexName) {
		return new VectorIndexScope(this.url, this.headers, this.vectorBucketName, indexName, this.fetch);
	}
};
/**
*
* @alpha
*
* Scoped client for operations within a specific vector index
* Provides vector data operations (put, get, list, query, delete)
*
* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
*/
var VectorIndexScope = class extends VectorDataApi {
	/**
	*
	* @alpha
	*
	* Creates a helper that automatically scopes all vector operations to the provided bucket/index names.
	*
	* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
	*
	* @category Vector Buckets
	* @example
	* ```typescript
	* const index = supabase.storage.vectors.from('embeddings-prod').index('documents-openai')
	* ```
	*/
	constructor(url, headers, vectorBucketName, indexName, fetch$1) {
		super(url, headers, fetch$1);
		this.vectorBucketName = vectorBucketName;
		this.indexName = indexName;
	}
	/**
	*
	* @alpha
	*
	* Inserts or updates vectors in this index
	* Convenience method that automatically includes bucket and index names
	*
	* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
	*
	* @category Vector Buckets
	* @param options - Vector insertion options (bucket and index names automatically set)
	* @returns Promise with empty response on success or error
	*
	* @example
	* ```typescript
	* const index = supabase.storage.vectors.from('embeddings-prod').index('documents-openai')
	* await index.putVectors({
	*   vectors: [
	*     {
	*       key: 'doc-1',
	*       data: { float32: [0.1, 0.2, ...] },
	*       metadata: { title: 'Introduction', page: 1 }
	*     }
	*   ]
	* })
	* ```
	*/
	async putVectors(options) {
		var _superprop_getPutVectors = () => super.putVectors, _this9 = this;
		return _superprop_getPutVectors().call(_this9, dist_objectSpread2(dist_objectSpread2({}, options), {}, {
			vectorBucketName: _this9.vectorBucketName,
			indexName: _this9.indexName
		}));
	}
	/**
	*
	* @alpha
	*
	* Retrieves vectors by keys from this index
	* Convenience method that automatically includes bucket and index names
	*
	* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
	*
	* @category Vector Buckets
	* @param options - Vector retrieval options (bucket and index names automatically set)
	* @returns Promise with response containing vectors array or error
	*
	* @example
	* ```typescript
	* const index = supabase.storage.vectors.from('embeddings-prod').index('documents-openai')
	* const { data } = await index.getVectors({
	*   keys: ['doc-1', 'doc-2'],
	*   returnMetadata: true
	* })
	* ```
	*/
	async getVectors(options) {
		var _superprop_getGetVectors = () => super.getVectors, _this10 = this;
		return _superprop_getGetVectors().call(_this10, dist_objectSpread2(dist_objectSpread2({}, options), {}, {
			vectorBucketName: _this10.vectorBucketName,
			indexName: _this10.indexName
		}));
	}
	/**
	*
	* @alpha
	*
	* Lists vectors in this index with pagination
	* Convenience method that automatically includes bucket and index names
	*
	* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
	*
	* @category Vector Buckets
	* @param options - Listing options (bucket and index names automatically set)
	* @returns Promise with response containing vectors array and pagination token or error
	*
	* @example
	* ```typescript
	* const index = supabase.storage.vectors.from('embeddings-prod').index('documents-openai')
	* const { data } = await index.listVectors({
	*   maxResults: 500,
	*   returnMetadata: true
	* })
	* ```
	*/
	async listVectors(options = {}) {
		var _superprop_getListVectors = () => super.listVectors, _this11 = this;
		return _superprop_getListVectors().call(_this11, dist_objectSpread2(dist_objectSpread2({}, options), {}, {
			vectorBucketName: _this11.vectorBucketName,
			indexName: _this11.indexName
		}));
	}
	/**
	*
	* @alpha
	*
	* Queries for similar vectors in this index
	* Convenience method that automatically includes bucket and index names
	*
	* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
	*
	* @category Vector Buckets
	* @param options - Query options (bucket and index names automatically set)
	* @returns Promise with response containing matches array of similar vectors ordered by distance or error
	*
	* @example
	* ```typescript
	* const index = supabase.storage.vectors.from('embeddings-prod').index('documents-openai')
	* const { data } = await index.queryVectors({
	*   queryVector: { float32: [0.1, 0.2, ...] },
	*   topK: 5,
	*   filter: { category: 'technical' },
	*   returnDistance: true,
	*   returnMetadata: true
	* })
	* ```
	*/
	async queryVectors(options) {
		var _superprop_getQueryVectors = () => super.queryVectors, _this12 = this;
		return _superprop_getQueryVectors().call(_this12, dist_objectSpread2(dist_objectSpread2({}, options), {}, {
			vectorBucketName: _this12.vectorBucketName,
			indexName: _this12.indexName
		}));
	}
	/**
	*
	* @alpha
	*
	* Deletes vectors by keys from this index
	* Convenience method that automatically includes bucket and index names
	*
	* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
	*
	* @category Vector Buckets
	* @param options - Deletion options (bucket and index names automatically set)
	* @returns Promise with empty response on success or error
	*
	* @example
	* ```typescript
	* const index = supabase.storage.vectors.from('embeddings-prod').index('documents-openai')
	* await index.deleteVectors({
	*   keys: ['doc-1', 'doc-2', 'doc-3']
	* })
	* ```
	*/
	async deleteVectors(options) {
		var _superprop_getDeleteVectors = () => super.deleteVectors, _this13 = this;
		return _superprop_getDeleteVectors().call(_this13, dist_objectSpread2(dist_objectSpread2({}, options), {}, {
			vectorBucketName: _this13.vectorBucketName,
			indexName: _this13.indexName
		}));
	}
};

//#endregion
//#region src/StorageClient.ts
var StorageClient = class extends StorageBucketApi {
	/**
	* Creates a client for Storage buckets, files, analytics, and vectors.
	*
	* @category File Buckets
	* @example
	* ```ts
	* import { StorageClient } from '@supabase/storage-js'
	*
	* const storage = new StorageClient('https://xyzcompany.supabase.co/storage/v1', {
	*   apikey: 'public-anon-key',
	* })
	* const avatars = storage.from('avatars')
	* ```
	*/
	constructor(url, headers = {}, fetch$1, opts) {
		super(url, headers, fetch$1, opts);
	}
	/**
	* Perform file operation in a bucket.
	*
	* @category File Buckets
	* @param id The bucket id to operate on.
	*
	* @example
	* ```typescript
	* const avatars = supabase.storage.from('avatars')
	* ```
	*/
	from(id) {
		return new StorageFileApi(this.url, this.headers, id, this.fetch);
	}
	/**
	*
	* @alpha
	*
	* Access vector storage operations.
	*
	* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
	*
	* @category Vector Buckets
	* @returns A StorageVectorsClient instance configured with the current storage settings.
	*/
	get vectors() {
		return new StorageVectorsClient(this.url + "/vector", {
			headers: this.headers,
			fetch: this.fetch
		});
	}
	/**
	*
	* @alpha
	*
	* Access analytics storage operations using Iceberg tables.
	*
	* **Public alpha:** This API is part of a public alpha release and may not be available to your account type.
	*
	* @category Analytics Buckets
	* @returns A StorageAnalyticsClient instance configured with the current storage settings.
	*/
	get analytics() {
		return new StorageAnalyticsClient(this.url + "/iceberg", this.headers, this.fetch);
	}
};

//#endregion

//# sourceMappingURL=index.mjs.map
// EXTERNAL MODULE: ./node_modules/@supabase/auth-js/dist/main/index.js
var auth_js_dist_main = __webpack_require__(9485);
;// CONCATENATED MODULE: ./node_modules/@supabase/supabase-js/dist/index.mjs










//#region src/lib/version.ts
const dist_version = "2.98.0";

//#endregion
//#region src/lib/constants.ts
let JS_ENV = "";
if (typeof Deno !== "undefined") JS_ENV = "deno";
else if (typeof document !== "undefined") JS_ENV = "web";
else if (typeof navigator !== "undefined" && navigator.product === "ReactNative") JS_ENV = "react-native";
else JS_ENV = "node";
const dist_DEFAULT_HEADERS = { "X-Client-Info": `supabase-js-${JS_ENV}/${dist_version}` };
const DEFAULT_GLOBAL_OPTIONS = { headers: dist_DEFAULT_HEADERS };
const DEFAULT_DB_OPTIONS = { schema: "public" };
const DEFAULT_AUTH_OPTIONS = {
	autoRefreshToken: true,
	persistSession: true,
	detectSessionInUrl: true,
	flowType: "implicit"
};
const DEFAULT_REALTIME_OPTIONS = {};

//#endregion
//#region \0@oxc-project+runtime@0.101.0/helpers/typeof.js
function supabase_js_dist_typeof(o) {
	"@babel/helpers - typeof";
	return supabase_js_dist_typeof = "function" == typeof Symbol && "symbol" == typeof Symbol.iterator ? function(o$1) {
		return typeof o$1;
	} : function(o$1) {
		return o$1 && "function" == typeof Symbol && o$1.constructor === Symbol && o$1 !== Symbol.prototype ? "symbol" : typeof o$1;
	}, supabase_js_dist_typeof(o);
}

//#endregion
//#region \0@oxc-project+runtime@0.101.0/helpers/toPrimitive.js
function supabase_js_dist_toPrimitive(t, r) {
	if ("object" != supabase_js_dist_typeof(t) || !t) return t;
	var e = t[Symbol.toPrimitive];
	if (void 0 !== e) {
		var i = e.call(t, r || "default");
		if ("object" != supabase_js_dist_typeof(i)) return i;
		throw new TypeError("@@toPrimitive must return a primitive value.");
	}
	return ("string" === r ? String : Number)(t);
}

//#endregion
//#region \0@oxc-project+runtime@0.101.0/helpers/toPropertyKey.js
function supabase_js_dist_toPropertyKey(t) {
	var i = supabase_js_dist_toPrimitive(t, "string");
	return "symbol" == supabase_js_dist_typeof(i) ? i : i + "";
}

//#endregion
//#region \0@oxc-project+runtime@0.101.0/helpers/defineProperty.js
function supabase_js_dist_defineProperty(e, r, t) {
	return (r = supabase_js_dist_toPropertyKey(r)) in e ? Object.defineProperty(e, r, {
		value: t,
		enumerable: !0,
		configurable: !0,
		writable: !0
	}) : e[r] = t, e;
}

//#endregion
//#region \0@oxc-project+runtime@0.101.0/helpers/objectSpread2.js
function supabase_js_dist_ownKeys(e, r) {
	var t = Object.keys(e);
	if (Object.getOwnPropertySymbols) {
		var o = Object.getOwnPropertySymbols(e);
		r && (o = o.filter(function(r$1) {
			return Object.getOwnPropertyDescriptor(e, r$1).enumerable;
		})), t.push.apply(t, o);
	}
	return t;
}
function supabase_js_dist_objectSpread2(e) {
	for (var r = 1; r < arguments.length; r++) {
		var t = null != arguments[r] ? arguments[r] : {};
		r % 2 ? supabase_js_dist_ownKeys(Object(t), !0).forEach(function(r$1) {
			supabase_js_dist_defineProperty(e, r$1, t[r$1]);
		}) : Object.getOwnPropertyDescriptors ? Object.defineProperties(e, Object.getOwnPropertyDescriptors(t)) : supabase_js_dist_ownKeys(Object(t)).forEach(function(r$1) {
			Object.defineProperty(e, r$1, Object.getOwnPropertyDescriptor(t, r$1));
		});
	}
	return e;
}

//#endregion
//#region src/lib/fetch.ts
const dist_resolveFetch = (customFetch) => {
	if (customFetch) return (...args) => customFetch(...args);
	return (...args) => fetch(...args);
};
const resolveHeadersConstructor = () => {
	return Headers;
};
const fetchWithAuth = (supabaseKey, getAccessToken, customFetch) => {
	const fetch$1 = dist_resolveFetch(customFetch);
	const HeadersConstructor = resolveHeadersConstructor();
	return async (input, init) => {
		var _await$getAccessToken;
		const accessToken = (_await$getAccessToken = await getAccessToken()) !== null && _await$getAccessToken !== void 0 ? _await$getAccessToken : supabaseKey;
		let headers = new HeadersConstructor(init === null || init === void 0 ? void 0 : init.headers);
		if (!headers.has("apikey")) headers.set("apikey", supabaseKey);
		if (!headers.has("Authorization")) headers.set("Authorization", `Bearer ${accessToken}`);
		return fetch$1(input, supabase_js_dist_objectSpread2(supabase_js_dist_objectSpread2({}, init), {}, { headers }));
	};
};

//#endregion
//#region src/lib/helpers.ts
function ensureTrailingSlash(url) {
	return url.endsWith("/") ? url : url + "/";
}
function applySettingDefaults(options, defaults) {
	var _DEFAULT_GLOBAL_OPTIO, _globalOptions$header;
	const { db: dbOptions, auth: authOptions, realtime: realtimeOptions, global: globalOptions } = options;
	const { db: DEFAULT_DB_OPTIONS$1, auth: DEFAULT_AUTH_OPTIONS$1, realtime: DEFAULT_REALTIME_OPTIONS$1, global: DEFAULT_GLOBAL_OPTIONS$1 } = defaults;
	const result = {
		db: supabase_js_dist_objectSpread2(supabase_js_dist_objectSpread2({}, DEFAULT_DB_OPTIONS$1), dbOptions),
		auth: supabase_js_dist_objectSpread2(supabase_js_dist_objectSpread2({}, DEFAULT_AUTH_OPTIONS$1), authOptions),
		realtime: supabase_js_dist_objectSpread2(supabase_js_dist_objectSpread2({}, DEFAULT_REALTIME_OPTIONS$1), realtimeOptions),
		storage: {},
		global: supabase_js_dist_objectSpread2(supabase_js_dist_objectSpread2(supabase_js_dist_objectSpread2({}, DEFAULT_GLOBAL_OPTIONS$1), globalOptions), {}, { headers: supabase_js_dist_objectSpread2(supabase_js_dist_objectSpread2({}, (_DEFAULT_GLOBAL_OPTIO = DEFAULT_GLOBAL_OPTIONS$1 === null || DEFAULT_GLOBAL_OPTIONS$1 === void 0 ? void 0 : DEFAULT_GLOBAL_OPTIONS$1.headers) !== null && _DEFAULT_GLOBAL_OPTIO !== void 0 ? _DEFAULT_GLOBAL_OPTIO : {}), (_globalOptions$header = globalOptions === null || globalOptions === void 0 ? void 0 : globalOptions.headers) !== null && _globalOptions$header !== void 0 ? _globalOptions$header : {}) }),
		accessToken: async () => ""
	};
	if (options.accessToken) result.accessToken = options.accessToken;
	else delete result.accessToken;
	return result;
}
/**
* Validates a Supabase client URL
*
* @param {string} supabaseUrl - The Supabase client URL string.
* @returns {URL} - The validated base URL.
* @throws {Error}
*/
function validateSupabaseUrl(supabaseUrl) {
	const trimmedUrl = supabaseUrl === null || supabaseUrl === void 0 ? void 0 : supabaseUrl.trim();
	if (!trimmedUrl) throw new Error("supabaseUrl is required.");
	if (!trimmedUrl.match(/^https?:\/\//i)) throw new Error("Invalid supabaseUrl: Must be a valid HTTP or HTTPS URL.");
	try {
		return new URL(ensureTrailingSlash(trimmedUrl));
	} catch (_unused) {
		throw Error("Invalid supabaseUrl: Provided URL is malformed.");
	}
}

//#endregion
//#region src/lib/SupabaseAuthClient.ts
var SupabaseAuthClient = class extends auth_js_dist_main.AuthClient {
	constructor(options) {
		super(options);
	}
};

//#endregion
//#region src/SupabaseClient.ts
/**
* Supabase Client.
*
* An isomorphic Javascript client for interacting with Postgres.
*/
var SupabaseClient = class {
	/**
	* Create a new client for use in the browser.
	* @param supabaseUrl The unique Supabase URL which is supplied when you create a new project in your project dashboard.
	* @param supabaseKey The unique Supabase Key which is supplied when you create a new project in your project dashboard.
	* @param options.db.schema You can switch in between schemas. The schema needs to be on the list of exposed schemas inside Supabase.
	* @param options.auth.autoRefreshToken Set to "true" if you want to automatically refresh the token before expiring.
	* @param options.auth.persistSession Set to "true" if you want to automatically save the user session into local storage.
	* @param options.auth.detectSessionInUrl Set to "true" if you want to automatically detects OAuth grants in the URL and signs in the user.
	* @param options.realtime Options passed along to realtime-js constructor.
	* @param options.storage Options passed along to the storage-js constructor.
	* @param options.global.fetch A custom fetch implementation.
	* @param options.global.headers Any additional headers to send with each network request.
	* @example
	* ```ts
	* import { createClient } from '@supabase/supabase-js'
	*
	* const supabase = createClient('https://xyzcompany.supabase.co', 'public-anon-key')
	* const { data } = await supabase.from('profiles').select('*')
	* ```
	*/
	constructor(supabaseUrl, supabaseKey, options) {
		var _settings$auth$storag, _settings$global$head;
		this.supabaseUrl = supabaseUrl;
		this.supabaseKey = supabaseKey;
		const baseUrl = validateSupabaseUrl(supabaseUrl);
		if (!supabaseKey) throw new Error("supabaseKey is required.");
		this.realtimeUrl = new URL("realtime/v1", baseUrl);
		this.realtimeUrl.protocol = this.realtimeUrl.protocol.replace("http", "ws");
		this.authUrl = new URL("auth/v1", baseUrl);
		this.storageUrl = new URL("storage/v1", baseUrl);
		this.functionsUrl = new URL("functions/v1", baseUrl);
		const defaultStorageKey = `sb-${baseUrl.hostname.split(".")[0]}-auth-token`;
		const DEFAULTS = {
			db: DEFAULT_DB_OPTIONS,
			realtime: DEFAULT_REALTIME_OPTIONS,
			auth: supabase_js_dist_objectSpread2(supabase_js_dist_objectSpread2({}, DEFAULT_AUTH_OPTIONS), {}, { storageKey: defaultStorageKey }),
			global: DEFAULT_GLOBAL_OPTIONS
		};
		const settings = applySettingDefaults(options !== null && options !== void 0 ? options : {}, DEFAULTS);
		this.storageKey = (_settings$auth$storag = settings.auth.storageKey) !== null && _settings$auth$storag !== void 0 ? _settings$auth$storag : "";
		this.headers = (_settings$global$head = settings.global.headers) !== null && _settings$global$head !== void 0 ? _settings$global$head : {};
		if (!settings.accessToken) {
			var _settings$auth;
			this.auth = this._initSupabaseAuthClient((_settings$auth = settings.auth) !== null && _settings$auth !== void 0 ? _settings$auth : {}, this.headers, settings.global.fetch);
		} else {
			this.accessToken = settings.accessToken;
			this.auth = new Proxy({}, { get: (_, prop) => {
				throw new Error(`@supabase/supabase-js: Supabase Client is configured with the accessToken option, accessing supabase.auth.${String(prop)} is not possible`);
			} });
		}
		this.fetch = fetchWithAuth(supabaseKey, this._getAccessToken.bind(this), settings.global.fetch);
		this.realtime = this._initRealtimeClient(supabase_js_dist_objectSpread2({
			headers: this.headers,
			accessToken: this._getAccessToken.bind(this)
		}, settings.realtime));
		if (this.accessToken) Promise.resolve(this.accessToken()).then((token) => this.realtime.setAuth(token)).catch((e) => console.warn("Failed to set initial Realtime auth token:", e));
		this.rest = new PostgrestClient(new URL("rest/v1", baseUrl).href, {
			headers: this.headers,
			schema: settings.db.schema,
			fetch: this.fetch,
			timeout: settings.db.timeout,
			urlLengthLimit: settings.db.urlLengthLimit
		});
		this.storage = new StorageClient(this.storageUrl.href, this.headers, this.fetch, options === null || options === void 0 ? void 0 : options.storage);
		if (!settings.accessToken) this._listenForAuthEvents();
	}
	/**
	* Supabase Functions allows you to deploy and invoke edge functions.
	*/
	get functions() {
		return new main/* FunctionsClient */.bE(this.functionsUrl.href, {
			headers: this.headers,
			customFetch: this.fetch
		});
	}
	/**
	* Perform a query on a table or a view.
	*
	* @param relation - The table or view name to query
	*/
	from(relation) {
		return this.rest.from(relation);
	}
	/**
	* Select a schema to query or perform an function (rpc) call.
	*
	* The schema needs to be on the list of exposed schemas inside Supabase.
	*
	* @param schema - The schema to query
	*/
	schema(schema) {
		return this.rest.schema(schema);
	}
	/**
	* Perform a function call.
	*
	* @param fn - The function name to call
	* @param args - The arguments to pass to the function call
	* @param options - Named parameters
	* @param options.head - When set to `true`, `data` will not be returned.
	* Useful if you only need the count.
	* @param options.get - When set to `true`, the function will be called with
	* read-only access mode.
	* @param options.count - Count algorithm to use to count rows returned by the
	* function. Only applicable for [set-returning
	* functions](https://www.postgresql.org/docs/current/functions-srf.html).
	*
	* `"exact"`: Exact but slow count algorithm. Performs a `COUNT(*)` under the
	* hood.
	*
	* `"planned"`: Approximated but fast count algorithm. Uses the Postgres
	* statistics under the hood.
	*
	* `"estimated"`: Uses exact count for low numbers and planned count for high
	* numbers.
	*/
	rpc(fn, args = {}, options = {
		head: false,
		get: false,
		count: void 0
	}) {
		return this.rest.rpc(fn, args, options);
	}
	/**
	* Creates a Realtime channel with Broadcast, Presence, and Postgres Changes.
	*
	* @param {string} name - The name of the Realtime channel.
	* @param {Object} opts - The options to pass to the Realtime channel.
	*
	*/
	channel(name, opts = { config: {} }) {
		return this.realtime.channel(name, opts);
	}
	/**
	* Returns all Realtime channels.
	*/
	getChannels() {
		return this.realtime.getChannels();
	}
	/**
	* Unsubscribes and removes Realtime channel from Realtime client.
	*
	* @param {RealtimeChannel} channel - The name of the Realtime channel.
	*
	*/
	removeChannel(channel) {
		return this.realtime.removeChannel(channel);
	}
	/**
	* Unsubscribes and removes all Realtime channels from Realtime client.
	*/
	removeAllChannels() {
		return this.realtime.removeAllChannels();
	}
	async _getAccessToken() {
		var _this = this;
		var _data$session$access_, _data$session;
		if (_this.accessToken) return await _this.accessToken();
		const { data } = await _this.auth.getSession();
		return (_data$session$access_ = (_data$session = data.session) === null || _data$session === void 0 ? void 0 : _data$session.access_token) !== null && _data$session$access_ !== void 0 ? _data$session$access_ : _this.supabaseKey;
	}
	_initSupabaseAuthClient({ autoRefreshToken, persistSession, detectSessionInUrl, storage, userStorage, storageKey, flowType, lock, debug, throwOnError }, headers, fetch$1) {
		const authHeaders = {
			Authorization: `Bearer ${this.supabaseKey}`,
			apikey: `${this.supabaseKey}`
		};
		return new SupabaseAuthClient({
			url: this.authUrl.href,
			headers: supabase_js_dist_objectSpread2(supabase_js_dist_objectSpread2({}, authHeaders), headers),
			storageKey,
			autoRefreshToken,
			persistSession,
			detectSessionInUrl,
			storage,
			userStorage,
			flowType,
			lock,
			debug,
			throwOnError,
			fetch: fetch$1,
			hasCustomAuthorizationHeader: Object.keys(this.headers).some((key) => key.toLowerCase() === "authorization")
		});
	}
	_initRealtimeClient(options) {
		return new dist_main/* RealtimeClient */.VH(this.realtimeUrl.href, supabase_js_dist_objectSpread2(supabase_js_dist_objectSpread2({}, options), {}, { params: supabase_js_dist_objectSpread2(supabase_js_dist_objectSpread2({}, { apikey: this.supabaseKey }), options === null || options === void 0 ? void 0 : options.params) }));
	}
	_listenForAuthEvents() {
		return this.auth.onAuthStateChange((event, session) => {
			this._handleTokenChanged(event, "CLIENT", session === null || session === void 0 ? void 0 : session.access_token);
		});
	}
	_handleTokenChanged(event, source, token) {
		if ((event === "TOKEN_REFRESHED" || event === "SIGNED_IN") && this.changedAccessToken !== token) {
			this.changedAccessToken = token;
			this.realtime.setAuth(token);
		} else if (event === "SIGNED_OUT") {
			this.realtime.setAuth();
			if (source == "STORAGE") this.auth.signOut();
			this.changedAccessToken = void 0;
		}
	}
};

//#endregion
//#region src/index.ts
/**
* Creates a new Supabase Client.
*
* @example
* ```ts
* import { createClient } from '@supabase/supabase-js'
*
* const supabase = createClient('https://xyzcompany.supabase.co', 'public-anon-key')
* const { data, error } = await supabase.from('profiles').select('*')
* ```
*/
const createClient = (supabaseUrl, supabaseKey, options) => {
	return new SupabaseClient(supabaseUrl, supabaseKey, options);
};
function shouldShowDeprecationWarning() {
	if (typeof window !== "undefined") return false;
	const _process = globalThis["process"];
	if (!_process) return false;
	const processVersion = _process["version"];
	if (processVersion === void 0 || processVersion === null) return false;
	const versionMatch = processVersion.match(/^v(\d+)\./);
	if (!versionMatch) return false;
	return parseInt(versionMatch[1], 10) <= 18;
}
if (shouldShowDeprecationWarning()) console.warn("⚠️  Node.js 18 and below are deprecated and will no longer be supported in future versions of @supabase/supabase-js. Please upgrade to Node.js 20 or later. For more information, visit: https://github.com/orgs/supabase/discussions/37217");

//#endregion

//# sourceMappingURL=index.mjs.map

/***/ }),

/***/ 1915:
/***/ ((__unused_webpack___webpack_module__, __webpack_exports__, __webpack_require__) => {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "__addDisposableResource": () => (/* binding */ __addDisposableResource),
/* harmony export */   "__assign": () => (/* binding */ __assign),
/* harmony export */   "__asyncDelegator": () => (/* binding */ __asyncDelegator),
/* harmony export */   "__asyncGenerator": () => (/* binding */ __asyncGenerator),
/* harmony export */   "__asyncValues": () => (/* binding */ __asyncValues),
/* harmony export */   "__await": () => (/* binding */ __await),
/* harmony export */   "__awaiter": () => (/* binding */ __awaiter),
/* harmony export */   "__classPrivateFieldGet": () => (/* binding */ __classPrivateFieldGet),
/* harmony export */   "__classPrivateFieldIn": () => (/* binding */ __classPrivateFieldIn),
/* harmony export */   "__classPrivateFieldSet": () => (/* binding */ __classPrivateFieldSet),
/* harmony export */   "__createBinding": () => (/* binding */ __createBinding),
/* harmony export */   "__decorate": () => (/* binding */ __decorate),
/* harmony export */   "__disposeResources": () => (/* binding */ __disposeResources),
/* harmony export */   "__esDecorate": () => (/* binding */ __esDecorate),
/* harmony export */   "__exportStar": () => (/* binding */ __exportStar),
/* harmony export */   "__extends": () => (/* binding */ __extends),
/* harmony export */   "__generator": () => (/* binding */ __generator),
/* harmony export */   "__importDefault": () => (/* binding */ __importDefault),
/* harmony export */   "__importStar": () => (/* binding */ __importStar),
/* harmony export */   "__makeTemplateObject": () => (/* binding */ __makeTemplateObject),
/* harmony export */   "__metadata": () => (/* binding */ __metadata),
/* harmony export */   "__param": () => (/* binding */ __param),
/* harmony export */   "__propKey": () => (/* binding */ __propKey),
/* harmony export */   "__read": () => (/* binding */ __read),
/* harmony export */   "__rest": () => (/* binding */ __rest),
/* harmony export */   "__rewriteRelativeImportExtension": () => (/* binding */ __rewriteRelativeImportExtension),
/* harmony export */   "__runInitializers": () => (/* binding */ __runInitializers),
/* harmony export */   "__setFunctionName": () => (/* binding */ __setFunctionName),
/* harmony export */   "__spread": () => (/* binding */ __spread),
/* harmony export */   "__spreadArray": () => (/* binding */ __spreadArray),
/* harmony export */   "__spreadArrays": () => (/* binding */ __spreadArrays),
/* harmony export */   "__values": () => (/* binding */ __values),
/* harmony export */   "default": () => (__WEBPACK_DEFAULT_EXPORT__)
/* harmony export */ });
/******************************************************************************
Copyright (c) Microsoft Corporation.

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
***************************************************************************** */
/* global Reflect, Promise, SuppressedError, Symbol, Iterator */

var extendStatics = function(d, b) {
  extendStatics = Object.setPrototypeOf ||
      ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
      function (d, b) { for (var p in b) if (Object.prototype.hasOwnProperty.call(b, p)) d[p] = b[p]; };
  return extendStatics(d, b);
};

function __extends(d, b) {
  if (typeof b !== "function" && b !== null)
      throw new TypeError("Class extends value " + String(b) + " is not a constructor or null");
  extendStatics(d, b);
  function __() { this.constructor = d; }
  d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
}

var __assign = function() {
  __assign = Object.assign || function __assign(t) {
      for (var s, i = 1, n = arguments.length; i < n; i++) {
          s = arguments[i];
          for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p)) t[p] = s[p];
      }
      return t;
  }
  return __assign.apply(this, arguments);
}

function __rest(s, e) {
  var t = {};
  for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p) && e.indexOf(p) < 0)
      t[p] = s[p];
  if (s != null && typeof Object.getOwnPropertySymbols === "function")
      for (var i = 0, p = Object.getOwnPropertySymbols(s); i < p.length; i++) {
          if (e.indexOf(p[i]) < 0 && Object.prototype.propertyIsEnumerable.call(s, p[i]))
              t[p[i]] = s[p[i]];
      }
  return t;
}

function __decorate(decorators, target, key, desc) {
  var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
  if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
  else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
  return c > 3 && r && Object.defineProperty(target, key, r), r;
}

function __param(paramIndex, decorator) {
  return function (target, key) { decorator(target, key, paramIndex); }
}

function __esDecorate(ctor, descriptorIn, decorators, contextIn, initializers, extraInitializers) {
  function accept(f) { if (f !== void 0 && typeof f !== "function") throw new TypeError("Function expected"); return f; }
  var kind = contextIn.kind, key = kind === "getter" ? "get" : kind === "setter" ? "set" : "value";
  var target = !descriptorIn && ctor ? contextIn["static"] ? ctor : ctor.prototype : null;
  var descriptor = descriptorIn || (target ? Object.getOwnPropertyDescriptor(target, contextIn.name) : {});
  var _, done = false;
  for (var i = decorators.length - 1; i >= 0; i--) {
      var context = {};
      for (var p in contextIn) context[p] = p === "access" ? {} : contextIn[p];
      for (var p in contextIn.access) context.access[p] = contextIn.access[p];
      context.addInitializer = function (f) { if (done) throw new TypeError("Cannot add initializers after decoration has completed"); extraInitializers.push(accept(f || null)); };
      var result = (0, decorators[i])(kind === "accessor" ? { get: descriptor.get, set: descriptor.set } : descriptor[key], context);
      if (kind === "accessor") {
          if (result === void 0) continue;
          if (result === null || typeof result !== "object") throw new TypeError("Object expected");
          if (_ = accept(result.get)) descriptor.get = _;
          if (_ = accept(result.set)) descriptor.set = _;
          if (_ = accept(result.init)) initializers.unshift(_);
      }
      else if (_ = accept(result)) {
          if (kind === "field") initializers.unshift(_);
          else descriptor[key] = _;
      }
  }
  if (target) Object.defineProperty(target, contextIn.name, descriptor);
  done = true;
};

function __runInitializers(thisArg, initializers, value) {
  var useValue = arguments.length > 2;
  for (var i = 0; i < initializers.length; i++) {
      value = useValue ? initializers[i].call(thisArg, value) : initializers[i].call(thisArg);
  }
  return useValue ? value : void 0;
};

function __propKey(x) {
  return typeof x === "symbol" ? x : "".concat(x);
};

function __setFunctionName(f, name, prefix) {
  if (typeof name === "symbol") name = name.description ? "[".concat(name.description, "]") : "";
  return Object.defineProperty(f, "name", { configurable: true, value: prefix ? "".concat(prefix, " ", name) : name });
};

function __metadata(metadataKey, metadataValue) {
  if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(metadataKey, metadataValue);
}

function __awaiter(thisArg, _arguments, P, generator) {
  function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
  return new (P || (P = Promise))(function (resolve, reject) {
      function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
      function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
      function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
      step((generator = generator.apply(thisArg, _arguments || [])).next());
  });
}

function __generator(thisArg, body) {
  var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g = Object.create((typeof Iterator === "function" ? Iterator : Object).prototype);
  return g.next = verb(0), g["throw"] = verb(1), g["return"] = verb(2), typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
  function verb(n) { return function (v) { return step([n, v]); }; }
  function step(op) {
      if (f) throw new TypeError("Generator is already executing.");
      while (g && (g = 0, op[0] && (_ = 0)), _) try {
          if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
          if (y = 0, t) op = [op[0] & 2, t.value];
          switch (op[0]) {
              case 0: case 1: t = op; break;
              case 4: _.label++; return { value: op[1], done: false };
              case 5: _.label++; y = op[1]; op = [0]; continue;
              case 7: op = _.ops.pop(); _.trys.pop(); continue;
              default:
                  if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                  if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                  if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                  if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                  if (t[2]) _.ops.pop();
                  _.trys.pop(); continue;
          }
          op = body.call(thisArg, _);
      } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
      if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
  }
}

var __createBinding = Object.create ? (function(o, m, k, k2) {
  if (k2 === undefined) k2 = k;
  var desc = Object.getOwnPropertyDescriptor(m, k);
  if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
  }
  Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
  if (k2 === undefined) k2 = k;
  o[k2] = m[k];
});

function __exportStar(m, o) {
  for (var p in m) if (p !== "default" && !Object.prototype.hasOwnProperty.call(o, p)) __createBinding(o, m, p);
}

function __values(o) {
  var s = typeof Symbol === "function" && Symbol.iterator, m = s && o[s], i = 0;
  if (m) return m.call(o);
  if (o && typeof o.length === "number") return {
      next: function () {
          if (o && i >= o.length) o = void 0;
          return { value: o && o[i++], done: !o };
      }
  };
  throw new TypeError(s ? "Object is not iterable." : "Symbol.iterator is not defined.");
}

function __read(o, n) {
  var m = typeof Symbol === "function" && o[Symbol.iterator];
  if (!m) return o;
  var i = m.call(o), r, ar = [], e;
  try {
      while ((n === void 0 || n-- > 0) && !(r = i.next()).done) ar.push(r.value);
  }
  catch (error) { e = { error: error }; }
  finally {
      try {
          if (r && !r.done && (m = i["return"])) m.call(i);
      }
      finally { if (e) throw e.error; }
  }
  return ar;
}

/** @deprecated */
function __spread() {
  for (var ar = [], i = 0; i < arguments.length; i++)
      ar = ar.concat(__read(arguments[i]));
  return ar;
}

/** @deprecated */
function __spreadArrays() {
  for (var s = 0, i = 0, il = arguments.length; i < il; i++) s += arguments[i].length;
  for (var r = Array(s), k = 0, i = 0; i < il; i++)
      for (var a = arguments[i], j = 0, jl = a.length; j < jl; j++, k++)
          r[k] = a[j];
  return r;
}

function __spreadArray(to, from, pack) {
  if (pack || arguments.length === 2) for (var i = 0, l = from.length, ar; i < l; i++) {
      if (ar || !(i in from)) {
          if (!ar) ar = Array.prototype.slice.call(from, 0, i);
          ar[i] = from[i];
      }
  }
  return to.concat(ar || Array.prototype.slice.call(from));
}

function __await(v) {
  return this instanceof __await ? (this.v = v, this) : new __await(v);
}

function __asyncGenerator(thisArg, _arguments, generator) {
  if (!Symbol.asyncIterator) throw new TypeError("Symbol.asyncIterator is not defined.");
  var g = generator.apply(thisArg, _arguments || []), i, q = [];
  return i = Object.create((typeof AsyncIterator === "function" ? AsyncIterator : Object).prototype), verb("next"), verb("throw"), verb("return", awaitReturn), i[Symbol.asyncIterator] = function () { return this; }, i;
  function awaitReturn(f) { return function (v) { return Promise.resolve(v).then(f, reject); }; }
  function verb(n, f) { if (g[n]) { i[n] = function (v) { return new Promise(function (a, b) { q.push([n, v, a, b]) > 1 || resume(n, v); }); }; if (f) i[n] = f(i[n]); } }
  function resume(n, v) { try { step(g[n](v)); } catch (e) { settle(q[0][3], e); } }
  function step(r) { r.value instanceof __await ? Promise.resolve(r.value.v).then(fulfill, reject) : settle(q[0][2], r); }
  function fulfill(value) { resume("next", value); }
  function reject(value) { resume("throw", value); }
  function settle(f, v) { if (f(v), q.shift(), q.length) resume(q[0][0], q[0][1]); }
}

function __asyncDelegator(o) {
  var i, p;
  return i = {}, verb("next"), verb("throw", function (e) { throw e; }), verb("return"), i[Symbol.iterator] = function () { return this; }, i;
  function verb(n, f) { i[n] = o[n] ? function (v) { return (p = !p) ? { value: __await(o[n](v)), done: false } : f ? f(v) : v; } : f; }
}

function __asyncValues(o) {
  if (!Symbol.asyncIterator) throw new TypeError("Symbol.asyncIterator is not defined.");
  var m = o[Symbol.asyncIterator], i;
  return m ? m.call(o) : (o = typeof __values === "function" ? __values(o) : o[Symbol.iterator](), i = {}, verb("next"), verb("throw"), verb("return"), i[Symbol.asyncIterator] = function () { return this; }, i);
  function verb(n) { i[n] = o[n] && function (v) { return new Promise(function (resolve, reject) { v = o[n](v), settle(resolve, reject, v.done, v.value); }); }; }
  function settle(resolve, reject, d, v) { Promise.resolve(v).then(function(v) { resolve({ value: v, done: d }); }, reject); }
}

function __makeTemplateObject(cooked, raw) {
  if (Object.defineProperty) { Object.defineProperty(cooked, "raw", { value: raw }); } else { cooked.raw = raw; }
  return cooked;
};

var __setModuleDefault = Object.create ? (function(o, v) {
  Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
  o["default"] = v;
};

var ownKeys = function(o) {
  ownKeys = Object.getOwnPropertyNames || function (o) {
    var ar = [];
    for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
    return ar;
  };
  return ownKeys(o);
};

function __importStar(mod) {
  if (mod && mod.__esModule) return mod;
  var result = {};
  if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
  __setModuleDefault(result, mod);
  return result;
}

function __importDefault(mod) {
  return (mod && mod.__esModule) ? mod : { default: mod };
}

function __classPrivateFieldGet(receiver, state, kind, f) {
  if (kind === "a" && !f) throw new TypeError("Private accessor was defined without a getter");
  if (typeof state === "function" ? receiver !== state || !f : !state.has(receiver)) throw new TypeError("Cannot read private member from an object whose class did not declare it");
  return kind === "m" ? f : kind === "a" ? f.call(receiver) : f ? f.value : state.get(receiver);
}

function __classPrivateFieldSet(receiver, state, value, kind, f) {
  if (kind === "m") throw new TypeError("Private method is not writable");
  if (kind === "a" && !f) throw new TypeError("Private accessor was defined without a setter");
  if (typeof state === "function" ? receiver !== state || !f : !state.has(receiver)) throw new TypeError("Cannot write private member to an object whose class did not declare it");
  return (kind === "a" ? f.call(receiver, value) : f ? f.value = value : state.set(receiver, value)), value;
}

function __classPrivateFieldIn(state, receiver) {
  if (receiver === null || (typeof receiver !== "object" && typeof receiver !== "function")) throw new TypeError("Cannot use 'in' operator on non-object");
  return typeof state === "function" ? receiver === state : state.has(receiver);
}

function __addDisposableResource(env, value, async) {
  if (value !== null && value !== void 0) {
    if (typeof value !== "object" && typeof value !== "function") throw new TypeError("Object expected.");
    var dispose, inner;
    if (async) {
      if (!Symbol.asyncDispose) throw new TypeError("Symbol.asyncDispose is not defined.");
      dispose = value[Symbol.asyncDispose];
    }
    if (dispose === void 0) {
      if (!Symbol.dispose) throw new TypeError("Symbol.dispose is not defined.");
      dispose = value[Symbol.dispose];
      if (async) inner = dispose;
    }
    if (typeof dispose !== "function") throw new TypeError("Object not disposable.");
    if (inner) dispose = function() { try { inner.call(this); } catch (e) { return Promise.reject(e); } };
    env.stack.push({ value: value, dispose: dispose, async: async });
  }
  else if (async) {
    env.stack.push({ async: true });
  }
  return value;
}

var _SuppressedError = typeof SuppressedError === "function" ? SuppressedError : function (error, suppressed, message) {
  var e = new Error(message);
  return e.name = "SuppressedError", e.error = error, e.suppressed = suppressed, e;
};

function __disposeResources(env) {
  function fail(e) {
    env.error = env.hasError ? new _SuppressedError(e, env.error, "An error was suppressed during disposal.") : e;
    env.hasError = true;
  }
  var r, s = 0;
  function next() {
    while (r = env.stack.pop()) {
      try {
        if (!r.async && s === 1) return s = 0, env.stack.push(r), Promise.resolve().then(next);
        if (r.dispose) {
          var result = r.dispose.call(r.value);
          if (r.async) return s |= 2, Promise.resolve(result).then(next, function(e) { fail(e); return next(); });
        }
        else s |= 1;
      }
      catch (e) {
        fail(e);
      }
    }
    if (s === 1) return env.hasError ? Promise.reject(env.error) : Promise.resolve();
    if (env.hasError) throw env.error;
  }
  return next();
}

function __rewriteRelativeImportExtension(path, preserveJsx) {
  if (typeof path === "string" && /^\.\.?\//.test(path)) {
      return path.replace(/\.(tsx)$|((?:\.d)?)((?:\.[^./]+?)?)\.([cm]?)ts$/i, function (m, tsx, d, ext, cm) {
          return tsx ? preserveJsx ? ".jsx" : ".js" : d && (!ext || !cm) ? m : (d + ext + "." + cm.toLowerCase() + "js");
      });
  }
  return path;
}

/* harmony default export */ const __WEBPACK_DEFAULT_EXPORT__ = ({
  __extends,
  __assign,
  __rest,
  __decorate,
  __param,
  __esDecorate,
  __runInitializers,
  __propKey,
  __setFunctionName,
  __metadata,
  __awaiter,
  __generator,
  __createBinding,
  __exportStar,
  __values,
  __read,
  __spread,
  __spreadArrays,
  __spreadArray,
  __await,
  __asyncGenerator,
  __asyncDelegator,
  __asyncValues,
  __makeTemplateObject,
  __importStar,
  __importDefault,
  __classPrivateFieldGet,
  __classPrivateFieldSet,
  __classPrivateFieldIn,
  __addDisposableResource,
  __disposeResources,
  __rewriteRelativeImportExtension,
});


/***/ })

};
;