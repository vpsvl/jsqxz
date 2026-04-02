<template>
  <div class="v-pages" :class="classList">
    <slot></slot>
    <div class="v-pages-holder"></div>
    <div class="v-pages-pager" v-if="total >= 0">
      <div class="pager-total">
        共
        <span disabled>{{ state.pageTotal }}</span>
        页
        <span disabled>{{ total }}</span>
        条
      </div>
      <a href="javascript: void(0);" class="pager-arrow paper-prev" @click="prevClick"></a>
      <template v-for="(num, i) of pagerList" :key="num">
        <a
          v-if="num === 'ellipsis'"
          href="javascript: void(0);"
          class="pager-item pager-ellipsis"
          @click="ellipsisClick(i)"
        >
          …
        </a>
        <label v-else class="pager-item pager-page">
          <input type="radio" :value="num" v-model="state.current" @change="handlePage(num)" />
          <span>{{ num }}</span>
        </label>
      </template>
      <a href="javascript: void(0);" class="pager-arrow paper-next" @click="nextClick"></a>
      <div class="pager-item pager-go">
        <input type="text" class="go-input" v-model="state.pageNum" @keyup.enter="goClick" />
        <a href="javascript: void(0);" class="go-btn" @click="goClick">跳转</a>
      </div>
    </div>
  </div>
</template>

<script setup>
import {reactive, computed, onBeforeMount} from 'vue';

const props = defineProps({
  // 总条数, 小于0不显示分页
  total: {
    type: [Number, String],
    default: 0,
  },
  // 每页条数
  pageSize: {
    type: [Number, String],
    default: 10,
  },
  // 当前页
  page: {
    type: [Number, String],
    default: 1,
  },
  // 前后固定按钮个数
  side: {
    type: Number,
    default: 1,
  },
  // 页码按钮总数
  pagerCount: {
    type: Number,
    default: 7,
  },
  background: {
    type: Boolean,
    default: false,
  },
  size: {
    type: String,
    default: 'default',
  },
});
const emit = defineEmits(['update:page']);

const sizeMap = {
  large: true,
  small: true,
  mini: true,
};

const classList = computed(() => {
  const list = [];
  if (props.background) {
    list.push('is-background');
  }
  if (sizeMap[props.size]) {
    list.push(`is-${props.size}`);
  }
  return list;
});
const state = reactive({
  // 当前页
  current: 1,
  // 输入的页码
  pageNum: '',
  // 总页数
  pageTotal: computed(() => {
    let pageTotal = Math.ceil(props.total / props.pageSize);
    if (Number.isNaN(pageTotal) || pageTotal < 1) {
      return 1;
    }
    return pageTotal;
  }),
});

// 显示的页面按钮列表
const pagerList = computed(() => {
  const result = [];
  if (state.pageTotal <= props.pagerCount) {
    for (let i = 1; i <= state.pageTotal; i++) {
      result.push(i);
    }
    return result;
  }
  // 中间按钮个数
  const middleCount = props.pagerCount - 2 * props.side;
  // 中间按钮最小起始值
  const middleStartMin = props.side + 1;
  // 中间按钮最大结束值
  const middleEndMax = state.pageTotal - props.side;
  // 中间按钮起始值
  let middleStart = state.current - Math.max(0, Math.floor((middleCount - 1) / 2));
  // 中间按钮结束值
  let middleEnd = state.current + Math.max(0, Math.ceil((middleCount - 1) / 2));
  if (middleStart < middleStartMin) {
    middleStart = middleStartMin;
    middleEnd = middleStart + middleCount - 1;
  }
  if (middleEnd > middleEndMax) {
    middleEnd = middleEndMax;
    middleStart = middleEnd - middleCount + 1;
  }
  for (let i = 1; i <= props.side; i++) {
    result.push(i);
  }
  if (middleStart > middleStartMin) {
    result.push('ellipsis');
  }
  for (let i = middleStart; i <= middleEnd; i++) {
    result.push(i);
  }
  if (middleEnd < middleEndMax) {
    result.push('ellipsis');
  }
  for (let i = 1; i <= props.side; i++) {
    result.push(i + middleEndMax);
  }
  return result;
});

