<template>
  <div class="v-tabs">
    <div class="tabs-exclusive" v-if="!!exclusive">
      {{ exclusive }}
    </div>
    <div class="tabs">
      <label class="tab" v-for="(item, index) of list" :key="index">
        <input type="radio" name="cheat" :value="index" v-model="active" />
        <slot name="tab" :tab="item">
          <span>{{ item.name }}</span>
        </slot>
      </label>
    </div>
    <h5 class="tabs-content-title">
      <slot name="title" :info="info">
        <span>{{ info.name }}</span>
      </slot>
    </h5>
    <slot :info="info"></slot>
  </div>
</template>

<script setup>
import {computed, ref, watch} from 'vue';

const props = defineProps({
  list: {
    type: Array,
  },
  exclusive: {
    type: String,
  },
});
const active = ref(0);
const info = computed(() => props.list[active.value]);
watch(
  () => props.list,
  () => {
    active.value = 0;
  },
  {immediate: true}
);
</script>

<style lang="less">
.v-tabs {
  .tabs-exclusive {
    padding: 10px 0;
    color: var(--color-content);
  }

  .tabs {
    position: relative;
    display: flex;
    flex-wrap: wrap;
    margin-bottom: 10px;
    background: var(--color-bg);
  }

  .tab {
    width: 100px;
    height: 25px;
    cursor: pointer;

    input[type='radio'] {
      display: none;

      &:checked ~ span {
        background: var(--color-success-lighter);
      }
    }

    span {
      display: block;
      width: 100%;
      height: 100%;
      line-height: 24px;
      text-align: center;

      &:hover {
        background: var(--color-bg-hover);
      }
    }
  }

  .tabs-content-title {
    padding: 10px;
    font-weight: normal;

    span {
      display: inline-block;
      padding: 2px 10px;
      font-size: 18px;
    }
  }

  .tabs-content-subtitle {
    padding: 0 20px 10px;
    color: var(--color-info);
  }
}
</style>
