import axios, { AxiosTransformer } from 'axios';
import { changeToCamelCaseDeep, changeToSnakeCaseDeep } from './changeCaseDeep';

export const caseChangeTransformer = {
  transformRequest: ([(data: any, _headers: any) => changeToSnakeCaseDeep(data)] as AxiosTransformer[]).concat(axios.defaults.transformRequest || []),
  transformResponse: ([] as AxiosTransformer[]).concat(axios.defaults.transformResponse || []).concat((data: any) => changeToCamelCaseDeep(data))
};