// 格式化页码
function formatPage(page) {
  let pageNow = Number.parseInt(page);
  if (Number.isNaN(pageNow) || pageNow <= 1) {
    return 1;
  }
  if (pageNow >= state.pageTotal) {
    return state.pageTotal;
  }
  return pageNow;
}

onBeforeMount(() => {
  if (state.current === Number(props.page)) {
    return;
  }
  state.current = formatPage(props.page);
});

// 上一页
function prevClick() {
  if (state.current <= 1) {
    return;
  }
  state.current--;
  handlePage();
}

// 下一页
function nextClick() {
  if (state.current >= state.pageTotal) {
    return;
  }
  state.current++;
  handlePage();
}

// 点击省略号
function ellipsisClick(index) {
  const num = Math.max(1, Math.floor(props.pagerCount / 2) - props.side);
  if (index === props.side) {
    state.current -= num;
  } else {
    state.current += num;
  }
  handlePage();
}

// 跳转到输入的页码
function goClick() {
  let pageNum = formatPage(state.pageNum);
  if (state.current === pageNum) {
    return;
  }
  state.current = pageNum;
  state.pageNum = pageNum + '';
  handlePage();
}

// 页面改变
function handlePage() {
  emit('update:page', state.current);
}
</script>
<style lang="less">
.v-pages {
  --pager-height: var(--height-default);
  --pager-width: 20px;
  --pager-background: transparent;
  --pager-background-hover: var(--color-bg-hover);
  --pager-background-active: transparent;
  --pager-color: var(--color-content);
  --pager-color-hover: var(--color-info);
  --pager-color-active: var(--color-primary);
  --pager-arrow-color: var(--color-content);

  padding: 5px 0;
  background: #fff;

  &.is-small {
    --pager-height: var(--height-small);
  }

  &.is-large {
    --pager-height: var(--height-large);
  }

  &.is-background {
    --pager-width: var(--pager-height);
    --pager-background: var(--color-bg-gray);
    --pager-background-active: var(--color-primary);
    --pager-color-active: #fff;

    padding: 5px 0;
  }

  display: flex;
  align-items: center;

  .v-pages-holder {
    flex: 1 0 0;
  }

  .v-pages-pager {
    display: flex;
    align-items: center;
  }

  .pager-total {
    padding: 0 5px;
    color: var(--color-gray);

    span {
      margin: 0 2px;
      color: var(--color-content);
    }
  }

  .pager-item {
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 2px;
    height: var(--pager-height);
    color: var(--pager-color);
  }

  .pager-ellipsis {
    cursor: pointer;
    min-width: var(--pager-width);
  }

  .pager-page {
    input[type='radio'] {
      display: none;

      &:checked + span {
        color: var(--pager-color-active);
        background: var(--pager-background-active);
      }
    }

    span {
      display: block;
      height: var(--pager-height);
      min-width: var(--pager-width);
      border-radius: 4px;
      color: var(--pager-color);
      text-align: center;
      line-height: var(--pager-height);
      cursor: pointer;
      transition: all 0.2s;

      &:hover {
        color: var(--pager-color-hover);
      }
    }
  }

  .pager-arrow {
    --arrow-rotate: 0;

    display: flex;
    height: var(--pager-height);
    align-items: center;

    &:hover {
      --pager-arrow-color: var(--color-primary);
    }

    &::before {
      content: '';
      display: block;
      height: 6px;
      width: 6px;
      border-top: 1px solid var(--pager-arrow-color);
      border-left: 1px solid var(--pager-arrow-color);
      transform: rotate(var(--arrow-rotate));
    }

    &.paper-prev {
      --arrow-rotate: -45deg;
      padding-left: 4px;
    }

    &.paper-next {
      --arrow-rotate: 135deg;
      padding-right: 6px;
    }
  }

  .pager-go {
    padding: 2px 0;

    .go-input {
      width: 50px;
      height: 100%;
      padding: 0 5px;
      margin-right: 4px;
      border-radius: 4px;
      border: 1px solid var(--color-border);
      color: var(--color-content);
      text-align: center;
    }

    .go-btn {
      color: var(--color-content);

      &:hover {
        color: var(--color-primary);
      }
    }
  }
}
</style>
