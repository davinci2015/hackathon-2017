import { storageConst} from '../../constants';

/**
 * Save store state to local storage
 * @param state
 * @returns undefined if error occurred
 */
export function saveStateToStorage(state) {
  try {
    localStorage.setItem(storageConst.STATE, JSON.stringify(state));
  } catch (error) {
    return undefined;
  }
}

/**
 * Get redux state from local storage
 * @returns undefined or json object
 */
export function loadStateFromStorage() {
  try {
    const state = localStorage.getItem(storageConst.STATE);
    return state === null ? undefined : JSON.parse(state);
  } catch (error) {
    // console.log(error);
  }
}

/**
 * Save access token to storage
 * @param accessToken
 * @returns {undefined}
 */
export function saveAccessTokenToStorage(accessToken) {
  try {
    localStorage.setItem(storageConst.ACCESS_TOKEN, JSON.stringify(accessToken));
  } catch (error) {
    return undefined;
  }
}

/**
 * Get access token from storage
 * @returns {undefined || String}
 */
export function getAccessTokenFromStorage() {
  try {
    const accessToken = localStorage.getItem(storageConst.ACCESS_TOKEN);
    return accessToken === null ? undefined : JSON.parse(accessToken);
  } catch (error) {}
}

/**
 * Delete access token from local storage
 */
export function deleteAccessTokenFromStorage() {
  try {
    localStorage.removeItem(storageConst.ACCESS_TOKEN);
  } catch (error) {}
}
