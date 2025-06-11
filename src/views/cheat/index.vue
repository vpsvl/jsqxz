<template>
  <v-tabs :list="cheat.list" :exclusive="cheat.exclusive">
    <template #tab="{tab}">
      <span
        :class="{[`level-${tab.level}`]: tab.level, [`internal-${tab.internal}`]: tab.internal}"
      >
        {{ tab.name }}
      </span>
    </template>
    <template #title="{info}">
      <span :class="[`level-${info.level}`, {[`internal-${info.internal}`]: info.internal}]">
        {{ info.name }}
      </span>
    </template>
    <template #default="{info}">
      <div class="v-table v-table-vertical">
        <div class="tr">
          <div class="td">秘籍</div>
          <div class="td">
            <span :class="`level-icon level-icon-${info.level}`"></span>
            <span>{{ info.cheat ? info.cheat : info.name }}</span>
          </div>
        </div>
        <div class="tr">
          <div class="td">获取方式</div>
          <div class="td">{{ info.get }}</div>
        </div>
        <div class="tr">
          <div class="td">修炼条件</div>
          <div class="td">
            <span>{{ info.condition }}</span>
            <span v-if="info.internal === '0'">&nbsp;非阳内</span>
            <span v-if="info.internal === '1'">&nbsp;非阴内</span>
          </div>
        </div>
        <div class="tr">
          <div class="td">每级加成</div>
          <div class="td">
            <span>{{ info.addition }}</span>
            <span v-if="info.internal === '2'">&nbsp;调和内力属性</span>
          </div>
        </div>
        <div class="tr">
          <div class="td">威力</div>
          <div class="td">{{ info.power }}</div>
        </div>
        <div class="tr" v-if="cheatType === 'in'">
          <div class="td">主运效果</div>
          <div class="td">
            <div class="td-block" v-for="(item, index) of info.initiative" :key="index">
              <div v-if="item.name">
                [
                <span :class="`level-${info.level}`">{{ item.name }}</span>
                ]:
              </div>
              <div class="td-effect-item" v-for="(text, i) of item.effect" :key="i">
                {{ text }}
              </div>
            </div>
          </div>
        </div>
        <template v-if="cheatType === 'out'">
          <div class="tr">
            <div class="td">气功</div>
            <div class="td">{{ info.gasPower }}</div>
          </div>
          <div class="tr">
            <div class="td">范围</div>
            <div class="td">{{ info.range }}</div>
          </div>
        </template>
        <div class="tr">
          <div class="td">其他</div>
          <div class="td">
            <div class="td-block" v-for="(item, index) of info.peculiar" :key="index">
              <div v-if="item.name">
                [
                <span class="color-error">{{ item.name }}</span>
                ]:
                <span class="color-success">{{ item.condition }}</span>
              </div>
              <div class="td-effect-item" v-for="(text, i) of item.effect" :key="i">
                {{ text }}
              </div>
            </div>
          </div>
        </div>
      </div>
    </template>
  </v-tabs>
</template>

<script setup>
import {ref, watchEffect} from 'vue';
import {useRoute} from 'vue-router';
import fist from '@/data/cheat/fist';
import finger from '@/data/cheat/finger';
import sword from '@/data/cheat/sword';
import knife from '@/data/cheat/knife';
import special from '@/data/cheat/special';
import internal from '@/data/cheat/internal';
import fly from '@/data/cheat/fly';

const route = useRoute();
const all = {fist, finger, sword, knife, special, internal, fly};
const cheatTypeMap = {
  fist: 'out',
  finger: 'out',
  sword: 'out',
  knife: 'out',
  special: 'out',
  internal: 'in',
  fly: 'in',
};
const cheat = ref({});
const cheatType = ref('in');
watchEffect(() => {
  cheat.value = {list: []};
  const {type} = route.meta;
  cheatType.value = cheatTypeMap[type];
  const data = all[type] ? all[type] : {list: []};
  cheat.value = data;
});
</script>
