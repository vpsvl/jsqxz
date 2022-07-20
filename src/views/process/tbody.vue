<template>
  <template v-for="(item, index) of tbody" :key="index">
    <div class="tr tr-map">
      <div class="td">{{ numToZh(index + 1) }}</div>
      <div class="td">{{ item.map }}</div>
    </div>
    <div class="tr" v-for="(eventList, eventIndex) of item.event" :key="eventIndex">
      <div class="td">{{ eventIndex + 1 }}</div>
      <div class="td">
        <p class="td-block" v-for="(eventItem, eventItemIndex) of eventList.list" :key="eventItemIndex">
          {{ eventItem }}
        </p>
      </div>
      <div class="td">
        <p class="td-block" v-for="(eventItem, eventItemIndex) of eventList.reward" :key="eventItemIndex">
          {{ eventItem }}
        </p>
      </div>
    </div>
  </template>
</template>

<script setup>
const props = defineProps({
  tbody: {
    type: Array,
    default() {
      return [];
    },
  },
});
// 1-99转中文
function numToZh(num) {
  if (typeof num !== 'number' || num >= 100 || num < 1) {
    return '';
  }
  const map = {
    0: '',
    1: '一',
    2: '二',
    3: '三',
    4: '四',
    5: '五',
    6: '六',
    7: '七',
    8: '八',
    9: '九',
  };
  const bit = num % 10;
  const bitZh = map[bit];
  const ten = parseInt(num / 10);
  let tenZh = '';
  if (ten === 1) {
    tenZh = '十';
  } else if (ten > 1) {
    tenZh = `${map[ten]}十`;
  }
  return tenZh + bitZh;
}
</script>
