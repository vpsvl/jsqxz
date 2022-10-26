<template>
  <v-scroll class="home-wrap">
    <h4 class="home-title">金书群侠传1.07简易攻略</h4>
    <div class="home-img">
      <div class="img-box">
        <img src="../../assets/images/home-bg.png" alt=""/>
      </div>
      <div class="img-box">
        <img src="../../assets/images/home-text.png" alt=""/>
      </div>
    </div>
  </v-scroll>
</template>

<script></script>

<style lang="less">
.home-wrap {
  background: #fff;

  .home-title {
    padding: 30px 0 10px;
    text-align: center;
    font-size: 20px;
  }

  .home-img {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px;
  }

  .img-box {
    flex: 0 0 1;

    img {
      width: 100%;
    }
  }
}
</style>
