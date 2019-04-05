<template>
  <div>
    <div v-if="!isLogged">
      <div class="video-background">
        <div class="video-foreground">
          <iframe src="https://www.youtube.com/embed/2hXmm0nsGN0?controls=0&showinfo=0&rel=0&autoplay=1&mute=1&loop=1&playlist=qghQ5eKGcyE" frameborder="0" allowfullscreen>
          </iframe>
        </div>
      </div>

      <div class="empty-div">
      </div>
      <md-card md-with-hover class="login-card unselectable">
        <md-card-header>
          <md-card-header-text>
            <div class="md-title">SolarChain</div>
            <br>
            <br>
            <div class="md-subhead" v-if="!loginWarn">Please select an account to begain</div>
            <div class="md-subhead" v-if="loginWarn">
              <strong style="color:#f44336;">Please select an account to begain!!!</strong>
            </div>
          </md-card-header-text>
          <md-card-media md-medium>
            <img class="unselectable rotate-image" src="./assets/img/sun.png" alt="icon">
          </md-card-media>
        </md-card-header>

        <md-card-content>
          <br>
          <div class="md-layout-item md-size-100">
            <strong style="color:#fff176;">Prosumers</strong>
          </div>

          <md-radio v-model="role" value="p1">
            <md-avatar class="role-icon">
              <img :src="getImgUrl('p1')" alt="P">
            </md-avatar>
            {{p1.name}}
          </md-radio>
          <md-radio v-model="role" value="p2">
            <md-avatar class="role-icon">
              <img :src="getImgUrl('p2')" alt="P">
            </md-avatar>
            {{p2.name}}
          </md-radio>

          <div class="md-layout-item md-size-100">
            <strong style="color:#fff176;">Consumer</strong>
          </div>

          <md-radio v-model="role" value="c1">
            <md-avatar class="role-icon">
              <img :src="getImgUrl('c1')" alt="P">
            </md-avatar>
            {{c1.name}}
          </md-radio>

          <div class="md-layout-item md-size-100">
            <strong style="color:#fff176;">Utility Representative</strong>
          </div>

          <md-radio v-model="role" value="u1">
            <md-avatar class="role-icon">
              <img :src="getImgUrl('u1')" alt="P">
            </md-avatar>
            {{u1.name}}
          </md-radio>
        </md-card-content>
        <md-card-actions>
          <router-link to="home">
            <md-button @click="login()">Login</md-button>
          </router-link>
        </md-card-actions>
      </md-card>
      <div class="empty-div">
      </div>
    </div>

    <div v-if="isLogged" class="page-container unselectable">
      <md-app>
        <md-app-toolbar class="md-primary">
          <md-button class="md-icon-button" @click="menuVisible = true" v-if="!menuVisible">
            <md-icon>menu</md-icon>
          </md-button>
          <router-link to="home">
            <span class="md-title unselectable car" @click="menuVisible = false">
              <md-icon v-if="menuVisible" class="rotate-image">wb_sunny</md-icon>
                SolarChain
              </span>
            </router-link>
        </md-app-toolbar>

        <md-app-drawer :md-active.sync="menuVisible" md-persistent="full" >

          <md-dialog class="wallet" :md-click-outside-to-close=false :md-active.sync="isInfo">
            <md-toolbar class="md-accent md-dense">
              <h3 class="md-title" style="flex: 1">My Information</h3>
                <md-button class="md-icon-button"  @click="isInfo = false">
                  <md-icon>close</md-icon>
                </md-button>
            </md-toolbar>

            <div class="wallet-content">
              <div class="md-subheading">
                Name: {{currentUser.name}}
              </div>
              <div class="md-subheading">
                Role: {{currentUser.title}}
              </div>
              <br>

              <div class="md-layout-item md-size-90">
                <md-field>
                  <label>ID (Account Address)</label>
                  <md-textarea md-autogrow v-model="accountAddress" readonly></md-textarea>
                </md-field>
              </div>

              <div v-if="isRevealed">
                <div class="md-layout-item md-size-90">
                  <md-field>
                    <label>Private Key</label>
                    <md-textarea md-autogrow v-model="accountPk" readonly></md-textarea>
                  </md-field>
                </div>
                <div class="md-layout-item md-size-90">
                  <md-field>
                    <label>Seed</label>
                    <md-textarea md-autogrow v-model="accountSeed" readonly></md-textarea>
                  </md-field>
                </div>
              </div>

              <md-dialog-actions v-if="!isRevealed" class="md-layout md-alignment-center-right">
                <md-button class="md-accent md-raised" @click="isRevealed = true">Details</md-button>
              </md-dialog-actions>
            </div>
          </md-dialog>

          <md-toolbar class="md-transparent" md-elevation="0">

            <md-menu md-align-trigger md-size="small">
              <md-button class="md-icon-button nav-role md-fab md-plain" md-menu-trigger>
                <md-avatar class="md-avatar-icon md-large">
                  <md-ripple>
                    <img :src="getImgUrl()" alt="P">
                  </md-ripple>
                </md-avatar>
              </md-button>

              <md-menu-content>
                <md-menu-item  @click="showInfo()">
                  <md-icon>account_box</md-icon>
                  <span>My Info</span>
                </md-menu-item>

                <md-menu-item @click="logout()">
                  <md-icon>exit_to_app</md-icon>
                  <span>Logout</span>
                </md-menu-item>

              </md-menu-content>
            </md-menu>

            <strong class="nav-name">
              Hi, {{currentUser.name}}
            </strong>

            <div class="md-toolbar-section-end">
              <md-button class="md-icon-button md-dense close-nav" @click="menuVisible = false">
                <md-icon>keyboard_arrow_left</md-icon>
              </md-button>
            </div>
          </md-toolbar>

          <md-list>
            <br>
            <router-link to="MyPanel">
              <md-list-item @click="menuVisible = false">
                <md-icon>dashboard</md-icon>
                <span class="md-list-item-text">My Panel</span>
              </md-list-item>
            </router-link>
            <md-divider></md-divider>
            <md-list-item href="https://app.simbachain.com/" target="_blank" @click="menuVisible = false">
              <md-icon>apps</md-icon>
              <span class="md-list-item-text">SIMBA&#8482; Dashboard</span>
            </md-list-item>

            <md-list>
              <md-list-item md-expand>
                <md-icon>whatshot</md-icon>
                <span class="md-list-item-text">Other Demos</span>
                <md-list slot="md-expand">
                  <md-list-item href="https://cardemo.simbachain.com" target="_blank" @click="menuVisible = false" class="md-inset">Car Demo</md-list-item>
                  <md-list-item href="https://herodemo.simbachain.com" target="_blank" @click="menuVisible = false" class="md-inset">Hero Demo</md-list-item>
                  <md-list-item href="https://container.simbachain.com" target="_blank" @click="menuVisible = false" class="md-inset">Container Demo</md-list-item>
                </md-list>
              </md-list-item>
            </md-list>

            <md-list-item href="https://github.com/SIMBAChain" target="_blank" @click="menuVisible = false">
              <md-icon>code</md-icon>
              <span class="md-list-item-text">Git Repo</span>
            </md-list-item>

            <md-list-item href="https://simbachain.com/contact/" target="_blank" @click="menuVisible = false">
              <md-icon>contact_support</md-icon>
              <span class="md-list-item-text">Contact Us</span>
            </md-list-item>

          </md-list>

          <div class="md-layout love">
            <div>Made with</div>
            <div class="zoom"> &hearts; </div>
            <div>in South Bend</div>
          </div>
        </md-app-drawer>

        <md-app-content class="bg-color">
          <router-view class="conent">
          </router-view>
        </md-app-content>
      </md-app>

    </div>
  </div>
