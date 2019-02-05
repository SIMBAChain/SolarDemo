<template>
  <div>
    <md-card class="md-alignment-center-center my-card" md-with-hover>
      <md-card-header>
        <div class="md-title">Hey, {{getUser().name}}</div>
        <div class="md-subhead">
          You have logged in as:
          <br>
          <strong style="color:#64dd17;">{{getUser().title}}</strong>
        </div>
      </md-card-header>

      <md-card-content>

        <div v-if="getUser().title == 'Prosumer'">
          <small class="md-caption">
            Prosumer installs solar panels to consume the energy generated and sell the rest of it back to utilities.
          </small>
          <br>
          <strong>
            You can:
          </strong>
          <br>
          <small class="margin-txt">
            1. Sell out surplus energy to grid
          </small>
          <br>
          <small class="margin-txt">
            2. Buy in electricity from grid
          </small>
          <br>
          <small class="margin-txt">
            3. Check out all transactions
          </small>
        </div>

        <div v-if="getUser().title == 'Consumer'">
          <small class="md-caption">
            Consumer buys and consumes the energy generated.
          </small>
          <br>
          <strong>
            You can:
          </strong>
          <br>
          <small class="margin-txt">
            1. Buy in electricity from grid
          </small>
          <br>
          <small class="margin-txt">
            2. Check out all transactions
          </small>
          <br>
          <br>
        </div>

        <div v-if="getUser().title == 'Utility Representative'">
          <small class="md-caption">
            Utility Representative monitors all transactions made by consumers and prosumers.
          </small>
          <br>
          <strong>
            You can:
          </strong>
          <br>
          <small class="margin-txt">
            1. Check out all transactions
          </small>
          <br>
          <br>
          <br>
        </div>

      </md-card-content>

      <md-card-actions>
        <router-link to="MyPanel">
          <md-button class="md-accent">
            <md-icon>dashboard</md-icon> my Panel
          </md-button>
        </router-link>
      </md-card-actions>
    </md-card>
  </div>
</template>

<script>
import { localstorage } from './mixins/localstorage'

export default {
  name: 'Home',
  mixins: [localstorage]
}
</script>

<style lang="scss" scoped>
  .my-card {
    margin-top: 40px;
    width: 250px;
    display: inline-block;
    vertical-align: top;
    margin-bottom: 20px;
  }
  .margin-txt {
    margin-left: 10px;
  }
</style>
