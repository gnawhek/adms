<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { computed, ref } from 'vue'
import { ViewPages } from 'src/types'
import { usePopupStore } from 'src/store/popup'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const popupStore = usePopupStore()
const props = defineProps({
  viewTitle: {
      type: String
    }
  })

const openPopUp = (name: string) => {
  popupStore.newPopup(ViewPages[name])
}
</script>

<template>
   <div class="HealthManagement column q-pa-lg">
      <div class="col-2 row q-py-md justify-between">
        <div class="text-h6">{{ viewTitle === 'walking' ? '걷기' : '주간 습관 리포트' }}</div>
         <div class="q-mr-sm"> 
           <q-btn
            flat
            :label="viewTitle === 'walking' ? '더 보기' : '전체보기'"  
            style="font-size:1rem;" 
            color="v-gray4" 
            class="q-pa-none" 
            @click="openPopUp(viewTitle === 'walking' ? '' : 'HabitWeekReport')">
              <q-icon size="19px">
               <img src="~assets/images/habit/ic_arrow_r_ss.svg" />
              </q-icon>
           </q-btn>
         </div>
      </div>
      <div class="col text-center"  id="fmo-chart-container">
         <svg width="90%" height="400" viewBox="0 0 235 208" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path 
               d="M67.6463 312.567 A 95 95 0 1 1 182.846 312.567"
               transform="translate(-7.5,-119)"
               stroke-dasharray="1, 6"
               stroke-width="2"
               stroke="#6257FF"
               fill="none"/>
           <text x="80" y="140" fill="#6257FF" font-size="30" font-family="Barlow" font-weight="bold">
            5,532
           </text>
           <text x="87" y="165" fill="#b3b3b3" font-size="11" font-family="NanumSquare" font-weight="bold">
            목표 10,000
           </text>
           <path class="fmo-gauge__bg" d="M45.6463 202C21.4012 181.627 6 151.137 6 117.062C6 55.7242 55.9065 6 117.469 6C179.032 6 228.938 55.7242 228.938 117.062C228.938 151.137 213.537 181.627 189.292 202" stroke="#DDDDDD" stroke-width="12" stroke-linecap="round"/>
           <path class="fmo-gauge__fill" d="M45.6463 202C21.4012 181.627 6 151.137 6 117.062C6 55.7242 55.9065 6 117.469 6C179.032 6 228.938 55.7242 228.938 117.062C228.938 151.137 213.537 181.627 189.292 202" stroke="#6257FF" stroke-width="12" stroke-linecap="round"/>
           <g clip-path="url(#clip0_207_1680)" transform="translate(107,79)">
            <path d="M14.234 10.6375L13.3057 12.634C15.4132 13.0458 17.345 14.0889 18.8434 15.6241C20.3418 17.1593 21.3356 19.1138 21.6926 21.2271C21.7113 21.6708 21.561 22.105 21.2718 22.4426C20.9827 22.7802 20.5762 22.9959 20.1341 23.0465C19.692 23.0971 19.2471 22.9788 18.8889 22.7153C18.5307 22.4518 18.2858 22.0628 18.2034 21.6264C17.8736 20.164 17.1007 18.8384 15.9896 17.8296C14.8786 16.8209 13.4832 16.178 11.9932 15.9882C10.9893 17.6541 9.55442 19.0196 7.83934 19.9414C6.12426 20.8632 4.19215 21.3073 2.24579 21.2271C1.9994 21.2505 1.75088 21.2223 1.51605 21.1442C1.28122 21.0662 1.06526 20.94 0.882136 20.7739C0.69901 20.6077 0.552711 20.4052 0.452592 20.1793C0.352472 19.9534 0.300781 19.7091 0.300781 19.4621C0.300781 19.2151 0.352472 18.9709 0.452592 18.745C0.552711 18.5191 0.69901 18.3166 0.882136 18.1504C1.06526 17.9842 1.28122 17.8581 1.51605 17.7801C1.75088 17.702 1.9994 17.6738 2.24579 17.6972C7.17551 17.6972 8.64806 15.1896 10.5847 10.6375C8.02384 10.7333 6.85544 12.059 5.28689 13.6403C4.94609 13.9771 4.48611 14.1664 4.00646 14.1673C3.53952 14.1673 3.09168 13.9823 2.7615 13.6528C2.43132 13.3233 2.24579 12.8764 2.24579 12.4104C2.24671 11.9317 2.43649 11.4727 2.774 11.1326C3.73737 9.92463 4.95163 8.93928 6.33315 8.24444C7.71468 7.5496 9.23067 7.1618 10.7768 7.10765H14.346C15.5979 7.11172 16.8193 6.72184 17.8365 5.99352C18.8536 5.26521 19.6149 4.23549 20.012 3.05069C20.0866 2.8315 20.2038 2.62911 20.3568 2.4551C20.5098 2.28109 20.6956 2.13888 20.9036 2.03654C21.1117 1.9342 21.338 1.87376 21.5695 1.85867C21.801 1.84359 22.0331 1.87414 22.2528 1.9486C22.4724 2.02307 22.6753 2.13996 22.8496 2.29264C23.024 2.44531 23.1665 2.63077 23.269 2.83841C23.3716 3.04606 23.4322 3.27184 23.4473 3.50284C23.4624 3.73383 23.4318 3.96552 23.3571 4.18471C22.7119 6.05538 21.4959 7.67748 19.8798 8.82332C18.2636 9.96916 16.3285 10.5812 14.346 10.5736L14.234 10.6375Z" fill="#6257FF"/>
            <path d="M13.738 5.30278C15.2054 5.30278 16.3949 4.11571 16.3949 2.65139C16.3949 1.18707 15.2054 0 13.738 0C12.2706 0 11.0811 1.18707 11.0811 2.65139C11.0811 4.11571 12.2706 5.30278 13.738 5.30278Z" fill="#6257FF"/>
           </g>
           <defs>
            <clipPath id="clip0_207_1680">
            <rect width="23" height="23" fill="white" transform="translate(0.469238)"/>
            </clipPath>
           </defs>
           <g filter="url(#filter0_d_207_1685)" transform="translate(180,23)">
            <circle cx="9.46924" cy="9" r="9" fill="white"/>
           </g>
           <g filter="url(#filter1_i_207_1685)" transform="translate(180,23)">
            <circle cx="9.46929" cy="9" r="4.2" fill="#CCCCCC"/>
           </g>
            <defs>
             <filter id="filter0_d_207_1685" x="0.469238" y="0" width="20" height="20" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
              <feFlood flood-opacity="0" result="BackgroundImageFix"/>
              <feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
              <feOffset dx="1" dy="1"/>
              <feGaussianBlur stdDeviation="0.5"/>
              <feComposite in2="hardAlpha" operator="out"/>
              <feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.15 0"/>
              <feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_207_1685"/>
              <feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_207_1685" result="shape"/>
             </filter>
             <filter id="filter1_i_207_1685" x="5.26929" y="4.8" width="9.3999" height="9.4" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
              <feFlood flood-opacity="0" result="BackgroundImageFix"/>
              <feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
              <feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
              <feOffset dx="1" dy="1"/>
              <feGaussianBlur stdDeviation="0.5"/>
              <feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
              <feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
              <feBlend mode="normal" in2="shape" result="effect1_innerShadow_207_1685"/>
             </filter>
            </defs>
         </svg>
      </div>
      <div class="col-2 q-pt-lg">
        <q-card :flat="viewTitle !== 'walking'" class="shadow-3">
          <q-card-section >
           <div class="text-h6 q-py-sm">
            <q-icon size="sm">
             <svg width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
              <circle cx="5" cy="5" r="5" fill="#6257FF"/>
             </svg>
            </q-icon>
              현재 걸음수
              <div style="float: right;">
               <span>5,532 걸음</span>
               <span class="text-v-gray3">/10,000</span>
              </div>
           </div>
           <div class="text-h6 q-pb-sm">
              <q-icon size="sm">
             <svg width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
              <circle cx="5" cy="5" r="5" fill="#CCCCCC"/>
             </svg>
            </q-icon>
            30대 평균
            <div style="float: right;">
               <span class="text-v-gray3">7,500 걸음</span>
              </div>
           </div>
          </q-card-section>
       </q-card>
      </div>
   </div>
</template>

<style lang="sass" scoped>
.HealthManagement
   min-height: inherit

   .q-card
      box-shadow: 1px 1px 4px 0 rgba(0, 0, 0, 0.2)

#fmo-chart-container 
   transform-origin: 150px 150px

.fmo-gauge__bg
  stroke-dasharray: 0
  stroke-dashoffset: 0
  transform: rotate(0deg)

.fmo-gauge__fill
  stroke-dasharray: 553.2
  stroke-dashoffset: 241
  transform: rotate(0deg)
  animation: fmo-gauge-fill-animation 2s cubic-bezier(0.785, 0.135, 0.15, 0.86) forwards 0.5s

@keyframes fmo-gauge-fill-animation
   0%
      stroke-dashoffset: 550

</style>
