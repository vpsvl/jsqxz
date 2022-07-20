<template>
  <div class="v-scroll" ref="scrollDom">
    <div class="v-scroll-box" ref="scrollBoxDom" @scroll="handleScroll" :style="scrollStyle">
      <div :class="['v-scroll-view', viewClass]" ref="scrollViewDom">
        <slot></slot>
      </div>
    </div>
    <div class="v-scroll-track v-scroll-track-x" @mousedown="clickTrack($event, 'x')">
      <div class="v-scroll-thumb" :style="thumbXStyle" @mousedown="dragThumb($event, 'x')"></div>
    </div>
    <div class="v-scroll-track v-scroll-track-y" @mousedown="clickTrack($event, 'y')">
      <div class="v-scroll-thumb" :style="thumbYStyle" @mousedown="dragThumb($event, 'y')"></div>
    </div>
  </div>
</template>

<script>
import {ref, reactive, toRefs, computed, watch, onMounted, onBeforeUnmount, nextTick} from 'vue';
import {useScrollWidth, addResizeListener, removeResizeListener} from './utils/scroll';

const KEY_MAP = {
  x: {
    wrapWidth: 'wrapWidth',
    viewWidth: 'viewWidth',
    maxLeft: 'maxLeft',
    left: 'left',
    thumbWidth: 'thumbWidth',
    clientWidth: 'clientWidth',
    scrollWidth: 'scrollWidth',
    clientX: 'clientX',
    x0: 'x0',
    x: 'x',
  },
  y: {
    wrapWidth: 'wrapHeight',
    viewWidth: 'viewHeight',
    maxLeft: 'maxTop',
    left: 'top',
    thumbWidth: 'thumbHeight',
    clientWidth: 'clientHeight',
    scrollWidth: 'scrollHeight',
    clientX: 'clientY',
    x0: 'y0',
    x: 'y',
  },
};

