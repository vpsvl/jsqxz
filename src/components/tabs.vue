<template>
  <div class="v-tabs">
    <div class="tabs-exclusive" v-if="!!exclusive">
      {{ exclusive }}
    </div>
    <div class="tabs" :class="{'is-sticky': sticky}">
      <label
        class="tab"
        v-for="(item, index) of list"
        :key="keyName && item[keyName] ? item[keyName] : index"
      >
        <input
          type="radio"
          name="tab"
          :value="keyName && item[keyName] ? item[keyName] : index"
          v-model="active"
        />
        <slot name="tab" :tab="item">
          <span>{{ item.name }}</span>
        </slot>
      </label>
    </div>
    <h5 class="tabs-content-title" v-if="info.name">
      <slot name="title" :info="info">
        <span>{{ info.name }}</span>
      </slot>
    </h5>
    <slot :info="info"></slot>
  </div>
</template>

<script setup>
import {computed} from 'vue';

const props = defineProps({
  list: {
    type: Array,
    default: () => [],
  },
  exclusive: {
    type: String,
  },
  keyName: {
    type: String,
    default: '',
  },
  sticky: {
    type: Boolean,
    default: false,
  },
});

const active = defineModel({default: 0, type: Number});
const info = computed(() => {
  if (props.keyName) {
    const item = props.list.find(i => i[props.keyName] === active.value);
    return item ? item : {};
  }
  return {...props.list[active.value]};
});
</script>
