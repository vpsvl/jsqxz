import {defineConfig} from 'eslint/config';
import pluginVue from 'eslint-plugin-vue';
import stylistic from '@stylistic/eslint-plugin';

export default defineConfig([
  {
    languageOptions: {
      ecmaVersion: 'latest',
    },
    extends: [
      'vue/essential',
    ],
    plugins: {
      vue: pluginVue,
      '@stylistic': stylistic,
    },
    // 级别: 0-忽略 1-警告 2-错误
    rules: {
      // 2个空格缩进
      '@stylistic/indent': [2, 2, {
        // case缩进级别
        SwitchCase: 1,
      }],
      // 单引号跟反引号
      '@stylistic/quotes': [2, 'single', {allowTemplateLiterals: 'always'}],
      // 禁止不必要的分号
      '@stylistic/no-extra-semi': 2,
      // 数组和对象键值对最后一个逗号:
      // never: 不能带末尾的逗号
      // always: 必须带末尾的逗号
      // always-multiline: 多行模式必须带逗号，单行模式不能带逗号
      '@stylistic/comma-dangle': [2, 'always-multiline'],
      // 控制逗号前后的空格
      '@stylistic/comma-spacing': [2, {before: false, after: true}],
      // 不允许多个空行
      '@stylistic/no-multiple-empty-lines': [2, {max: 2}],
      // 箭头函数参数加括号: always, as-needed { requireForBlockBody: true }
      '@stylistic/arrow-parens': [0, 'as-needed'],
      // 驼峰命名
      'camelcase': 0,
      // 禁止var
      'no-var': 2,
      // 禁止重复的 case 标签
      'no-duplicate-case': 2,
      // switch 语句强制 default 分支
      'default-case': 2,
      // 禁用 debugger
      'no-debugger': 2,
      // 禁止 function 定义中出现重名参数
      'no-dupe-args': 2,
      // 禁止对象字面量中出现重复的 key
      'no-dupe-keys': 2,
      // 禁止空语句块
      'no-empty': 2,
      // 禁止出现空函数.如果一个函数包含了一条注释，它将不会被认为有问题。
      'no-empty-function': 2,
      // 禁止使用空解构模式no-empty-pattern
      'no-empty-pattern': 2,
      // 禁止在正则表达式中使用空字符集 (/^abc[]/)
      'no-empty-character-class': 2,
      // 禁止对 catch 子句的参数重新赋值
      'no-ex-assign': 2,
      // 禁止不必要的布尔转换
      'no-extra-boolean-cast': 2,
      // 禁止不必要的括号 //(a * b) + c;//报错
      'no-extra-parens': 1,
      // 禁止对 function 声明重新赋值
      'no-func-assign': 2,
      // 禁止 RegExp 构造函数中无效的正则表达式字符串
      'no-invalid-regexp': 2,
      // 禁止在字符串和注释之外不规则的空白
      'no-irregular-whitespace': 2,
      // 禁止正则表达式字面量中出现多个空格
      'no-regex-spaces': 2,
      // 禁止在return、throw、continue 和 break语句之后出现代码
      'no-unreachable': 2,
      // 禁止在没有类型检查操作符的情况下与 null 进行比较
      'no-eq-null': 2,
      // 禁用 eval()
      'no-eval': 2,
      // 强制 typeof 表达式与有效的字符串进行比较
      // typeof foo === 'undefimed' 错误
      'valid-typeof': 2,
      // vue组件命名
      'vue/multi-word-component-names': 0,
      // vue注册了没有使用的组件
      'vue/no-unused-components': 1,
    },
  },
]);
