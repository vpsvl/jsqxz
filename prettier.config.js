module.exports = {
  tabSize: 2,
  // 加分号
  semi: true,
  // 单引号
  singleQuote: true,
  // 尾行逗号
  trailingComma: 'es5',
  // 对象{}里前后空格
  bracketSpacing: false,
  htmlWhitespaceSensitivity: 'ignore',
  printWidth: 140,
  // 保持对象key的引号 "as-needed", "consistent" or "preserve"
  quoteProps: 'as-needed',
  // tab 代码补全
  'files.associations': {
    '*.wpy': 'vue',
    '*.vue': 'vue',
    '*.cjson': 'jsonc',
    '*.wxss': 'css',
    '*.wxs': 'javascript',
  },
  // 函数名和后面的括号之间加个空格
  'javascript.format.insertSpaceBeforeFunctionParenthesis': false,
};
