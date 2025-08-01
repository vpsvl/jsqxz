export default {
  rules: {
    /* recommend */
    // 禁止未知注释
    'annotation-no-unknown': true,
    // 禁止未知的@规则
    'at-rule-no-unknown': true,
    // 禁止空块
    'block-no-empty': true,
    // 禁止空注释
    'comment-no-empty': true,
    // 禁止无效的十六进制颜色
    'color-no-invalid-hex': true,
    // 禁止自定义属性缺少 var 函数
    'custom-property-no-missing-var-function': true,
    // 禁止声明块内出现重复的自定义属性
    'declaration-block-no-duplicate-custom-properties': true,
    // 禁止声明块内出现重复的属性
    'declaration-block-no-duplicate-properties': [
      true,
      {
        // 忽略具有不同值语法（类型和值单位）的连续重复属性
        ignore: ['consecutive-duplicates-with-different-syntaxes'],
      },
    ],
    // 禁止简写属性覆盖相关的普通属性
    'declaration-block-no-shorthand-property-overrides': true,
    // 禁止字体系列中出现重复名称
    'font-family-no-duplicate-names': true,
    // 禁止字体系列中缺少通用系列关键字
    'font-family-no-missing-generic-family-keyword': true,
    // 不允许在 calc 函数中使用无效的无空格运算符
    'function-calc-no-unspaced-operator': true,
    // 禁止线性梯度函数使用非标准方向值
    'function-linear-gradient-no-nonstandard-direction': true,
    // 禁止未知功能
    'function-no-unknown': true,
    // 禁止关键帧块内出现重复的选择器
    'keyframe-block-no-duplicate-selectors': true,
    // 禁止关键帧声明中存在无效的 !important
    'keyframe-declaration-no-important': true,
    // 禁止未知的媒体功能名称
    'media-feature-name-no-unknown': true,
    // 禁止无效的媒体查询
    'media-query-no-invalid': true,
    // 禁止无效的命名网格区域
    'named-grid-areas-no-invalid': true,
    // 禁止较低特异性的选择器覆盖较高特异性的选择器
    'no-descending-specificity': true,
    // 禁止重复的 @import 规则
    'no-duplicate-at-import-rules': true,
    // 禁止重复的选择器
    'no-duplicate-selectors': true,
    // 禁止空源
    'no-empty-source': true,
    // 禁止无效的双斜杠注释
    'no-invalid-double-slash-comments': true,
    // 不允许无效的位置 @import 规则
    'no-invalid-position-at-import-rule': true,
    // 禁止出现不规则的空白
    'no-irregular-whitespace': true,
    // 禁止未知属性
    'property-no-unknown': true,
    // 禁止使用不匹配的 An+B 选择器
    'selector-anb-no-unmatchable': true,
    // 禁止未知的伪类选择器
    'selector-pseudo-class-no-unknown': true,
    // 禁止未知的伪元素选择器
    'selector-pseudo-element-no-unknown': true,
    // 禁止未知类型选择器
    'selector-type-no-unknown': [
      true,
      {
        // 忽略自定义元素
        ignore: ['custom-elements'],
      },
    ],
    // 禁止字符串中无效的换行符
    'string-no-newline': true,
    // 禁止未知单位
    'unit-no-unknown': [
      true,
      {
        // 忽略的单位
        ignoreUnits: [],
      },
    ],
    /* standard */
    // 指定 alpha 值的百分比percentage或数字number表示法
    'alpha-value-notation': [
      'percentage',
      {
        exceptProperties: [
          'opacity',
          'fill-opacity',
          'flood-opacity',
          'stop-opacity',
          'stroke-opacity',
          'color',
          'background-color',
        ],
      },
    ],
    // 要求(always)或不允许(never) @ 规则前有空行
    'at-rule-empty-line-before': [
      'always',
      {
        except: ['blockless-after-same-name-blockless', 'first-nested'],
        ignore: ['after-comment'],
      },
    ],
    // 禁止 at 规则使用浏览器前缀
    'at-rule-no-vendor-prefix': true,
    // 指定颜色函数的现代(modern: rgba(0 0 0 / 0.5))或传统(legacy)符号
    'color-function-notation': [
      'legacy',
      {
        ignore: ['with-var-inside'],
      },
    ],
    // 指定十六进制颜色的短(short)或长(long)表示法
    'color-hex-length': 'short',
    // 要求或禁止注释前有空行
    'comment-empty-line-before': [
      'always',
      {
        except: ['first-nested'],
        ignore: ['stylelint-commands'],
      },
    ],
    // 要求或禁止注释标记内部有空格
    'comment-whitespace-inside': 'always',
    // 要求或禁止自定义属性前有空行
    'custom-property-empty-line-before': [
      'always',
      {
        // 反转另一个自定义属性后面的自定义属性的主要选项, 反转嵌套的自定义属性及其父节点的第一个子节点的主要选项
        except: ['after-custom-property', 'first-nested'],
        // 忽略注释后面的自定义属性, 忽略单行块内的自定义属性
        ignore: ['after-comment', 'inside-single-line-block'],
      },
    ],
    // 指定自定义媒体查询名称的模式
    'custom-media-pattern': [
      '^([a-z][a-z0-9]*)(-[a-z0-9]+)*$',
      {
        message: (name) => `Expected custom media query name "${name}" to be kebab-case`,
      },
    ],
    // 指定自定义属性的模式
    'custom-property-pattern': [
      '^([a-z][a-z0-9]*)(-[a-z0-9]+)*$',
      {
        message: (name) => `Expected custom property name "${name}" to be kebab-case`,
      },
    ],
    // 禁止声明块中存在多余的普通属性
    'declaration-block-no-redundant-longhand-properties': true,
    // 限制单行声明块内的声明数量
    'declaration-block-single-line-max-declarations': 1,
    // 要求或禁止声明前有空行
    'declaration-empty-line-before': [
      'always',
      {
        except: ['after-declaration', 'first-nested'],
        ignore: ['after-comment', 'inside-single-line-block'],
      },
    ],
    // 要求或禁止对字体系列名称使用引号 always-where-recommended仅当根据标准推荐引号时才期望引号，并且在所有其他情况下不允许引号
    'font-family-name-quotes': 'always-where-recommended',
    // 指定函数名称的小写(lower)或大写(upper)
    'function-name-case': 'lower',
    // 需要或禁止 URL 引号
    'function-url-quotes': 'always',
    // 指定色调的数字(number)或角度符号(angle)
    'hue-degree-notation': 'angle',
    // 为 @import 规则指定字符串(string)或URL(url)表示法
    'import-notation': 'url',
    'keyframe-selector-notation': 'percentage-unless-within-keyword-only-block',
    // 为关键帧选择器指定关键字或百分比表示法
    'keyframes-name-pattern': [
      '^([a-z][a-z0-9]*)(-[a-z0-9]+)*$',
      {
        message: (name) => `Expected keyframe name "${name}" to be kebab-case`,
      },
    ],
    // 长度为0, 不允许使用单位
    'length-zero-no-unit': [
      true,
      {
        ignore: ['custom-properties'],
      },
    ],
    // 明度表示法使用百分比
    'lightness-notation': 'percentage',
    // 禁止媒体功能名称使用浏览器前缀
    'media-feature-name-no-vendor-prefix': true,
    // 指定媒体功能范围的上下文(context: >=, <=)或前缀(prefix: max-, min-)表示法
    'media-feature-range-notation': 'context',
    // 限制数字中允许的小数位数
    'number-max-precision': 4,
    // 禁止属性使用浏览器前缀
    'property-no-vendor-prefix': true,
    // 要求或禁止规则前有空行 "always"|"never"|"always-multi-line"|"never-multi-line"
    'rule-empty-line-before': [
      'always-multi-line',
      {
        except: ['first-nested'],
        ignore: ['after-comment'],
      },
    ],
    // 需要或禁止对属性值使用引号 [target="_blank"]
    'selector-attribute-quotes': 'always',
    // 指定类选择器的格式
    'selector-class-pattern': [
      '^([a-z][a-z0-9]*)(-[a-z0-9]+)*$',
      {
        message: (selector) => `Expected class selector "${selector}" to be kebab-case`,
      },
    ],
    // 指定id选择器的格式
    'selector-id-pattern': [
      '^([a-z][a-z0-9]*)(-[a-z0-9]+)*$',
      {
        message: (selector) => `Expected id selector "${selector}" to be kebab-case`,
      },
    ],
    // 禁止选择器使用浏览器前缀
    'selector-no-vendor-prefix': [
      true,
      {
        ignoreSelectors: ['/-webkit-.*/'],
      },
    ],
    // 为 :not() 伪类选择器指定简单(simple)或复杂(complex)的表示法
    'selector-not-notation': 'complex',
    // 为适用的伪元素选择器指定单冒号(single)或双冒号(double)表示法 (:before或::before)
    'selector-pseudo-element-colon-notation': 'double',
    // 指定类型选择器的小写(lower)或大写(upper)
    'selector-type-case': 'lower',
    // 禁止可简写的属性中存在冗余值
    'shorthand-property-no-redundant-values': true,
    // 指定关键字值的小写或大写
    'value-keyword-case': 'lower',
    // 禁止值使用浏览器前缀
    'value-no-vendor-prefix': [
      true,
      {
        // `-webkit-box` is allowed as standard. See https://www.w3.org/TR/css-overflow-3/#webkit-line-clamp
        ignoreValues: ['box', 'inline-box'],
      },
    ],
  },
};