import { camelCase } from 'camel-case';
import { snakeCase } from 'snake-case';

export const changeCaseDeep = (data: unknown, converter: Function): unknown => {
  if (Array.isArray(data)) {
    return data.map(d => changeCaseDeep(d, converter));
  }

  if (typeof data === 'object') {
    if (data === null) {
      return data;
    }

    const keys = Object.keys(data);
    if (!keys.length) {
      return data;
    }

    return keys.reduce((obj, key) => {
      obj[converter(key)] = changeCaseDeep((data as Record<string, unknown>)[key], converter);
      return obj;
    }, {} as Record<string, unknown>);
  }

  return data;
};


export const changeToSnakeCaseDeep = (data: unknown): unknown => {
  return changeCaseDeep(data, snakeCase);
};

export const changeToCamelCaseDeep = (data: unknown): unknown => {
  return changeCaseDeep(data, camelCase);
};