export default {
  name: 'vScroll',
  emits: {
    scroll: null,
  },
  props: {
    // 滑块初始位置, 小于0为滚动到最右边
    x: {
      type: Number,
      default: 0,
    },
    // 滑块初始位置, 小于0为滚动到最底部
    y: {
      type: Number,
      default: 0,
    },
    // view class
    viewClass: {
      type: String,
    },
  },
  setup(props, {emit}) {
    // 滚动条宽度
    const {width: scrollWidth} = useScrollWidth();
    const scrollDom = ref(null);
    const scrollBoxDom = ref(null);
    const scrollViewDom = ref(null);
    const _state = reactive({
      // 滑块位置
      left: 0,
      top: 0,
      // 容器
      wrapWidth: 0,
      wrapHeight: 0,
      // 内容
      viewWidth: 0,
      viewHeight: 0,
      // 滑块剧顶部最大高度
      maxLeft: 0,
      maxTop: 0,
      // 拖动滚动条滑块的初始位置
      x0: 0,
      y0: 0,
      moveDirection: 'x',
      // 滑块高度
      thumbWidth: 0,
      thumbHeight: 0,
    });
    watch(
      () => props.x,
      (val) => {
        getSize('x');
        _state.left = val < 0 ? _state.maxLeft : limitRange(val, 'x');
      }
    );
    watch(
      () => props.y,
      (val) => {
        getSize('y');
        _state.top = val < 0 ? _state.maxTop : limitRange(val, 'y');
      }
    );
    watch(
      () => _state.left,
      (val) => {
        scrollBoxDom.value.scrollLeft = val;
      }
    );
    watch(
      () => _state.top,
      (val) => {
        scrollBoxDom.value.scrollTop = val;
      }
    );
    const state = reactive({
      // 出滚动条的元素的样式
      scrollStyle: computed(() => {
        let length = `calc(100% + ${scrollWidth.value}px)`;
        return {
          width: length,
          height: length,
        };
      }),
      // 滑块样式
      thumbXStyle: computed(() => {
        let per = _state.wrapWidth / _state.viewWidth;
        if (per >= 1) {
          per = 0;
        }
        let thumbLeft = Math.round(_state.left * per);
        return {
          width: `${_state.thumbWidth}px`,
          transform: `translateX(${thumbLeft}px)`,
        };
      }),
      thumbYStyle: computed(() => {
        let per = _state.wrapHeight / _state.viewHeight;
        if (per >= 1) {
          per = 0;
        }
        let thumbTop = Math.round(_state.top * per);
        return {
          height: `${_state.thumbHeight}px`,
          transform: `translateY(${thumbTop}px)`,
        };
      }),
    });

    function limitRange(val, key = 'x') {
      const {maxLeft} = KEY_MAP[key];
      if (val < 0) {
        val = 0;
      } else if (val > _state[maxLeft]) {
        val = _state[maxLeft];
      }
      return val;
    }

    function getSize(key = 'x') {
      const {clientWidth, scrollWidth, wrapWidth, viewWidth, maxLeft, thumbWidth} = KEY_MAP[key];
      const wrapSize = scrollBoxDom.value[clientWidth];
      const viewSize = scrollBoxDom.value[scrollWidth];
      _state[wrapWidth] = wrapSize;
      _state[viewWidth] = viewSize;
      if (wrapSize >= viewSize) {
        _state[maxLeft] = 0;
        _state[thumbWidth] = 0;
      } else {
        _state[maxLeft] = viewSize - wrapSize;
        _state[thumbWidth] = Math.round((wrapSize * wrapSize) / viewSize);
      }
    }

    // 更新尺寸
    function updateSize() {
      getSize('x');
      getSize('y');
    }

    function resizeDom() {
      let timer;
      return () => {
        clearTimeout(timer);
        timer = setTimeout(() => {
          updateSize();
        }, 200);
      };
    }

    // 鼠标滚动
    function handleScroll(e) {
      const {scrollTop, scrollLeft} = e.target;
      _state.left = scrollLeft;
      _state.top = scrollTop;
      emit('scroll', {scrollTop, scrollLeft});
    }

    // 点击滚动条轨道
    function clickTrack(e, key) {
      const {clientX, left, thumbWidth, wrapWidth, viewWidth} = KEY_MAP[key];
      const offset = e[clientX] - e.target.getBoundingClientRect()[left];
      const thumbHalf = _state[thumbWidth] / 2;
      _state[left] = limitRange(((offset - thumbHalf) * _state[viewWidth]) / _state[wrapWidth], key);
      emit('scroll', {
        scrollLeft: _state.left,
        scrollTop: _state.top,
      });
    }

    // 鼠标在滑块上按下
    function dragThumb(e, key = 'x') {
      e.stopPropagation();
      _state.moveDirection = key;
      const {x0, clientX} = KEY_MAP[key];
      _state[x0] = e[clientX];
      document.addEventListener('mousemove', mouseMove);
      document.addEventListener('mouseup', mouseUp);
      document.onselectstart = () => false;
    }

    // 鼠标滑动
    function mouseMove(e) {
      e.preventDefault();
      const {x0, clientX, left, maxLeft, wrapWidth, viewWidth} = KEY_MAP[_state.moveDirection];
      const x = e[clientX];
      if ((x <= _state[x0] && _state[left] <= 0) || (x >= _state[x0] && _state[left] >= _state[maxLeft])) {
        return false;
      }
      _state[left] = limitRange(_state[left] + ((x - _state[x0]) * _state[viewWidth]) / _state[wrapWidth], _state.moveDirection);
      _state[x0] = x;
      emit('scroll', {
        scrollLeft: _state.left,
        scrollTop: _state.top,
      });
    }

    // 鼠标松开
    function mouseUp(e) {
      document.removeEventListener('mousemove', mouseMove);
      document.removeEventListener('mouseup', mouseUp);
      document.onselectstart = null;
    }

    onMounted(() => {
      nextTick(() => {
        updateSize();
        if (props.x < 0) {
          _state.left = _state.maxLeft;
        }
        if (props.y < 0) {
          _state.top = _state.maxTop;
        }
      });
      addResizeListener(scrollDom.value, resizeDom());
      addResizeListener(scrollViewDom.value, resizeDom());
    });

    onBeforeUnmount(() => {
      removeResizeListener(scrollDom.value, resizeDom());
      removeResizeListener(scrollViewDom.value, resizeDom());
    });

    return {
      ...toRefs(state),
      scrollDom,
      scrollBoxDom,
      scrollViewDom,
      handleScroll,
      clickTrack,
      dragThumb,
    };
  },
};
</script>

<style lang="less">
:root {
  --width-scroll: 15px;
}

.v-scroll {
  --width-track: 6px;

  position: relative;
  width: 100%;
  height: 100%;
  overflow: hidden;
  &:hover {
    > .v-scroll-track > .v-scroll-thumb {
      opacity: 0.5;
    }
  }
  .v-scroll-box {
    overflow: scroll;
  }
  .v-scroll-track {
    position: absolute;
    z-index: 2;
    &:hover > .v-scroll-thumb {
      opacity: 0.9;
    }
  }
  .v-scroll-track-y {
    top: 0;
    right: 0;
    width: var(--width-track);
    height: 100%;
    padding: 0 1px;
  }
  .v-scroll-track-x {
    bottom: 0;
    left: 0;
    width: 100%;
    height: var(--width-track);
    padding: 0 1px;
  }
  .v-scroll-thumb {
    position: absolute;
    top: 0;
    left: 0;
    height: 100%;
    width: 100%;
    border-radius: calc(var(--width-track) / 2);
    background: #888;
    opacity: 0;
    transform-origin: center top;
    transition: opacity 0.4s;
  }
}
</style>
