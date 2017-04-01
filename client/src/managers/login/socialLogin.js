import hello from 'hellojs';
import axios from 'axios';
import config from '../../config';

hello.init({
  facebook: 1416742531681673,
  google: 'client_id'
});

let socialLogin = service => {
  let accessToken;
  service = hello(service);
  return new Promise((resolve, reject) => {
    service.login()
      .then(() => {
        accessToken = service.getAuthResponse().access_token;
        return service.api('me');
      })
      .then(user => resolve(user, accessToken));
  });
};

let getAccessTokenFromServer = accessToken => {
  let request = axios.post(`${config.apiUrl}/login/facebook`, {accessToken});
  return new Promise((resolve, reject) => {
    request
      .then(response => {
        resolve(response);
      })
      .catch(error => {
        reject(error);
      })
  });
};

export {socialLogin, getAccessTokenFromServer};
