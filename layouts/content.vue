<template>
  <div class="slidev-layout content-layout">
    <div class="content-layout__breadcrumb" v-if="$attrs.chapter">
      <span class="content-layout__chapter">{{ $attrs.chapter }}</span>
      <span class="content-layout__divider" v-if="$attrs.section">/</span>
      <span class="content-layout__section" v-if="$attrs.section">{{ $attrs.section }}</span>
    </div>
    <div class="content-layout__body">
      <slot />
    </div>
  </div>
</template>

<style scoped>
.content-layout {
  display: flex;
  flex-direction: column;
  height: 100%;
  width: 100%;
  background: var(--theme-bg);
  padding: 0;
}

.content-layout__breadcrumb {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.5rem;
  background: var(--theme-breadcrumb-bg);
  border-bottom: 1px solid var(--theme-breadcrumb-border);
  font-family: var(--theme-font-body);
  font-size: 0.875rem;
  flex-shrink: 0;
  margin: 0;
  width: 100%;
}

.content-layout__chapter {
  color: var(--theme-primary);
  font-weight: 600;
}

.content-layout__divider {
  color: var(--theme-text-light);
}

.content-layout__section {
  color: var(--theme-text-light);
}

.content-layout__body {
  flex: 1;
  padding: var(--theme-slide-padding);
  overflow: auto;
  color: var(--theme-text);
}

.content-layout__body :deep(h1) {
  font-family: var(--theme-font-title);
  font-size: 2rem;
  font-weight: 700;
  color: var(--theme-primary);
  margin: 0 0 1rem 0;
}

.content-layout__body :deep(h2) {
  font-family: var(--theme-font-title);
  font-size: 1.5rem;
  font-weight: 600;
  color: var(--theme-primary-light);
  margin: 1.5rem 0 0.75rem 0;
}

.content-layout__body :deep(ul),
.content-layout__body :deep(ol) {
  margin: 0.5rem 0;
  padding-left: 1.5rem;
}

.content-layout__body :deep(li) {
  margin: 0.25rem 0;
}

.content-layout__body :deep(code) {
  background: #edf2f7;
  padding: 0.125rem 0.375rem;
  border-radius: 0.25rem;
  font-size: 0.9em;
}
</style>