</template>

<style lang="scss" scoped>
  .bg-color {
    background-color: black;
  }
  .rotate-image {
    -webkit-animation:spin 4s linear infinite;
    -moz-animation:spin 4s linear infinite;
    animation:spin 4s linear infinite;
  }
  @-moz-keyframes spin { 100% { -moz-transform: rotate(360deg); } }
  @-webkit-keyframes spin { 100% { -webkit-transform: rotate(360deg); } }
  @keyframes spin { 100% { -webkit-transform: rotate(360deg); transform:rotate(360deg); } }

  .login-card {
    max-width: 300px;
    margin: 0 auto;
  }
  .empty-div {
    height: 100px;
  }
  .role-icon {
    margin-top: -10px;
    margin-left: -10px;
    margin-right: 5px;
  }
  .nav-role {
    margin-top: 10px;
  }
  .nav-name {
    margin-left: 15px;
    margin-top: 50px;
  }
  .close-nav {
    margin-top: -10px;
  }
  .title {
    margin-left: 18px;
  }
  .zoom {
    color: #e25555;
    transition: transform .2s;
    margin-left:2px;
    margin-right:2px;
  }
  .zoom:hover {
    transform: scale(1.3);
  }
  .love {
    position: fixed;
    bottom: 20px;
    margin-left: 20px;
  }
  .avatar {
    margin-top:20px;
    margin-left:-60px;
  }
  .tool-bar {
    z-index: 100;
  }
  .md-app {
    height: 100vh;
  }
  .unselectable {
    user-drag: none;
    user-select: none;
    -moz-user-select: none;
    -webkit-user-drag: none;
    -webkit-user-select: none;
    -ms-user-select: none;
  }
  .md-drawer {
    width: 230px;
    max-width: calc(100vw - 125px);
  }
  .video-background {
    background: #000;
    position: fixed;
    top: 0; right: 0; bottom: 0; left: 0;
    z-index: 1;
  }
  .video-foreground,
  .video-background iframe {
    position: absolute;
    margin-top: -30px;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    min-width: 2000px;
    min-height: 1125px;
    pointer-events: none;
  }

  @media all and (max-width: 600px) {
  .vid-info { width: 50%; padding: .5rem; }
  .vid-info h1 { margin-bottom: .2rem; }
  }
  @media all and (max-width: 500px) {
  .vid-info .acronym { display: none; }
  }
  .wallet {
    min-width: 320px;
  }
  .wallet-content {
    margin: 20px;
  }

