import axios from 'axios';
import {getAccessTokenFromStorage} from '../storage/localStorage';
import config from '../../config';

let request = axios.create({
  baseURI: config.apiUrl,
  headers: {
    'Authorization': `Bearer ${getAccessTokenFromStorage()}`,
  },
});

export default request;
