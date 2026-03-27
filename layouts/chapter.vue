<template>
  <div class="slidev-layout chapter-layout">
    <div
      class="chapter-layout__bg"
      :style="{ backgroundImage: `url(${$attrs.image || ''})` }"
    />
    <div class="chapter-layout__right">
      <div class="chapter-layout__text">
        <div class="chapter-layout__separator" />
        <h1 class="chapter-layout__title">{{ $attrs.chapter }}</h1>
        <p class="chapter-layout__subtitle" v-if="$attrs.section">{{ $attrs.section }}</p>
        <div class="chapter-layout__slot">
          <slot />
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.chapter-layout {
  position: relative;
  height: 100%;
  width: 100%;
}

.chapter-layout__bg {
  position: absolute;
  inset: 0;
  background-size: cover;
  background-position: center;
}

.chapter-layout__right {
  position: absolute;
  z-index: 1;
  top: 0;
  right: 0;
  display: flex;
  align-items: center;
  width: calc(50% + 30px);
  height: 100%;
  padding: var(--theme-slide-padding);
  padding-left: calc(var(--theme-slide-padding) + 40px);
  background: var(--theme-bg);
  clip-path: polygon(60px 0, 100% 0, 100% 100%, 0 100%);
}

.chapter-layout__text {
  max-width: 100%;
}

.chapter-layout__separator {
  width: var(--theme-separator-width);
  height: var(--theme-separator-thickness);
  background: var(--theme-accent);
  margin-bottom: 1.5rem;
}

.chapter-layout__title {
  font-family: var(--theme-font-title);
  font-size: 2.5rem;
  font-weight: 700;
  color: var(--theme-primary);
  margin: 0 0 0.75rem 0;
  line-height: 1.2;
}

.chapter-layout__subtitle {
  font-family: var(--theme-font-body);
  font-size: 1.25rem;
  color: var(--theme-text-light);
  margin: 0;
}

.chapter-layout__slot :deep(*) {
  margin-top: 1rem;
}
</style>
