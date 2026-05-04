<template>
  <v-kungfu :list="kungfu.list" :exclusive="kungfu.exclusive">
    <template #tab="{tab}">
      <span
        :class="{
          [`level-${tab.level}`]: tab.level,
          [`internal-${tab.internal}`]: tab.internal === 0 || tab.internal === 1,
        }"
      >
        {{ tab.name }}
      </span>
    </template>
    <template #title="{info}">
      <span
        :class="[
          `level-${info.level}`,
          {[`internal-${info.internal}`]: info.internal === 0 || info.internal === 1},
        ]"
      >
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
          <div class="td">
            <div
              class="is-block td-effect-item effect-icon-rhombus"
              v-for="(item, index) of info.get"
              :key="index"
            >
              {{ item }}
            </div>
          </div>
        </div>
        <div class="tr">
          <div class="td">所属门派</div>
          <div class="td">
            {{ kungfuSectMap[info.sect] ?? '' }}
          </div>
        </div>
        <div class="tr">
          <div class="td">修炼条件</div>
          <div class="td">
            <span>{{ info.condition }}</span>
          </div>
        </div>
        <div class="tr">
          <div class="td">每级加成</div>
          <div class="td">
            <span>{{ info.addition }}</span>
          </div>
        </div>
        <div class="tr">
          <div class="td">威力</div>
          <div class="td">{{ info.power }}</div>
        </div>
        <div class="tr" v-if="kungfuType === 'in' || kungfuType === 'fly'">
          <div class="td">主运效果</div>
          <div class="td">
            <div class="td-block" v-for="item of info.initiative" :key="item.id">
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
        <template v-if="kungfuType === 'out'">
          <div class="tr">
            <div class="td">气功</div>
            <div class="td">{{ info.power }}</div>
          </div>
          <div class="tr">
            <div class="td">招式效果</div>
            <div class="td">
              <template v-for="item of info.attack" :key="item.id">
                <div class="is-block td-effect-item" v-for="(text, i) of item.effect" :key="i">
                  {{ text }}
                </div>
              </template>
            </div>
          </div>
          <div class="tr">
            <div class="td">奥义效果</div>
            <div class="td">
              <div class="td-block" v-for="item of info.ultimate" :key="item.id">
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
        </template>
        <div class="tr" v-if="kungfuType !== 'fly'">
          <div class="td">范围</div>
          <div class="td">{{ info.range }}</div>
        </div>
        <div class="tr">
          <div class="td">一脉相承</div>
          <div class="td">
            <div class="td-block" v-for="item of info.inherit" :key="item.id">
              {{ item.name }}
            </div>
          </div>
        </div>
        <div class="tr">
          <div class="td">其他</div>
          <div class="td">
            <div class="td-block" v-for="item of info.peculiar" :key="item.id">
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
  </v-kungfu>
</template>

<script setup>
import {ref, watchEffect} from 'vue';
import {useRoute} from 'vue-router';
import fist from '@/data/kungfu/fist';
import finger from '@/data/kungfu/finger';
import sword from '@/data/kungfu/sword';
import knife from '@/data/kungfu/knife';
import special from '@/data/kungfu/special';
import internal from '@/data/kungfu/internal';
import fly from '@/data/kungfu/fly';
import {kungfuSectMap} from '@/data/map/index';
import VKungfu from '@/components/kungfu';

const route = useRoute();
const all = {fist, finger, sword, knife, special, internal, fly};
const kungfuTypeMap = {
  fist: 'out',
  finger: 'out',
  sword: 'out',
  knife: 'out',
  special: 'out',
  internal: 'in',
  fly: 'fly',
};
const kungfu = ref({});
const kungfuType = ref('in');
watchEffect(() => {
  kungfu.value = {list: []};
  const {type} = route.meta;
  kungfuType.value = kungfuTypeMap[type];
  kungfu.value = all[type] ? all[type] : {list: []};
});
</script>
