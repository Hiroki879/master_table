CREATE TABLE master."DateCalendar" (
  "fyw_id"       varchar(100) PRIMARY KEY,
  "date"         date NOT NULL UNIQUE,
  "year"         integer NOT NULL,
  "quarter"      integer NOT NULL,
  "month"        integer NOT NULL,
  "fy_week"      integer,
  "quarter_week" integer,
  "week_start"   date,
  "week_end"     date
);

CREATE TABLE master."Platform" (
  "platform_id"                 varchar(100) PRIMARY KEY,
  "platform_name"               varchar(255),
  "s3_marketing_channel_name"   varchar(255),
  "channel_name"                varchar(255)
);

CREATE TABLE master."Segment" (
  "segment_id"   varchar(100) PRIMARY KEY,
  "segment_name" varchar(255)
);

CREATE TABLE master."Product" (
  "product_id"   varchar(100) PRIMARY KEY,
  "segment_id"   varchar(100) NOT NULL REFERENCES master."Segment"("segment_id"),
  "product_name" varchar(255)
);

CREATE TABLE master."Ddom" (
  "ddom_id"   varchar(100) PRIMARY KEY,
  "ddom_name" varchar(255)
);

CREATE TABLE master."Funding" (
  "funding_id"   varchar(100) PRIMARY KEY,
  "program_id"   varchar(100),
  "program_name" varchar(255),
  "local_global" varchar(50)
);

CREATE TABLE master."Campaign" (
  "campaign_id"   varchar(100) PRIMARY KEY,
  "campaign_name" varchar(255),
  "product_id"    varchar(100) REFERENCES master."Product"("product_id"),
  "platform_id"   varchar(100) REFERENCES master."Platform"("platform_id"),
  "segment_id"    varchar(100) REFERENCES master."Segment"("segment_id"),
  "ddom_id"       varchar(100) REFERENCES master."Ddom"("ddom_id"),
  "funding_id"    varchar(100) REFERENCES master."Funding"("funding_id"),
  "adFormat_id"   varchar(100) REFERENCES master."AdFormat"("adFormat_id")
);

CREATE TABLE master."AdGroup" (
  "ad_group_id"             varchar(100) PRIMARY KEY,
  "campaign_id"             varchar(100) NOT NULL REFERENCES master."Campaign"("campaign_id"),
  "ad_group_name"           varchar(255),
  "targeting_audience_name" varchar(255),
  "age_group"               varchar(50)
);

CREATE TABLE master."Creative" (
  "creative_id"   varchar(100) PRIMARY KEY,
  "ad_group_id"   varchar(100) NOT NULL REFERENCES master."AdGroup"("ad_group_id"),
  "creative_name" varchar(255),
  "tag"           varchar(255)
);

CREATE TABLE master."MediaPlan" (
  "media_plan_id" varchar(100) PRIMARY KEY,
  "campaign_name" varchar(255),
  "platform_id"   varchar(100) REFERENCES master."Platform"("platform_id"),
  "product_id"    varchar(100) REFERENCES master."Product"("product_id"),
  "segment_id"    varchar(100) REFERENCES master."Segment"("segment_id"),
  "ddom_id"       varchar(100) REFERENCES master."Ddom"("ddom_id"),
  "funding_id"    varchar(100) REFERENCES master."Funding"("funding_id"),
  "adFormat_id"   varchar(100) REFERENCES master."AdFormat"("adFormat_id"),
  "start_date"    date,
  "end_date"      date,
  "metric_id"     varchar(100) REFERENCES master."MetricTable"("metric_id"),
  "outlook"       float
);

CREATE TABLE master."MetricTable" (
  "metric_id"                varchar(100) PRIMARY KEY,
  "metric_name"              varchar(255) NOT NULL,
  "consolidated_metric_name" varchar(255),
  "platform_id"              varchar(100)
);

CREATE TABLE master."PlatformFactTable" (
  "fyw_id"       varchar(100) NOT NULL REFERENCES master."DateCalendar"("fyw_id"),
  "platform_id"  varchar(100),
  "product_id"   varchar(100),
  "creative_id"  varchar(100) NOT NULL REFERENCES master."Creative"("creative_id"),
  "metric_id"    varchar(100) NOT NULL REFERENCES master."MetricTable"("metric_id"),
  "value"        float,
  PRIMARY KEY ("fyw_id", "creative_id", "metric_id")
);

CREATE TABLE master."FxRate" (
  "fx_id"        varchar(100) PRIMARY KEY,
  "fiscal_year"  integer,
  "usd_jpy_rate" float
);

CREATE TABLE master."PlatformCurrency" (
  "id"          varchar(100) PRIMARY KEY,
  "platform_id" varchar(100) NOT NULL REFERENCES master."Platform"("platform_id"),
  "currency"    varchar(10),
  "week_start"  date,
  "week_end"    date,
  "year"        integer
);

CREATE TABLE master."CGEN_Activity" (
  "id"          varchar(100),
  "activity_id" varchar(100) PRIMARY KEY,
  "campaign_id" varchar(100) REFERENCES master."Campaign"("campaign_id"),
  "funding_id"  varchar(100) REFERENCES master."Funding"("funding_id")
);

CREATE TABLE master."AdFormat" (
  "adFormat_id"   varchar(100) PRIMARY KEY,
  "adFormat_name" varchar(255)
);

