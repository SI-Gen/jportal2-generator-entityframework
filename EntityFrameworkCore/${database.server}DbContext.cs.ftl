<#-- @ftlvariable name="table" type="bbd.jportal2.Table" -->
<#import "basefunctions.ftl" as base>
// ########################################################################################################################
// ################## Generated Code. DO NOT CHANGE THIS CODE. Change it in the generator and regenerate ##################
// ########################################################################################################################
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using ${database.packageName}.EntityFrameworkCore.Models;

namespace ${database.packageName}.EntityFrameworkCore
{
    public class ${database.name}DbContext : DbContext
    {
        public ${database.name}DbContext([NotNull] DbContextOptions options) : base(options) { }

        <#list database.getTables() as table>
        public DbSet<${table.name}Entity> ${table.name}Entity { get; set; }
        <#list table.procs as proc>
        <#if !proc.isStdExtended() && !proc.isSProc() && proc.name != "" && proc.name != "Identity" && proc.lines?size gt 0 && proc.outputs?size gt 0>
        protected DbSet<${table.name}Entity${proc.name}> ${table.name}${proc.name}Set { get; set; }
        </#if>
        </#list>
        </#list>
        protected virtual string GetTableName(string name) => name;
        protected virtual string GetSchemaName(string name) => name;
        protected virtual string MainSchema() => "${database.getSchema()}";
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            <#list database.getTables() as table>
            modelBuilder.Entity<${table.name}Entity>().ToTable(GetTableName("${table.name}"), GetSchemaName(MainSchema()))<#if !table.hasPrimaryKey>.HasNoKey()<#elseif table.hasPrimaryKey && !table.hasIdentity>.HasKey(${base.getPrimaryKeyFieldsString(table.fields)})</#if>;
            <#list table.procs as proc>
            <#if !proc.isStdExtended() && !proc.isSProc() && proc.name != "" && proc.name != "Identity" && proc.lines?size gt 0 && proc.outputs?size gt 0>
            modelBuilder.Entity<${table.name}Entity${proc.name}>().HasNoKey();
            </#if>
            </#list>
            </#list>
        }

        <#list database.getTables() as table>
        <#list table.procs as proc>
        <#if !proc.isStdExtended() && !proc.isSProc() && proc.name != "" && proc.name != "Identity" && proc.lines?size gt 0 && proc.outputs?size gt 0>
        public virtual IQueryable<${table.name}Entity${proc.name}> ${table.name}Entity${proc.name}(${base.getTypedFields(proc.inputs)})
            => ${table.name}${proc.name}Set.FromSqlInterpolated($@"<#list proc.lines as pl>
                <#if pl.isVar()>${pl.getUnformattedLine()?replace("^(_ret.*\\w)","{$1}","r")?replace(":([^[,\\s]]+)","{$1}","r")}<#else>${pl.getUnformattedLine()?replace("^(_ret.*\\w)","{$1}","r")?replace(":([^[,\\s]]+)","{$1}","r")}<#if pl.getUnformattedLine() == " ) "></#if></#if></#list>"
            );
        </#if>
        </#list>
        </#list>
        
    }
}