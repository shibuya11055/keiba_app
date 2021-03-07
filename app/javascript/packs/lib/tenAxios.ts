import axios, { AxiosInstance, AxiosPromise, AxiosRequestConfig } from 'axios';
import { caseChangeTransformer } from './axios';

const API_URL = '/api/v1'

export const createTenAxios = (opt?: AxiosRequestConfig) => {
  const option = opt || {};
  const tenAxios = axios.create(option);
  tenAxios.defaults.baseURL = API_URL

  tenAxios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
  };

  return tenAxios as AxiosInstance & {
    get<T = any>(url: string): AxiosPromise<T>;
  };
};

export default createTenAxios(caseChangeTransformer);