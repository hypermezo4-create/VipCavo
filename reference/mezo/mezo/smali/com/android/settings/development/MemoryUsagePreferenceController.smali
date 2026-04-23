# classes3.dex

.class public Lcom/android/settings/development/MemoryUsagePreferenceController;
.super Lcom/android/settingslib/development/DeveloperOptionsPreferenceController;

# interfaces
.implements Lcom/android/settings/core/PreferenceControllerMixin;


# instance fields
.field private mProcStatsData:Lcom/android/settings/applications/ProcStatsData;


# direct methods
.method public static synthetic $r8$lambda$IUiPa6oQiRgxY85OaCxt9WjJzTM(Lcom/android/settings/development/MemoryUsagePreferenceController;Ljava/lang/String;)V
    .registers 2

    invoke-direct {p0, p1}, Lcom/android/settings/development/MemoryUsagePreferenceController;->lambda$updateState$0(Ljava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$VzHJVaTvIfPNLG8E1u9fh4rqcC4(Lcom/android/settings/development/MemoryUsagePreferenceController;)V
    .registers 1

    invoke-direct {p0}, Lcom/android/settings/development/MemoryUsagePreferenceController;->lambda$updateState$1()V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .registers 2

    invoke-direct {p0, p1}, Lcom/android/settingslib/development/DeveloperOptionsPreferenceController;-><init>(Landroid/content/Context;)V

    return-void
.end method

.method private synthetic lambda$updateState$0(Ljava/lang/String;)V
    .registers 2

    iget-object p0, p0, Lcom/android/settingslib/development/DeveloperOptionsPreferenceController;->mPreference:Landroidx/preference/Preference;

    invoke-virtual {p0, p1}, Landroidx/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    return-void
.end method

.method private synthetic lambda$updateState$1()V
    .registers 7

    iget-object v0, p0, Lcom/android/settings/development/MemoryUsagePreferenceController;->mProcStatsData:Lcom/android/settings/applications/ProcStatsData;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/android/settings/applications/ProcStatsData;->refreshStats(Z)V

    iget-object v0, p0, Lcom/android/settings/development/MemoryUsagePreferenceController;->mProcStatsData:Lcom/android/settings/applications/ProcStatsData;

    invoke-virtual {v0}, Lcom/android/settings/applications/ProcStatsData;->getMemInfo()Lcom/android/settings/applications/ProcStatsData$MemInfo;

    move-result-object v0

    iget-object v2, p0, Lcom/android/settingslib/core/AbstractPreferenceController;->mContext:Landroid/content/Context;

    iget-wide v3, v0, Lcom/android/settings/applications/ProcStatsData$MemInfo;->realUsedRam:D

    double-to-long v3, v3

    invoke-static {v2, v3, v4}, Landroid/text/format/Formatter;->formatShortFileSize(Landroid/content/Context;J)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/android/settingslib/core/AbstractPreferenceController;->mContext:Landroid/content/Context;

    iget-wide v4, v0, Lcom/android/settings/applications/ProcStatsData$MemInfo;->realTotalRam:D

    double-to-long v4, v4

    invoke-static {v3, v4, v5}, Landroid/text/format/Formatter;->formatShortFileSize(Landroid/content/Context;J)Ljava/lang/String;

    move-result-object v0

    iget-object v3, p0, Lcom/android/settingslib/core/AbstractPreferenceController;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "force_enable_pss_profiling"

    const/4 v5, 0x0

    invoke-static {v3, v4, v5}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v3

    if-ne v3, v1, :cond_2e

    goto :goto_2f

    :cond_2e
    move v1, v5

    :goto_2f
    if-eqz v1, :cond_3e

    iget-object v1, p0, Lcom/android/settingslib/core/AbstractPreferenceController;->mContext:Landroid/content/Context;

    sget v3, Lcom/android/settings/R$string;->memory_summary:I

    filled-new-array {v2, v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {v1, v3, v0}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_46

    :cond_3e
    iget-object v0, p0, Lcom/android/settingslib/core/AbstractPreferenceController;->mContext:Landroid/content/Context;

    sget v1, Lcom/android/settings/R$string;->pss_profiling_disabled:I

    invoke-virtual {v0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    :goto_46
    new-instance v1, Lcom/android/settings/development/MemoryUsagePreferenceController$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0, v0}, Lcom/android/settings/development/MemoryUsagePreferenceController$$ExternalSyntheticLambda1;-><init>(Lcom/android/settings/development/MemoryUsagePreferenceController;Ljava/lang/String;)V

    invoke-static {v1}, Lcom/android/settingslib/utils/ThreadUtils;->postOnMainThread(Ljava/lang/Runnable;)V

    return-void
.end method


# virtual methods
.method public displayPreference(Landroidx/preference/PreferenceScreen;)V
    .registers 2

    invoke-super {p0, p1}, Lcom/android/settingslib/development/DeveloperOptionsPreferenceController;->displayPreference(Landroidx/preference/PreferenceScreen;)V

    invoke-virtual {p0}, Lcom/android/settings/development/MemoryUsagePreferenceController;->getProcStatsData()Lcom/android/settings/applications/ProcStatsData;

    move-result-object p1

    iput-object p1, p0, Lcom/android/settings/development/MemoryUsagePreferenceController;->mProcStatsData:Lcom/android/settings/applications/ProcStatsData;

    invoke-virtual {p0}, Lcom/android/settings/development/MemoryUsagePreferenceController;->setDuration()V

    return-void
.end method

.method public getPreferenceKey()Ljava/lang/String;
    .registers 1

    const-string/jumbo p0, "memory"

    return-object p0
.end method

.method getProcStatsData()Lcom/android/settings/applications/ProcStatsData;
    .registers 3

    goto/32 :goto_17

    nop

    :goto_4
    const/4 v1, 0x0

    goto/32 :goto_10

    nop

    :goto_9
    iget-object p0, p0, Lcom/android/settingslib/core/AbstractPreferenceController;->mContext:Landroid/content/Context;

    goto/32 :goto_4

    nop

    :goto_f
    return-object v0

    :goto_10
    invoke-direct {v0, p0, v1}, Lcom/android/settings/applications/ProcStatsData;-><init>(Landroid/content/Context;Z)V

    goto/32 :goto_f

    nop

    :goto_17
    new-instance v0, Lcom/android/settings/applications/ProcStatsData;

    goto/32 :goto_9

    nop
.end method

.method setDuration()V
    .registers 3

    goto/32 :goto_11

    nop

    :goto_4
    const/4 v1, 0x0

    goto/32 :goto_17

    nop

    :goto_9
    return-void

    :goto_a
    invoke-virtual {p0, v0, v1}, Lcom/android/settings/applications/ProcStatsData;->setDuration(J)V

    goto/32 :goto_9

    nop

    :goto_11
    iget-object p0, p0, Lcom/android/settings/development/MemoryUsagePreferenceController;->mProcStatsData:Lcom/android/settings/applications/ProcStatsData;

    goto/32 :goto_1d

    nop

    :goto_17
    aget-wide v0, v0, v1

    goto/32 :goto_a

    nop

    :goto_1d
    sget-object v0, Lcom/android/settings/applications/ProcessStatsBase;->sDurations:[J

    goto/32 :goto_4

    nop
.end method

.method public updateState(Landroidx/preference/Preference;)V
    .registers 2

    new-instance p1, Lcom/android/settings/development/MemoryUsagePreferenceController$$ExternalSyntheticLambda0;

    invoke-direct {p1, p0}, Lcom/android/settings/development/MemoryUsagePreferenceController$$ExternalSyntheticLambda0;-><init>(Lcom/android/settings/development/MemoryUsagePreferenceController;)V

    invoke-static {p1}, Lcom/android/settingslib/utils/ThreadUtils;->postOnBackgroundThread(Ljava/lang/Runnable;)Lcom/google/common/util/concurrent/ListenableFuture;

    return-void
.end method
