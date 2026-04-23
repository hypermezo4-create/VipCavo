# classes10.dex

.class public final Lcom/modcollection/customprogressbar/StorageProgressBarCOS;
.super Landroid/widget/ProgressBar;


# instance fields
.field private mContext:Landroid/content/Context;

.field private mStorageManager:Landroid/os/storage/StorageManager;

.field private mTotalMemoryByte:J


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .registers 3

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/modcollection/customprogressbar/StorageProgressBarCOS;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 4

    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Lcom/modcollection/customprogressbar/StorageProgressBarCOS;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .registers 10

    invoke-direct {p0, p1, p2, p3}, Landroid/widget/ProgressBar;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    iput-object p1, p0, Lcom/modcollection/customprogressbar/StorageProgressBarCOS;->mContext:Landroid/content/Context;

    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lcom/modcollection/customprogressbar/StorageProgressBarCOS;->mTotalMemoryByte:J

    const-string/jumbo v0, "storage"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/os/storage/StorageManager;

    iput-object p1, p0, Lcom/modcollection/customprogressbar/StorageProgressBarCOS;->mStorageManager:Landroid/os/storage/StorageManager;

    invoke-virtual {p0}, Lcom/modcollection/customprogressbar/StorageProgressBarCOS;->getAvailableMemory()J

    move-result-wide v0

    long-to-float v0, v0

    invoke-virtual {p0}, Lcom/modcollection/customprogressbar/StorageProgressBarCOS;->getTotalMemory()J

    move-result-wide v2

    long-to-float v2, v2

    div-float v0, v0, v2

    const/high16 v1, 0x3f800000  # 1.0f

    sub-float v0, v1, v0

    const/high16 v1, 0x42c80000  # 100.0f

    mul-float/2addr v0, v1

    float-to-int v0, v0

    invoke-virtual {p0, v0}, Landroid/widget/ProgressBar;->setProgress(I)V

    iget-object v0, p0, Lcom/modcollection/customprogressbar/StorageProgressBarCOS;->mContext:Landroid/content/Context;

    const-string v1, "color_bar_progress_elite"

    invoke-static {v0, v1}, Landroid/Utils/Utils;->getDrawable(Landroid/content/Context;Ljava/lang/String;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/widget/ProgressBar;->setProgressDrawable(Landroid/graphics/drawable/Drawable;)V

    return-void
.end method

.method private roundStorageSize(J)J
    .registers 11

    const-wide/16 v0, 0x1

    move-wide v2, v0

    move-wide v4, v2

    :cond_4
    :goto_4
    mul-long v6, v2, v4

    cmp-long p0, v6, p1

    if-gez p0, :cond_17

    const/4 p0, 0x1

    shl-long/2addr v2, p0

    const-wide/16 v6, 0x200

    cmp-long p0, v2, v6

    if-lez p0, :cond_4

    const-wide/16 v2, 0x3e8

    mul-long/2addr v4, v2

    move-wide v2, v0

    goto :goto_4

    :cond_17
    return-wide v6
.end method


# virtual methods
.method public getAvailableMemory()J
    .registers 12

    const-string v0, "MiuiAboutPhoneUtils"

    const/4 v1, 0x0

    const-wide/16 v2, 0x0

    :try_start_5
    iget-object v4, p0, Lcom/modcollection/customprogressbar/StorageProgressBarCOS;->mStorageManager:Landroid/os/storage/StorageManager;

    sget-object v5, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    const-string v6, "getAvailableStorageSize"

    new-array v7, v1, [Ljava/lang/Class;

    new-array v8, v1, [Ljava/lang/Object;

    invoke-static {v4, v5, v6, v7, v8}, Lcom/android/settings/utils/ReflectUtil;->callObjectMethod(Ljava/lang/Object;Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Long;

    invoke-virtual {v4}, Ljava/lang/Long;->longValue()J

    move-result-wide v4
    :try_end_19
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_19} :catch_30

    :try_start_19
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "getAvailableMemorySize -> getAvailableStorageSize: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v0, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2d
    .catch Ljava/lang/Exception; {:try_start_19 .. :try_end_2d} :catch_2e

    goto :goto_37

    :catch_2e
    move-exception v6

    goto :goto_32

    :catch_30
    move-exception v6

    move-wide v4, v2

    :goto_32
    const-string v7, "getAvailableMemorySize: "

    invoke-static {v0, v7, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_37
    cmp-long v2, v4, v2

    if-lez v2, :cond_41

    const/high16 v9, 0x44800000  # 1024.0f

    float-to-long v9, v9

    div-long/2addr v4, v9

    div-long/2addr v4, v9

    return-wide v4

    :cond_41
    const-string/jumbo v2, "support_emulated_storage"

    invoke-static {v2, v1}, Lmiui/util/FeatureParser;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    if-nez v1, :cond_71

    const-string/jumbo v1, "ro.boot.sdcard.type"

    invoke-static {v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string/jumbo v2, "mixed"

    invoke-static {v2, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_71

    invoke-static {}, Landroid/os/Environment;->getDataDirectory()Ljava/io/File;

    move-result-object v1

    new-instance v2, Landroid/os/StatFs;

    invoke-virtual {v1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v1}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Landroid/os/StatFs;->getBlockSizeLong()J

    move-result-wide v6

    invoke-virtual {v2}, Landroid/os/StatFs;->getAvailableBlocksLong()J

    move-result-wide v1

    mul-long/2addr v1, v6

    add-long/2addr v4, v1

    :cond_71
    iget-object v1, p0, Lcom/modcollection/customprogressbar/StorageProgressBarCOS;->mStorageManager:Landroid/os/storage/StorageManager;

    invoke-virtual {v1}, Landroid/os/storage/StorageManager;->getVolumes()Ljava/util/List;

    move-result-object v1

    invoke-static {}, Landroid/os/storage/VolumeInfo;->getDescriptionComparator()Ljava/util/Comparator;

    move-result-object v2

    invoke-static {v1, v2}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_82
    :goto_82
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_b8

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/os/storage/VolumeInfo;

    invoke-virtual {v2}, Landroid/os/storage/VolumeInfo;->getType()I

    move-result v3

    const/4 v6, 0x1

    if-ne v3, v6, :cond_82

    iget-object v3, p0, Lcom/modcollection/customprogressbar/StorageProgressBarCOS;->mContext:Landroid/content/Context;

    const-class v6, Landroid/app/usage/StorageStatsManager;

    invoke-virtual {v3, v6}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/app/usage/StorageStatsManager;

    :try_start_9f
    invoke-virtual {v2}, Landroid/os/storage/VolumeInfo;->getFsUuid()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v6}, Landroid/app/usage/StorageStatsManager;->getFreeBytes(Ljava/lang/String;)J

    move-result-wide v2
    :try_end_a7
    .catch Ljava/lang/Exception; {:try_start_9f .. :try_end_a7} :catch_a9

    move-wide v4, v2

    goto :goto_82

    :catch_a9
    move-exception v3

    invoke-virtual {v2}, Landroid/os/storage/VolumeInfo;->getPath()Ljava/io/File;

    move-result-object v2

    if-eqz v2, :cond_b4

    invoke-virtual {v2}, Ljava/io/File;->getUsableSpace()J

    move-result-wide v4

    :cond_b4
    invoke-virtual {v3}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_82

    :cond_b8
    const/high16 v9, 0x44800000  # 1024.0f

    float-to-long v9, v9

    div-long/2addr v4, v9

    div-long/2addr v4, v9

    return-wide v4
.end method

.method public getTotalMemory()J
    .registers 5

    iget-wide v0, p0, Lcom/modcollection/customprogressbar/StorageProgressBarCOS;->mTotalMemoryByte:J

    const-wide/16 v2, -0x1

    cmp-long v0, v0, v2

    if-nez v0, :cond_37

    :try_start_8
    iget-object v0, p0, Lcom/modcollection/customprogressbar/StorageProgressBarCOS;->mContext:Landroid/content/Context;

    const-string/jumbo v1, "storage"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/storage/StorageManager;

    const-string v1, "getPrimaryStorageSize"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    invoke-static {v0, v1, v3, v2}, Lcom/android/settings/utils/ReflectUtil;->callObjectMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/modcollection/customprogressbar/StorageProgressBarCOS;->mTotalMemoryByte:J

    invoke-virtual {p0, v0, v1}, Lcom/modcollection/customprogressbar/StorageProgressBarCOS;->roundSize(J)J

    move-result-wide v2

    iput-wide v2, p0, Lcom/modcollection/customprogressbar/StorageProgressBarCOS;->mTotalMemoryByte:J
    :try_end_2b
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_2b} :catch_2c

    goto :goto_37

    :catch_2c
    move-exception v0

    const-string v1, "MiuiAboutPhoneUtils"

    const-string v2, "getTotalMemoryBytes: error"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    :cond_37
    :goto_37
    iget-wide v0, p0, Lcom/modcollection/customprogressbar/StorageProgressBarCOS;->mTotalMemoryByte:J

    const/high16 v2, 0x44800000  # 1024.0f

    float-to-long v2, v2

    div-long/2addr v0, v2

    div-long/2addr v0, v2

    return-wide v0
.end method

.method public roundSize(J)J
    .registers 11

    const-wide/32 v0, 0x3b9aca00

    div-long v2, p1, v0

    long-to-double v2, v2

    invoke-static {v2, v3}, Ljava/lang/Math;->log(D)D

    move-result-wide v2

    const-wide/high16 v4, 0x4000000000000000L  # 2.0

    invoke-static {v4, v5}, Ljava/lang/Math;->log(D)D

    move-result-wide v6

    div-double/2addr v2, v6

    invoke-static {v2, v3}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v2

    invoke-static {v4, v5, v2, v3}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v2

    double-to-long v2, v2

    mul-long/2addr v2, v0

    cmp-long v0, v2, p1

    if-gez v0, :cond_23

    invoke-direct {p0, p1, p2}, Lcom/modcollection/customprogressbar/StorageProgressBarCOS;->roundStorageSize(J)J

    move-result-wide v2

    :cond_23
    return-wide v2
.end method