</style>

<script>
import { localstorage } from './components/mixins/localstorage'
import ethers from 'ethers'

export default {
  name: 'App',
  mixins: [localstorage],
  data: () => ({
    isLogged: false,
    role: null,
    loginWarn: null,
    menuVisible: false,

    accountAddress: null,
    accountPk: null,
    accountSeed: null,

    isRevealed: false,
    isInfo: false,

    currentUser: {
      name: null,
      title: null,
      code: null,
      key: null,
      imgSrc: null
    },

    p1: {
      name: 'Peter',
      title: 'Prosumer',
      code: 'p1',
      key: 'impose state body frost drink cancel vacant annual vague green museum plug',
      imgSrc: './assets/img/p1.png'},
    p2: {
      name: 'Parker',
      title: 'Prosumer',
      code: 'p2',
      key: 'figure upset scare vicious horn among now wrap dad nominee plastic lunar',
      imgSrc: './assets/img/p2.png'},
    c1: {
      name: 'Chole',
      title: 'Consumer',
      code: 'c1',
      key: 'pave twice fault junior clap actress update salt dance home ugly drift',
      imgSrc: './assets/img/c1.png'},
    u1: {
      name: 'Ulla',
      title: 'Utility Representative',
      code: 'u1',
      key: 'winner liquid live height sentence mammal almost dirt seed beyond picnic adapt',
      imgSrc: './assets/img/u1.png'}
  }),
  methods: {
    login () {
      if (this.role == null) {
        this.loginWarn = true
        return
      }
      let role = this.role
      this.checkUser(role)
    },
    getImgUrl (role) {
      if (role == null) {
        return require(`${this.currentUser.imgSrc}`)
      }
      return require(`${this[role].imgSrc}`)
    },
    checkUser (role) {
      this.isLogged = true
      this.currentUser.name = this[role].name
      this.currentUser.title = this[role].title
      this.currentUser.code = this[role].code
      this.currentUser.key = this[role].key
      this.currentUser.imgSrc = this[role].imgSrc
      this.setUser(this.currentUser)
    },
    logout () {
      this.menuVisible = false
      this.isLogged = false
      this.role = null
      this.currentUser.name = null
      this.currentUser.title = null
      this.currentUser.code = null
      this.currentUser.key = null
      this.currentUser.imgSrc = null
      this.clean()
    },
    showInfo () {
      this.isRevealed = false
      this.menuVisible = false
      this.isInfo = true
      this.setInfo()
    },
    setInfo () {
      let mnemonic = this.getUser().key
      let wallet = ethers.Wallet.fromMnemonic(mnemonic)
      this.accountAddress = wallet.address
      this.accountPk = wallet.privateKey
      this.accountSeed = mnemonic
    }
  },
  mounted () {
    if (!localStorage.getItem('currentUser')) {
      this.isLogged = false
      return
    }
    this.role = this.getUser().code
    this.checkUser(this.role)
  }
}
</script>
